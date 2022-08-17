import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpControllerPage extends StatefulWidget {
  final String phone;
  OtpControllerPage({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<OtpControllerPage> createState() => _OtpControllerPageState();
}

class _OtpControllerPageState extends State<OtpControllerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = TextEditingController();
  final focusNode = FocusNode();
  String? _verificationCode;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  void initState() {
    verifyPhoneNumber();
    _listenSmsCode();
    super.initState();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          if (value.user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Verified and Authenticated"),
              ),
            );
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
        print(e.message.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationCode = verificationId;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 17, top: 120.sp, right: 17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 28.h,
                  width: 286.w,
                  child: Text(
                    textScaleFactor: 1.4.sp,
                    "Enter OTP",
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
                  height: 28.h,
                  width: 300.w,
                  child: Text(
                    "A five didgit code has been sent to ${widget.phone}",
                    style: GoogleFonts.lora(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Incorrect number ?",
                      style: GoogleFonts.lora(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff2C3234)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Chnage",
                        style: GoogleFonts.lora(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            color: Color(0xffBFFB62)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Pinput(
                  length: 6,
                  controller: controller,
                  focusNode: focusNode,
                  pinAnimationType: PinAnimationType.rotation,
                  onChanged: (sms) async {
                    await SmsAutoFill().listenForCode;
                  },
                  onSubmitted: (pin) async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(
                        PhoneAuthProvider.credential(
                            verificationId: _verificationCode ?? "",
                            smsCode: pin),
                      )
                          .then((value) {
                        if (value.user != null) {
                          Fluttertoast.showToast(
                              msg: "Verified and Authenticated",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0xffBFFB62),
                              textColor: Colors.white,
                              fontSize: 16.0);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Verified and Authenticated"),
                            ),
                          );
                        }
                      });
                    } catch (e) {
                      // FocusScope.of(context).unfocus();
                    }
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 41.h,
                  width: 330.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Color(0xffBFFB62),
                    ),
                    onPressed: () async {
                      //   await SmsAutoFill().listenForCode;
                    },
                    child: Text(
                      "Done",
                      style: GoogleFonts.lora(
                          letterSpacing: 2.0,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff2C3234)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
