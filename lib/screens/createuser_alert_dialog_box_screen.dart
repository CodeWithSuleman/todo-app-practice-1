import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/firebase_crud.dart';

class CreatUserAlertBox extends StatefulWidget {
  const CreatUserAlertBox({super.key});

  @override
  State<CreatUserAlertBox> createState() => _AlertBoxState();
}

class _AlertBoxState extends State<CreatUserAlertBox> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.1),
            AlertDialog(
              title: Column(
                children: [
                  const Text("Please Fill the Fields"),
                  SizedBox(height: height * 0.02),
                  TextFormField(
                    controller: idController,
                    //  initialValue: idController.text,
                    decoration: InputDecoration(
                        label: const Text('Enter id'),
                        hintText: "Enter Your id",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    controller: nameController,
                    //initialValue: nameController.text,
                    decoration: InputDecoration(
                        label: const Text('Enter name'),
                        hintText: "Enter Your name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(
                        label: const Text('Enter age'),
                        hintText: "Enter Your age",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      color: Colors.limeAccent,
                      child: TextButton(
                          onPressed: () {
                            FirebaseCRUD().createUser(User(
                              id: idController.text,
                              name: nameController.text,
                              age: ageController.text,
                            ));
                            Navigator.pop(context);
                          },
                          child: const Text("Submit"))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
