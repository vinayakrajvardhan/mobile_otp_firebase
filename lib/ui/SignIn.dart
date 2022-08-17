import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../widgets/social_buuton.dart';
import 'otp_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    String? phoneNumber;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 17, top: 70.sp, right: 17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 28.h,
                  width: 286.w,
                  child: Text(
                    textScaleFactor: 1.4.sp,
                    "Welcome Back!!",
                    style: GoogleFonts.lora(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 41.h,
                  width: 353.w,
                  child: Text(
                    "Please login with your phone number",
                    style: GoogleFonts.lora(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 334.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      phoneNumber = phone.completeNumber.toString();
                    },
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),

                //button
                Container(
                  height: 41.h,
                  width: 330.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Color(0xffBFFB62),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpControllerPage(
                                  phone:
                                      phoneNumber ?? "Phone number required")));
                    },
                    child: Text(
                      "Continue",
                      style: GoogleFonts.lora(
                          letterSpacing: 2.0,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff2C3234)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 147.sp,
                      child: Container(
                        margin: new EdgeInsetsDirectional.only(
                            start: 1.0, end: 1.0),
                        height: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "OR",
                      style: GoogleFonts.lora(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff2C3234)),
                    ),
                    SizedBox(
                      width: 147.sp,
                      child: Container(
                        margin: new EdgeInsetsDirectional.only(
                            start: 1.0, end: 1.0),
                        height: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                social_button(
                  textcolor: Colors.black,
                  color: Color(0xffF5FFF3),
                  image: "images/meta.png",
                  text: "Connect to MetaMask",
                ),
                SizedBox(
                  height: 10.h,
                ),
                social_button(
                  textcolor: Colors.black,
                  color: Color(0xffF5FFF3),
                  image: "images/go.png",
                  text: "Connect to Google",
                ),
                SizedBox(
                  height: 10.h,
                ),
                social_button(
                  textcolor: Colors.white,
                  color: Colors.black,
                  image: "images/a.png",
                  text: "Connect to Apple",
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ?",
                      style: GoogleFonts.lora(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff2C3234)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "SignUp",
                        style: GoogleFonts.lora(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            color: Color(0xffBFFB62)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
