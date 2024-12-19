import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_isaccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static route() => MaterialPageRoute(builder: (context) {
        return const SignUpPage();
      });
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onLoginSubmit() {
    if (formkey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthLoginEvent(
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
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return const Scaffold(
              //     body: Text("Success"),
              //   );
              // }));
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
                    "Sign In.",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthField(
                      hintText: "Username", controller: usernameController),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthField(
                    hintText: "Password",
                    controller: passwordController,
                    isObscure: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthButton(
                      buttonText: "Sign In",
                      onPressed: () {
                        onLoginSubmit();
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, LoginPage.route());
                    },
                    child: const AuthIsAccount(
                      text1: "Don't have an account? ",
                      text2: "Sign Up",
                    ),
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
