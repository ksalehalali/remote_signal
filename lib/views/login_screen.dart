import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(48.0),
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                      hintText: "Enter your username"
                  ),
                ),
              ),
              SizedBox(height: 40,),
              ElevatedButton(onPressed: (){}, child: Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}
