import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koran_karim/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../models/surah_model.dart';
import 'detail_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isSearching = false;
  final surahController = TextEditingController();

  final ApiServices _apiServices = ApiServices();
  SurahModel? surahModel;
  final sharedKey = "sharedKey";

  // SharedPreferences? prefs;

  Future<String> loadSurah() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(sharedKey).toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loadSurah();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 242, 250),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: _isSearching
            ? TextField(
                controller: surahController,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xff25D3CF),
                    ),
                  ),
                  hintText: "Search",
                ),
                onChanged: (value) {},
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "koran",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "KareeM",
                    style: GoogleFonts.poppins(
                      color: const Color(0xff25D3CF),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                });
              },
              icon: Icon(
                _isSearching
                    ? CupertinoIcons.clear_circled_solid
                    : Icons.search,
                color: Colors.black,
                size: 30,
              ),
            ),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .17,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/masjid.png"),
                          alignment: Alignment.centerRight,
                        ),
                        color: const Color(0xff25D3CF),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff14A0EB),
                            Color(0xff25D3CF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.book,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Last Read",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            FutureBuilder<String>(
                              future: loadSurah(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator(); // Display a loading indicator if the future is still loading
                                } else if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "Failed to load data",
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }
                              },
                            ),
                            Text(
                              "Ayah No: 1",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: surahModel.data.surahs.length,
                    itemBuilder: (context, surahIndex) {
                      Surah surah = surahModel.data.surahs[surahIndex];

                      return InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(
                                surah: surah,
                              ),
                            ),
                          );

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(
                              sharedKey, surah.englishName.toString());
                          log(prefs.getString(sharedKey).toString());
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
