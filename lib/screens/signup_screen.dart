import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_practice/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passworController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void createUserForSignUp() async {
    String email = emailController.text.trim();
    String password = passworController.text.trim();
    String conifrmPassword = confirmPasswordController.text.trim();
    if (email.isEmpty || password.isEmpty || conifrmPassword.isEmpty) {
      const Text("Fill The blanks");
    } else if (password != conifrmPassword) {
      const Text("password do Not match");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        const Text("User Created");
        if (userCredential.user != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LogInScreen(),
              ));
        }
      } on FirebaseAuthException catch (ex) {
        Text(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.2),
              Image.asset("assets/images/login.png"),
              SizedBox(height: height * 0.04),
              const Text(
                "SignUp To Your Account",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: height * 0.04),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    label: const Text('Enter Email'),
                    hintText: "Enter Your Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: height * 0.04),
              TextFormField(
                controller: passworController,
                decoration: InputDecoration(
                    label: const Text('Enter Password'),
                    hintText: "Enter Your Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: height * 0.04),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                    label: const Text('Enter confirm Password'),
                    hintText: "Enter Confirm Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: height * 0.04),
              ElevatedButton(
                  onPressed: () {
                    createUserForSignUp();
                  },
                  child: const Text("SignUp")),
              SizedBox(height: height * 0.04),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogInScreen(),
                        ));
                  },
                  child: const Text(
                    "Already have an Account",
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
