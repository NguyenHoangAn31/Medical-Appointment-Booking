import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenScreenState();
}

class _BlogScreenScreenState extends State<BlogScreen> {
  List<Article> articles = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.2:8080/api/news/all'));

    if (response.statusCode == 200) {
      final List<dynamic> articleJson = json.decode(response.body);
      setState(() {
        articles = articleJson.map((json) => Article.fromJson(json)).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('My Blog',
              style: TextStyle(color: Colors.black, fontSize: 22)),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz_sharp),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < articles.length; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 50,
                                  child: Image.network(
                                    articles[i].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    articles[i].title,
                                    maxLines: 2, // Giới hạn số dòng là 2
                                    overflow: TextOverflow
                                        .ellipsis, // Xử lý khi vượt quá số dòng giới hạn
                                    style: const TextStyle(
                                        fontSize: 18, fontFamily: 'Roboto'),
                                  ),
                                ),
                              ],
                            ),
                            if (i !=
                                articles.length -
                                    1) // Thêm Divider nếu không phải bài viết cuối cùng
                              Divider(
                                thickness: 1, // Độ dày của Divider
                                color: Colors.grey[300], // Màu sắc của Divider
                                height:
                                    20, // Khoảng cách giữa Divider và các mục
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String image;

  Article({
    required this.title,
    required this.image,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      image: json['image'],
    );
  }
}
