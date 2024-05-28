// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_blog/core/utils/spacer.dart';

import 'package:mini_blog/features/blog/domain/entities/blog.dart';

class ViewBlogPage extends StatelessWidget {
  const ViewBlogPage({
    super.key,
    required this.blog,
  });

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(16),
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back)),
                verticalSpace(16),
                Text(
                  blog.title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                verticalSpace(16),
                Text(
                  "By ${blog.posterName!}",
                  style: const TextStyle(fontSize: 14),
                ),
                verticalSpace(4),
                Text(
                  'Published at ${DateFormat('dd MMM, yyyy').format(blog.updatedAt)}',
                  style: const TextStyle(fontSize: 14),
                ),
                verticalSpace(16),
                Image.network(blog.imageUrl),
                verticalSpace(16),
                Text(blog.content)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
