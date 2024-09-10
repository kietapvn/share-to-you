import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Shared files:",
              style: textStyleBold,
            ),
            const SizedBox(height: 8),
            Text(sharedFiles
                .map((f) => f.toMap())
                .join(",\n****************\n")),
          ],
        ),
      ),
    );
  }
}
