import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.data == null) {
              return const Text('No Data');
            }
            final users = snapshot.data!.docs;
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  if (user['email'] !=
                      FirebaseAuth.instance.currentUser!.email) {
                    return _buildUserItem(user, context);
                  }
                  return Container();
                });
          })),
    );
  }

  Column _buildUserItem(
      QueryDocumentSnapshot<Map<String, dynamic>> user, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text(user['username']),
                subtitle: Text(user['email']),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chat_page',
                      arguments: {'receiverEmail': user['email']});
                },
                icon: const Icon(Icons.message))
          ],
        ),
        Divider(
          height: 2,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ],
    );
  }
}
