import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_isaccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onSignUpSubmit() {
    if (formkey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthSignUpEvent(
          name: nameController.text,
          email: usernameController.text.trim(),
          password: passwordController.text.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          } else if (state is AuthSuccess) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LoginPage();
            }));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up.",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthField(
                  controller: nameController,
                  hintText: "Name",
                ),
                const SizedBox(
                  height: 15,
                ),
                AuthField(
                  controller: usernameController,
                  hintText: "Username",
                ),
                const SizedBox(
                  height: 15,
                ),
                AuthField(
                  controller: passwordController,
                  hintText: "Password",
                  isObscure: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthButton(
                    buttonText: "Sign Up",
                    onPressed: () {
                      onSignUpSubmit();
                    }),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, SignUpPage.route());
                  },
                  child: const AuthIsAccount(
                    text1: "Already have an account? ",
                    text2: "Sign In",
                  ),
                )
              ],
            ),
          );
        },
      ),
    ));
  }
}
