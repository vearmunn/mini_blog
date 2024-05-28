// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mini_blog/core/theme/app_pallete.dart';
import 'package:mini_blog/core/utils/show_snackbar.dart';
import 'package:mini_blog/core/utils/spacer.dart';
import 'package:mini_blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mini_blog/features/auth/presentation/widgets/auth_button.dart';
import 'package:mini_blog/features/auth/presentation/widgets/auth_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  verticalSpace(30),
                  AuthTextField(
                    hint: 'Name',
                    controller: nameController,
                  ),
                  verticalSpace(15),
                  AuthTextField(
                    hint: 'Email',
                    controller: emailController,
                  ),
                  verticalSpace(15),
                  AuthTextField(
                    hint: 'Password',
                    controller: passwordController,
                    obscure: true,
                  ),
                  verticalSpace(30),
                  AuthButton(
                      text: "Sign Up",
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignUp(
                              nameController.text.trim(),
                              emailController.text.trim(),
                              passwordController.text.trim()));
                        }
                      }),
                  verticalSpace(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              color: AppPallete.gradient2,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}