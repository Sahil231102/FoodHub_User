import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -80,
              child: Container(
                height: 120,
                width: 204,
                decoration: BoxDecoration(
                    color: Color(0xffFE724C), shape: BoxShape.circle),
              ),
            ),
            Positioned(
              top: -10,
              left: -60,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    color: Color(0xffFE724C), shape: BoxShape.circle),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -120,
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  color: Color(0xffffece7),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
                top: 180,
                left: 25,
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 42,
                      fontFamily: "sp",
                      fontWeight: FontWeight.bold),
                )),
            Positioned(
                top: 250,
                left: 30,
                child: Text(
                  "Email",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "sp",
                      color: Color(0xff9796a1),
                      fontWeight: FontWeight.normal),
                )),
            Positioned(
              top: 280,
              left: 25,
              right: 25,
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Enter Register Email Address",
                    hintStyle: TextStyle(color: Colors.grey),
                    focusColor: Colors.amber,
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFE724C)),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Positioned(
                top: 350,
                left: 30,
                child: Text(
                  "Password",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "sp",
                      color: Color(0xff9796a1),
                      fontWeight: FontWeight.normal),
                )),
            Positioned(
              top: 380,
              left: 25,
              right: 25,
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Enter Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove_red_eye_outlined),
                    ),
                    focusColor: Colors.amber,
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFE724C)),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Positioned(
              top: 430,
              right: 20,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Color(0xffFE724C), fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: 550,
              left: 50,
              child: SingleChildScrollView(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        0xffFE724C,
                      ),
                      fixedSize: Size(248, 60)),
                  onPressed: () {},
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 650,
              left: 65,
              child: Row(
                children: [
                  Text("Don't Have an Account?"),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Color(0xffFE724C),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
