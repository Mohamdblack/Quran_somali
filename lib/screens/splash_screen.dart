import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koran_karim/screens/main_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/animation_lkp9jgso.json",
            width: 500.0,
            height: 500.0,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Welcome to a world of \nvisual enhancement",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "lorem ipsum is empty dummy text of the \nprinting and typesetting",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 17,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 46),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MainPage()));
              },
              child: Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                    color: const Color(0xff197278),
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.poppins(
                      fontSize: 23,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const MainPage()));
            },
            child: Text(
              "Login",
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: const Color(
                  0xff197278,
                ),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
