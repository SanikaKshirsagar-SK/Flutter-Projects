import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _data = '';
  Future<void> _getDataFromFirestore() async {
    final docRef = _firestore.collection('userinfo').doc('user1');
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      final data = docSnap.data();
      setState(() {
        _data = data!['email']; // Replace 'fieldName' with the actual field name
      });
    } else {
      log('No such document');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Firestore Data"),
      ),
      body: Center(
          child:
              // ElevatedButton(onPressed: () {
              //     _getDataFromFirestore();
              //   }

              // , child: const Icon(Icons.add_box_outlined),)
              Text(_data)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          firestoredata();
          _getDataFromFirestore();
        },
      ),
    );
  }
}

Future<void> firestoredata() async {
  // Initialize Firestore
  final firestore = FirebaseFirestore.instance;

  // Create a reference to the users collection
  final usersCollection = firestore.collection('userinfo');

  // Create a reference to the students collection
  final studentsCollection = firestore.collection('students');

  final friendsCollection = firestore.collection('friends');

  final userDocument = usersCollection.doc('');
  await userDocument.set({
    'name': 'Sanika',
    'email': 'Sanika1@gmail.com',
  });
  // Create a new user document
  final friendDocument = friendsCollection.doc('friend1');
  await friendDocument.set({
    'name': 'Aaru',
    'email': 'Aaru@gmail.com',
  });
  final userDocument1 = usersCollection.doc('user2');
  await userDocument1.set({
    'name': 'Shreya',
    'email': 'Shreya@gmail.com',
  });

  // Create a new student document
  final studentDocument = studentsCollection.doc('student1');
  await studentDocument.set({
    'name': 'Rhea',
    'grade': 'A',
  });
  final studentDocument1 = studentsCollection.doc('student2');

  await studentDocument1.set({
    'name': 'Shreya',
    'grade': 'A+',
  });
  final studentDocument2 = studentsCollection.doc('student3');
  await studentDocument2.set({
    'name': 'Shruti',
    'grade': 'A++',
  });
}
