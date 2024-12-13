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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top Right Large Circle
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                  color: Color(0xffFE724C).withOpacity(0.2),
                  shape: BoxShape.circle),
            ),
          ),
          // Top Left Small Circle
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                  color: Color(0xffFE724C).withOpacity(0.4),
                  shape: BoxShape.circle),
            ),
          ),
          // Bottom Left Circle
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                  color: Color(0xffffece7).withOpacity(0.3),
                  shape: BoxShape.circle),
            ),
          ),
          // Bottom Right Circle
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              height: 240,
              width: 240,
              decoration: BoxDecoration(
                  color: Color(0xffFE724C).withOpacity(0.2),
                  shape: BoxShape.circle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Reset Password",
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: "sp",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Please enter your email address to\nrequest a password reset",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "sp",
                      color: Color(0xff9796a1),
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 40),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Enter Registered Email Address",
                      hintStyle: TextStyle(color: Colors.grey),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.redAccent)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffFE724C)),
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
                SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFE724C),
                        fixedSize: Size(248, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      // Add your logic here
                    },
                    child: Text(
                      "Send New Password",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
