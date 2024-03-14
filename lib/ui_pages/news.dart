import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'homepage.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Article> articles = [];
  String apiKey = '3c708c4d82msh0bad64682d7e108p1621ddjsn02e1b697bade'; // Replace with your RapidAPI key

  Future<void> fetchNews() async {
    try {
      final response = await http.get(
        Uri.parse('https://news-now.p.rapidapi.com/news'),
        headers: {
          'x-rapidapi-host': 'news-now.p.rapidapi.com',
          'x-rapidapi-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          articles = (jsonData['articles'] as List)
              .map((articleJson) => Article.fromJson(articleJson))
              .toList();
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context)=> HomePage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ListTile(
            title: Text(article.title),
            subtitle: Text(article.description ?? ''),
            onTap: () {
              // Handle tapping on a news article
            },
          );
        },
      ),
    );
  }
}

class Article {
  final String title;
  final String description;

  Article({required this.title, required this.description});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
    );
  }
}
