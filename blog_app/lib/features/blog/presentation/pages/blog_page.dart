import 'package:blog_app/features/blog/presentation/pages/add_new_blog.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlog.route());
              },
              icon: const Icon(Icons.add_circle_outline))
        ],
      ),
    );
  }
}
