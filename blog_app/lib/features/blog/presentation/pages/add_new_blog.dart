import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlog extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const AddNewBlog());
  const AddNewBlog({super.key});

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, BlogPage.route());
            },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            DottedBorder(
              color: AppPallet.borderColor,
              dashPattern: const [10, 4],
              radius: const Radius.circular(10),
              borderType: BorderType.RRect,
              strokeCap: StrokeCap.round,
              child: Container(
                height: 150,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.folder_copy_outlined)),
                        const SizedBox(height: 35,),
                    const Text("Select your images")
                  ],
                ),
              ),
              
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  "Technology",
                  "Business",
                  "Programming",
                  "Entertainment"
                ].map((e) => Chip(label: Text(e))).toList()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
