import 'package:flutter/material.dart';
import 'package:share_to_you/models/user.dart';
import 'package:share_to_you/views/detail_screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

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
