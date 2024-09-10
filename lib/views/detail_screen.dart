import 'package:flutter/material.dart';
import 'package:link_utils/link_utils.dart';
import 'package:share_to_you/models/user.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: '${user.id}_${user.name}',
          child: Text(user.name),
        ),
        actions: [
          Hero(
            tag: '${user.id}_${user.imageUrl}',
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.imageUrl),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.only(bottom: 24, top: 8),
        cacheExtent: MediaQuery.sizeOf(context).height * 1.5,
        itemCount: _generateUrls().length,
        itemBuilder: (context, index) {
          final url = _generateUrls()[index];
          return FutureBuilder<LinkPreviewData?>(
              future: LinkPreviewer(url: url).previewData,
              builder: (context, snapshot) {
                final previewData = snapshot.data;
                return ListTile(
                  title: Text(url),
                  subtitle: previewData != null
                      ? Container(
                          margin: const EdgeInsets.only(top: 8, left: 16),
                          padding: const EdgeInsets.all(8),
                          color: Colors.grey[200],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                previewData.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                              Text(
                                previewData.description,
                                style: const TextStyle(color: Colors.grey),
                                maxLines: 3,
                              ),
                            ],
                          ),
                        )
                      : null,
                  onTap: () {
                    // Open the URL in a browser
                  },
                );
              });
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  List<String> _generateUrls() {
    return [
      'https://patrol.leancode.co/finders/advanced',
      'https://coolors.co/3a0f80-ffbfb7-ffca7f-ffd447-b86c4d-700353-5e102a-4c1c00',
      'https://www.youtube.com/watch?v=LayKZrqYNT8&ab_channel=KaLus',
      'https://www.youtube.com/watch?v=1PzhsZ1SiCg&ab_channel=KaLus',
      'https://www.youtube.com/watch?v=GXbxwYPuGNE&ab_channel=KaLus',
      'https://www.youtube.com/watch?v=-fNs4OmcLD0&ab_channel=Ferguson-AGR',
      'https://www.youtube.com/watch?v=W1pNjxmNHNQ',
      'https://www.facebook.com/tramgora/posts/pfbid02R9Agp7kqRjmnCPizC3VkSCiLT6bhvHFUmCXsd7NJnBY5mw2DPvX2wMcMzoH8xAh9l',
      'https://www.facebook.com/tramgora/posts/pfbid02y59nyiursqqDxfR67PisQKppQihcbhDk96jvwt1RViT4JtEUucosDCDetvbGuPAxl',
      'https://www.facebook.com/tramgora/posts/pfbid023obgsV6m9EmuZCui3NuoVEHShwmZQE9bQ1AaxVnLWKXY36t5GH6fxg4fhrUebmrDl',
    ];
  }
}
