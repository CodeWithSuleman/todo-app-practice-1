import 'package:flutter/material.dart';
import 'package:todo_app_practice/models/todo.dart';
import 'package:todo_app_practice/services/firebase_crud.dart';

class UpdateUserAlertBox extends StatefulWidget {
  final String age;
  final String id;
  final String name;

  const UpdateUserAlertBox(
      {super.key, required this.id, required this.name, required this.age});

  @override
  State<UpdateUserAlertBox> createState() => _UpdateUserAlertBoxState();
}

class _UpdateUserAlertBoxState extends State<UpdateUserAlertBox> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    idController.text = widget.id;
    nameController.text = widget.name;
    ageController.text = widget.age;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: height * 0.1),
            AlertDialog(
              title: Column(
                children: [
                  const Text("Please Fill the Fields"),
                  SizedBox(height: height * 0.02),
                  TextFormField(
                    readOnly: true,
                    controller: idController,
                    decoration: InputDecoration(
                        label: const Text('Enter id'),
                        hintText: "Enter Your id",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    controller: nameController,
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
                            FirebaseCRUD().updateUser(User(
                              id: idController.text,
                              name: nameController.text,
                              age: ageController.text,
                            ));
                            Navigator.pop(context);
                          },
                          child: const Text("Update"))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
