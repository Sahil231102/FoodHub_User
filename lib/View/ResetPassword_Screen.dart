import 'package:flutter/material.dart';

class ResetpasswordScreen extends StatefulWidget {
  const ResetpasswordScreen({super.key});

  @override
  State<ResetpasswordScreen> createState() => _ResetpasswordScreenState();
}

class _ResetpasswordScreenState extends State<ResetpasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                "Reset Password",
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: "sp",
                    fontWeight: FontWeight.bold),
              )),
          Positioned(
              top: 230,
              left: 25,
              child: Text(
                "Please enter your email address to\nrequest a password reset",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "sp",
                    color: Color(0xff9796a1),
                    fontWeight: FontWeight.normal),
              )),
          Positioned(
            top: 300,
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
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
          ),
          Positioned(
            top: 400,
            left: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(
                    0xffFE724C,
                  ),
                  fixedSize: Size(248, 60)),
              onPressed: () {},
              child: Text(
                "Send new password",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
