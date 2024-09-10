import 'dart:async';

import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:share_to_you/models/user.dart';
import 'package:share_to_you/views/detail_screen.dart';
import 'package:share_to_you/views/shared_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late StreamSubscription _intentSub;

  @override
  void initState() {
    super.initState();

    // Listen to media sharing coming from outside the app while the app is in the memory.
    _intentSub =
        ReceiveSharingIntent.instance.getMediaStream().listen((sharedFiles) {
      final context = this.context;
      if (!context.mounted || sharedFiles.isEmpty) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SharedScreen(sharedFiles: sharedFiles),
        ),
      );
    }, onError: (err) {
      print("getIntentDataStream error:: $err");
    });

    // Get the media sharing coming from outside the app while the app is closed.
    ReceiveSharingIntent.instance.getInitialMedia().then((sharedFiles) {
      setState(() {
        final context = this.context;
        if (!context.mounted || sharedFiles.isEmpty) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SharedScreen(sharedFiles: sharedFiles),
          ),
        );

        // Tell the library that we are done processing the intent.
        ReceiveSharingIntent.instance.reset();
      });
    });
  }

  @override
  void dispose() {
    _intentSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const ListBody();
  }
}

class ListBody extends StatelessWidget {
  const ListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: _generate().length,
        itemBuilder: (context, index) {
          final user = _generate()[index];
          return ListTile(
            leading: Hero(
              tag: '${user.id}_${user.imageUrl}',
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.imageUrl),
              ),
            ),
            title: Text(user.name),
            subtitle: Text(user.email),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(user: user),
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<User> _generate() {
    return List.generate(10, (index) {
      return User(
        id: index,
        name: 'User ${index + 1}',
        email: 'random${index + 1}.mail@email.com',
        imageUrl: 'https://avatar.iran.liara.run/public',
      );
    });
  }
}
