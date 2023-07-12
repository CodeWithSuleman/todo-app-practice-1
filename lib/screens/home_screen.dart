import 'package:flutter/material.dart';

import 'package:todo_app_practice/screens/updateuser_alert_dialog_box_screen.dart';
import 'package:todo_app_practice/services/firebase_crud.dart';
import 'createuser_alert_dialog_box_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: FutureBuilder(
            future: FirebaseCRUD().getUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                            isThreeLine: true,
                            leading: Text('Id: ${snapshot.data![index].id}'),
                            title: Text('name: ${snapshot.data![index].name}'),
                            subtitle: Text('age: ${snapshot.data![index].age}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: width * 0.05),

                                ///User Updated!!!!!!

                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              UpdateUserAlertBox(
                                                  id: snapshot.data![index].id,
                                                  name: snapshot
                                                      .data![index].name,
                                                  age: snapshot
                                                      .data![index].age));
                                    },
                                    icon: const Icon(Icons.edit)),

                                ///User Deleted!!!!!!

                                IconButton(
                                    onPressed: () {
                                      FirebaseCRUD()
                                          .deleteUser(snapshot.data![index].id);
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            shape: Border.all(
                              color: Colors.deepPurpleAccent,
                            )),
                      ],
                    );
                  },
                );
              }
              return const Text('No Data Found');
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (ctx) => const CreatUserAlertBox());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
