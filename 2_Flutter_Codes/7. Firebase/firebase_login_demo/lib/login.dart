import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firestoredatabase.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Firebase Login",
          style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w900,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 15, 1, 15),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Login to your Account",
            style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 24 / 16,
                color: Color.fromRGBO(0, 0, 0, 1)),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset(0, 3),
                            color: Color.fromRGBO(0, 0, 0, 0.15)),
                      ]),
                  child: TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          hintText: "Username",
                          hintStyle: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 18 / 12,
                              color: Color.fromRGBO(0, 0, 0, 0.4)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide.none))),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset(0, 3),
                            color: Color.fromRGBO(0, 0, 0, 0.15)),
                      ]),
                  child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 18 / 12,
                              color: Color.fromRGBO(0, 0, 0, 0.4)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide.none))),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
              height: 49,
              width: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 128, 60, 128),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await _auth.signInWithEmailAndPassword(
                        email: usernameController.text,
                        password: passwordController.text,
                      );
                      // Navigate to home page after successful login
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      // Handle login errors
                      log('Error: $e');
                    }
                  }
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Colors.white),
                ),
              )),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("New User? Click Here To Register..  ",
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 18 / 12,
                      color: Color.fromRGBO(0, 0, 0, 1))),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: const Text("Sign Up",
                    style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        height: 18 / 12,
                        color: Color.fromRGBO(0, 0, 0, 1))),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

