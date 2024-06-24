import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../ultils/ip_app.dart';
import 'package:mobile/screens/blog/blog_detail_screen.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenScreenState();
}

class _BlogScreenScreenState extends State<BlogScreen> {
  final ipDevice = BaseClient().ip;

  List<Article> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    final response =
        await http.get(Uri.parse('http://$ipDevice:8080/api/news/all'));

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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          'My Blog',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz_sharp),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FutureBuilder<String>(
                        future: getImageUrl(articles[index].image),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              width: 150,
                              // height: 80,
                              color: Colors.grey[200],
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else if (snapshot.hasError) {
                            return Container(
                              width: 150,
                              // height: 80,
                              color: Colors.grey[200],
                              child: Center(child: Icon(Icons.error)),
                            );
                          } else if (snapshot.hasData) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    articles[index].title,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: 'Roboto'),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container(
                              // width: 300,
                              // height: 50,
                              color: Colors.grey[200],
                            );
                          }
                        },
                      ),
                      // SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          // Xử lý khi nhấn nút "Read more"
                          navigateToArticleDetail(articles[index]);
                        },
                        child: Text(
                          'Read more',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      if (index != articles.length - 1)
                        Divider(
                          thickness: 1,
                          color: Colors.grey[300],
                          height: 20,
                        ),
                    ],
                  );
                },
              ),
            ),
    );
  }

  Future<String> getImageUrl(String? imagePath) async {
    if (imagePath == null || imagePath.isEmpty) {
      return ''; // Trả về chuỗi rỗng nếu không có đường dẫn hình ảnh
    }

    final response = await http
        .get(Uri.parse('http://$ipDevice:8080/images/news/$imagePath'));

    if (response.statusCode == 200) {
      return 'http://$ipDevice:8080/images/news/$imagePath';
    } else {
      throw Exception('Failed to load image');
    }
  }

  void navigateToArticleDetail(Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlogDetailScreen(
          title: article.title,
          imageUrl: 'http://$ipDevice:8080/images/news/${article.image}',
          content: article.content ?? '',
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String? image;
  final String? content;

  Article({
    required this.title,
    required this.image,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      image: json['image'],
      content: json['content'],
    );
  }
}
