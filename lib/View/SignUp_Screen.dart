import 'package:flutter/material.dart';
import 'package:food_hub_user/View/Login_Screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Your Full Name";
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Enter Your Full Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.redAccent)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                          )),
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
                  top: 310,
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
                top: 340,
                left: 25,
                right: 25,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Your Email Address";
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Enter Your Email Address",
                      hintStyle: TextStyle(color: Colors.grey),
                      focusColor: Colors.amber,
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.redAccent)),
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
                  top: 420,
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
                top: 450,
                left: 25,
                right: 25,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Your Password";
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.remove_red_eye_outlined),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.redAccent)),
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
                top: 550,
                left: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        0xffFE724C,
                      ),
                      fixedSize: Size(248, 60)),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    }
                    passwordController.clear();
                    emailController.clear();
                    nameController.clear();
                  },
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
                top: 630,
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
      ),
    );
  }
}
