import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:share_to_you/views/detail_screen.dart';

class SharedScreen extends StatelessWidget {
  const SharedScreen({
    super.key,
    required this.sharedFiles,
  });

  final List<SharedMediaFile> sharedFiles;

  @override
  Widget build(BuildContext context) {
    print("Shared files: ${sharedFiles.length}");
    print(sharedFiles.map((f) => f.toMap()));

    const textStyleBold = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared data'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Shared data:",
                style: textStyleBold,
              ),
            ),
            for (final file in sharedFiles)
              if (file.path.startsWith('http'))
                LinkPreviewerWidget(url: file.path)
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(file.toMap().toString()),
                ),
          ],
        ),
      ),
    );
  }
}
