import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class social_button extends StatelessWidget {
  final String image;
  final String text;
  final Color color;
  final Color textcolor;
  const social_button({
    Key? key,
    required this.image,
    required this.text,
    required this.color,
    required this.textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41.h,
      width: 330.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: color,
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              height: 20.h,
              width: 20.w,
            ),
            SizedBox(
              width: 5.0.w,
            ),
            Text(
              text,
              style: GoogleFonts.lora(
                letterSpacing: 1.0,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: textcolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
