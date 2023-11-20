import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mini_social/components/image_video_view.dart';
import 'package:flutter_mini_social/components/my_button.dart';
import 'package:flutter_mini_social/repositories/post_repositories.dart';
import 'package:flutter_mini_social/ultis/ultis.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late final TextEditingController _postController;
  File? file;
  String fileType = 'image';
  bool isLoading = false;

  @override
  void initState() {
    _postController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CREATE POST'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _postController,
                      decoration: const InputDecoration(
                        hintText: 'Say something ...!',
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    file != null
                        ? ImageVideoView(fileType: fileType, file: file!)
                        : PickFileWidget(
                            pickImage: () async {
                              fileType = 'image';
                              file = await pickImage();
                              setState(() {});
                            },
                            pickVideo: () async {
                              fileType = 'video';
                              file = await pickVideo();
                              setState(() {});
                            },
                          ),
                  ],
                ),
              ),
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : MyButton(text: 'Post', onTap: makePost)
          ],
        ),
      ),
    );
  }

  Future<void> makePost() async {
    setState(() => isLoading = true);
    await PostRepository()
        .makePost(
      content: _postController.text,
      file: file!,
      fileType: fileType,
    )
        .then((value) {
      Navigator.of(context).pop();
    }).catchError((_) {
      setState(() => isLoading = false);
    });
    setState(() => isLoading = false);
  }
}

class PickFileWidget extends StatelessWidget {
  const PickFileWidget({
    super.key,
    required this.pickImage,
    required this.pickVideo,
  });

  final VoidCallback pickImage;
  final VoidCallback pickVideo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: pickImage,
          child: Text(
            'Pick Image',
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
        ),
        const Divider(),
        TextButton(
          onPressed: pickVideo,
          child: Text(
            'Pick Video',
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
        ),
      ],
    );
  }
}
