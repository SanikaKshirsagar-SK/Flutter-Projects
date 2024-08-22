import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Create your Account",
                style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 35 / 20,
                    color: Color.fromRGBO(0, 0, 0, 1)),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(children: [
                  Container(
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
                        controller: nameController,
                        decoration: const InputDecoration(
                            hintText: "Name",
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
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
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
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "Confirm Password",
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
                ]),
              ),
              const SizedBox(
                height: 30,
              ),
              //const Spacer(),
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
                      backgroundColor: const Color.fromARGB(255, 15, 1, 15),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await _auth.createUserWithEmailAndPassword(
                            email: usernameController.text,
                            password: passwordController.text,
                          );
                          // Navigate to login page after successful sign up
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        } on FirebaseAuthException catch (e) {
                          // Handle sign up errors
                          log('Error: $e');
                        }
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ",
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 18 / 12,
                          color: Color.fromRGBO(0, 0, 0, 0.6))),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Login()));
                    },
                    child: const Text("Sign In",
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            height: 18 / 12,
                            color: Color.fromARGB(255, 15, 1, 15))),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
