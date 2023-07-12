import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_practice/screens/home_screen.dart';
import 'package:todo_app_practice/screens/signup_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void logInUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      // print("Fill The Blanks");
      const Text("please fill the blanks");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        }
      } on FirebaseAuthException catch (ex) {
        print(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: height * 0.2),
              Image.asset("assets/images/login.png"),
              SizedBox(height: height * 0.04),
              const Text(
                "LogIn To Your Account",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: height * 0.04),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    label: const Text('Enter email'),
                    hintText: "Enter Your Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: height * 0.04),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    label: const Text('Enter passwor'),
                    hintText: "Enter Your Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: height * 0.04),
              ElevatedButton(
                  onPressed: () {
                    logInUser();
                  },
                  child: const Text("Login")),
              SizedBox(height: height * 0.04),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ));
                  },
                  child: const Text("Create An Account",
                      style: TextStyle(fontSize: 18))),
            ],
          ),
        ),
      ),
    );
  }
}
