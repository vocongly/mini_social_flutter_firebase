import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mini_social/components/chat_bubble.dart';
import 'package:flutter_mini_social/components/my_textfield.dart';
import 'package:flutter_mini_social/databases/firebase_database.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
import 'package:record/record.dart';

class ChatComponnent extends StatefulWidget {
  const ChatComponnent({super.key, required this.receiverEmail});
  final String receiverEmail;

  @override
  State<ChatComponnent> createState() => _ChatComponnentState();
}

class _ChatComponnentState extends State<ChatComponnent> {
  final TextEditingController messageController = TextEditingController();
  final FirebaseDatabase firebaseDatabase = FirebaseDatabase();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final FocusNode _focus = FocusNode();

  bool isTyping = false;

  File? image;

  File? audioFile;

  String? imageUrl;

  String? audioUrl;

  late Record audioRecord;
  late AudioPlayer audioPlayer;

  bool isRecording = false;

  String? audioPath;

  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    audioRecord = Record();
    audioPlayer = AudioPlayer();
    super.initState();
    initRecoder();
  }

  @override
  void dispose() {
    messageController.dispose();
    _focus.dispose();
    audioRecord.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print('Error Start Recording : $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        isRecording = false;
        audioPath = path!;
        audioFile = File(audioPath!);
      });
      print(audioPath);
    } catch (e) {
      print('Error Stop Recording : $e');
    }
  }

  Future<void> playRecording() async {
    try {
      Source source = UrlSource(audioPath!);
      print(source);
      await audioPlayer.play(source);
    } catch (e) {
      print('Error play Recording : $e');
    }
  }

  Future initRecoder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      setState(() {
        isTyping = true;
      });
    }
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await firebaseDatabase.sendMessage(
          messageController.text, widget.receiverEmail);
    }
    messageController.clear();
  }

  void unTyping() {
    setState(() {
      isTyping = false;
    });
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source, imageQuality: 20);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      // String imagebase64 = convertImageToBase64(imageTemporary);
      // print(imagebase64);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  String convertImageToBase64(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  uploadImage() async {
    final firebaseStorage = FirebaseStorage.instance;
    //Check Permissions
    // await Permission.photos.request();

    // var permissionStatus = await Permission.photos.status;

    // if (permissionStatus.isGranted) {
    //   //Select Image

    //   if (image != null) {
    //     //Upload to Firebase
    //     var snapshot = await firebaseStorage
    //         .ref()
    //         .child('images/imageName')
    //         .putFile(image!);
    //     var downloadUrl = await snapshot.ref.getDownloadURL();
    //     setState(() {
    //       imageUrl = downloadUrl;
    //     });
    //     print(imageUrl);
    //   } else {
    //     print('No Image Path Received');
    //   }
    // } else {
    //   print('Permission not granted. Try Again with permission access');
    // }

    if (image != null) {
      String filename = basename(image!.toString());

      var snapshot =
          await firebaseStorage.ref().child('images/$filename').putFile(image!);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });

      await firebaseDatabase.sendImage(imageUrl!, widget.receiverEmail);
    }
  }

  uploadAudioToFirebase() async {
    final firebaseStorage = FirebaseStorage.instance;
    if (audioPath != null) {
      String filename = basename(audioPath!);

      var snapshot = await firebaseStorage
          .ref()
          .child('audio/$filename')
          .putFile(audioFile!);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      print('audio url: $downloadUrl');
      setState(() {
        audioUrl = downloadUrl;
      });

      await firebaseDatabase.sendAudio(audioUrl!, widget.receiverEmail);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: isTyping,
          child: IconButton(
              onPressed: unTyping,
              icon: const Icon(Icons.keyboard_arrow_right)),
        ),
        Visibility(
          visible: !isTyping,
          child: Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await Permission.camera.request();
                    await pickImage(ImageSource.camera);
                    uploadImage();
                  },
                  icon: const Icon(Icons.camera_alt)),
              IconButton(
                  onPressed: () async {
                    await Permission.photos.request();
                    await pickImage(ImageSource.gallery);
                    uploadImage();
                  },
                  icon: const Icon(Icons.image)),
              IconButton(
                  onPressed: () async {
                    if (isRecording) {
                      await stopRecording();
                    } else {
                      await startRecording();
                    }
                  },
                  icon: Icon(isRecording ? Icons.stop : Icons.mic)),
              // IconButton(
              //     onPressed: () async {
              //       await playRecording();
              //     },
              //     icon: const Icon(Icons.play_arrow)),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: MyTextField(
                hintText: 'Aa',
                obscureText: false,
                focusNode: _focus,
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    setState(() {
                      isTyping = true;
                    });
                  }
                },
                controller: messageController),
          ),
        ),
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.send))
      ],
    );
  }
}
