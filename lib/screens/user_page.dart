import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

import '../models/user.dart';

class UserPage extends StatelessWidget {
  static const routeName = "user_page";
  UserPage({super.key});

  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  DateTime birthdayDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: decoration('Name'),
            controller: controllerName,
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            decoration: decoration('Age'),
            keyboardType: TextInputType.number,
            controller: controllerAge,
          ),
          const SizedBox(height: 24),
          DateTimeFormField(
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: 'Birthday Date',
              ),
              initialValue: DateTime.now(),
              mode: DateTimeFieldPickerMode.date,
              autovalidateMode: AutovalidateMode.always,
              onDateSelected: (DateTime value) {
                birthdayDate = value;
              }),
          const SizedBox(height: 32),
          ElevatedButton(
            child: const Text("Create"),
            onPressed: () {
              final user = User(
                name: controllerName.text,
                age: int.parse(controllerAge.text),
                birthday: birthdayDate,
              );

              createUser(user);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  InputDecoration decoration(String inputText) {
    return InputDecoration(
      labelText: inputText,
      border: const OutlineInputBorder(),
    );
  }

  Future<void> createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection("users").doc();
    user.id = docUser.id;
    await docUser.set(user.toJson());
  }
}
