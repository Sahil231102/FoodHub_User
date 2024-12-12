import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                top: 130,
                left: 25,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 42,
                      fontFamily: "sp",
                      fontWeight: FontWeight.bold),
                )),
            Positioned(
                top: 200,
                left: 30,
                child: Text(
                  "Full Name",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "sp",
                      color: Color(0xff9796a1),
                      fontWeight: FontWeight.normal),
                )),
            Positioned(
              top: 230,
              left: 25,
              right: 25,
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFE724C)),
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            ),
            Positioned(
                top: 300,
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
              top: 330,
              left: 25,
              right: 25,
              child: TextFormField(
                decoration: InputDecoration(
                    focusColor: Colors.amber,
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFE724C)),
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            ),
            Positioned(
                top: 400,
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
              top: 430,
              left: 25,
              right: 25,
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove_red_eye_outlined),
                    ),
                    focusColor: Colors.amber,
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFE724C)),
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            ),
            Positioned(
              bottom: 150,
              left: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(
                      0xffFE724C,
                    ),
                    fixedSize: Size(248, 60)),
                onPressed: () {},
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: 65,
              child: Row(
                children: [
                  Text("Already have an Account?"),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Login",
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
