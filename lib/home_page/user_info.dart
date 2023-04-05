import 'package:flutter/material.dart';
import 'package:project/workout_page/workout_data.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  String userName;
  UserInfo({super.key, required this.userName});

  @override
  State<StatefulWidget> createState() => _UserInfo();
}

class _UserInfo extends State<UserInfo> {
  final _formKey = GlobalKey<FormState>();
  final newUserName = TextEditingController();

  void changeUserName() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text("User Name"),
                content: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: newUserName,
                      validator: (value) {
                        return value!.isNotEmpty ? null : "Invalid Field";
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter the your name"),
                    )),
                actions: [
                  // Cancel btn
                  MaterialButton(
                    onPressed: cancel,
                    child: const Text("Cancel"),
                  ),
                  // Save btn
                  MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        save();
                      }
                    },
                    child: const Text("Save"),
                  ),
                ]));
  }

  void save() {
    String uName = newUserName.text;
    Provider.of<WorkoutData>(context, listen: false).changeUserInfo(uName);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newUserName.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 90,
        margin: const EdgeInsets.all(10),
        child: TextButton(
            onPressed: changeUserName,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(children: [
                Text("Hi, ${widget.userName}",
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const Text("Let's check your workout!",
                    style: TextStyle(fontSize: 20, color: Colors.black))
              ]),
              Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/3364/3364044.png"),
                    backgroundColor: Colors.white,
                    radius: 30,
                  ))
            ])));
  }
}
