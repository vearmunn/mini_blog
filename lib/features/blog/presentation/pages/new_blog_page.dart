import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mini_blog/core/common/widgets/my_button.dart';
import 'package:mini_blog/core/theme/app_pallete.dart';
import 'package:mini_blog/core/utils/pick_image.dart';
import 'package:mini_blog/core/utils/show_snackbar.dart';
import 'package:mini_blog/core/utils/spacer.dart';
import 'package:mini_blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:mini_blog/features/blog/presentation/pages/blog_page.dart';
import 'package:mini_blog/features/blog/presentation/widgets/blog_textfield.dart';

class NewBlogPage extends StatefulWidget {
  const NewBlogPage({super.key});

  @override
  State<NewBlogPage> createState() => _NewBlogPageState();
}

late TextEditingController titleController;
late TextEditingController contentController;

class _NewBlogPageState extends State<NewBlogPage> {
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  List<String> topics = [
    'Business',
    'Technology',
    'Programming',
    'Entertainment'
  ];

  List<String> selectedTopics = [];
  File? image;
  final formKey = GlobalKey<FormState>();

  Future selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("New Blog"),
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.message);
            print(state.message);
          } else if (state is BlogUploadSuccess) {
            showSnackBar(context, 'Blog published!');
            titleController.clear();
            contentController.clear();
            selectedTopics = [];
            image = null;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const BlogPage()),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                                width: double.infinity,
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                )),
                          )
                        : GestureDetector(
                            onTap: selectImage,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              padding: const EdgeInsets.all(10),
                              color: AppPallete.borderColor,
                              dashPattern: const [10, 4],
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open,
                                        size: 50,
                                      ),
                                      verticalSpace(8),
                                      const Text(
                                        'Select your image',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppPallete.greyColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    verticalSpace(20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: topics
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedTopics.contains(e)) {
                                        selectedTopics.remove(e);
                                      } else {
                                        selectedTopics.add(e);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Chip(
                                      label: Text(e),
                                      backgroundColor:
                                          selectedTopics.contains(e)
                                              ? AppPallete.gradient1
                                              : Colors.transparent,
                                      side: BorderSide(
                                          color: AppPallete.borderColor,
                                          width: selectedTopics.contains(e)
                                              ? 0
                                              : 1),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    verticalSpace(20),
                    BlogTextFormField(
                        hint: 'Title', controller: titleController),
                    verticalSpace(20),
                    BlogTextFormField(
                        hint: 'Content', controller: contentController),
                    verticalSpace(30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: MyButton(
          text: 'Publish',
          onTap: () async {
            if (formKey.currentState!.validate() &&
                selectedTopics.isNotEmpty &&
                image != null) {
              final posterId =
                  (context.read<AppUserCubit>().state as AppUserLoggedIn)
                      .user
                      .id;
              context.read<BlogBloc>().add(PostBlog(
                  posterId: posterId,
                  title: titleController.text,
                  content: contentController.text,
                  image: image!,
                  topics: selectedTopics));
            }
          }),
    );
  }
}
