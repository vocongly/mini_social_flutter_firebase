import 'package:flutter/material.dart';
import 'package:flutter_mini_social/components/my_drawer.dart';
import 'package:flutter_mini_social/components/my_post_button.dart';
import 'package:flutter_mini_social/components/my_textfield.dart';
import 'package:flutter_mini_social/databases/firebase_database.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirebaseDatabase firebase = FirebaseDatabase();

  final TextEditingController postController = TextEditingController();

  void postMessage() {
    if (postController.text.isNotEmpty) {
      String message = postController.text;
      firebase.addPost(message);
    }
    postController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('W A L L'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                      hintText: 'Say something ...',
                      obscureText: false,
                      controller: postController),
                ),
                const SizedBox(
                  width: 8,
                ),
                MyPostButton(onTap: postMessage)
              ],
            ),
          ),
          StreamBuilder(
              stream: firebase.getPostsStream(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final posts = snapshot.data!.docs;
                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                    child: Text('No posts! Say something'),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return ListTile(
                          title: Text(post['Message']),
                          subtitle: Text(post['UserEmail']),
                        );
                      }),
                );
              }))
        ],
      ),
    );
  }
}
