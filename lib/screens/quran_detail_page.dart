import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koran_karim/utilitis/utilis.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/surah_model.dart';

class QuranDetailPages extends StatelessWidget {
  final Surah surah;

  const QuranDetailPages({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    List<int> pageNumbers = [];
    List<Widget> pages = [];

    for (var ayah in surah.ayahs) {
      int pageNumber = ayah.page;
      if (!pageNumbers.contains(pageNumber)) {
        pageNumbers.add(pageNumber);
        String formattedPageNumber = pageNumber.toString().padLeft(3, '0');
        String imagePath = 'assets/images/1024/page$formattedPageNumber.png';
        pages.add(Image.asset(imagePath));
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          surah.name,
          style: GoogleFonts.amiriQuran(
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: PageView.builder(
        reverse: true,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.lightBlueAccent,
                      ),
                      child: Text(
                        surah.englishName,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.lightBlueAccent,
                      ),
                      child: Text(
                        "Juz: ${surah.ayahs[index].juz}",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString(Utilis().SURAH_KEY, surah.englishName);
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        title: const Text('Book Mark Notice 🔔'),
                        content: const Text('You have book marked this surah '),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      );
                    },
                  );

                  log("waxa wye:${prefs.getString(Utilis().SURAH_KEY)}");
                },
                child: pages[index],
              ),
            ],
          );
        },
      ),
    );
  }
}
