import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koran_karim/screens/book_mark.dart';
import 'package:koran_karim/screens/quran_detail_page.dart';
import 'package:koran_karim/services/api_services.dart';
import 'package:shimmer/shimmer.dart';

import '../models/surah_model.dart';

class QuranPages extends StatefulWidget {
  const QuranPages({Key? key}) : super(key: key);

  @override
  State<QuranPages> createState() => _QuranPagesState();
}

class _QuranPagesState extends State<QuranPages> {
  final ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 242, 250),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quran",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Pages",
              style: GoogleFonts.poppins(
                color: const Color(0xff25D3CF),
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BookMark(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.bookmark_add,
                  size: 30,
                  color: Colors.black,
                )),
          ),
        ],
      ),
      body: FutureBuilder<SurahModel>(
        future: _apiServices.getSurah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 100, // Set the desired number of shimmer placeholders
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 30,
                      ),
                      title: Container(
                        height: 16,
                        color: Colors.grey[300],
                      ),
                      trailing: Container(
                        height: 16,
                        width: 50,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasData) {
            SurahModel surahModel = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: surahModel.data.surahs.length,
                    itemBuilder: (context, surahIndex) {
                      Surah surah = surahModel.data.surahs[surahIndex];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuranDetailPages(
                                surah: surah,
                              ),
                            ),
                          );
                          log(surah.ayahs.length.toString());
                        },
                        child: Card(
                          shadowColor: Colors.black26,
                          elevation: 2,
                          color: const Color.fromARGB(255, 240, 242, 250),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8),
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  const AssetImage("assets/307063.png"),
                              radius: 30,
                              child: Text(
                                (surahIndex + 1).toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            title: Text(
                              surah.englishName,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              "Ayah: ${surah.ayahs.length.toString()}",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                              ),
                            ),
                            trailing: Text(
                              surah.name,
                              style: GoogleFonts.amiriQuran(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Failed to fetch data."),
            );
          }
        },
      ),
    );
  }
}
