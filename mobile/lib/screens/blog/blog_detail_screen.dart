import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BlogDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String content;

  const BlogDetailScreen({super.key,
    required this.title,
    required this.imageUrl,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            const SizedBox(height: 20),
            Html(data: content),
          ],
        ),
      ),
    );
  }
}
