import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:koran_karim/models/surah_translation_model.dart';
import 'package:koran_karim/services/api_services.dart';
import '../models/surah_model.dart';
import '../utilitis/utilis.dart';

class DetailScreen extends StatefulWidget {
  final Surah surah;

  const DetailScreen({Key? key, required this.surah}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ApiServices _apiServices = ApiServices();
  bool isPlaying = false;
  final player = AudioPlayer();

  playAudio(int id) async {
    try {
      await player.setUrl(
          "https://cdn.islamic.network/quran/audio/128/ar.alafasy/$id.mp3");
      player.play();

      // TODO : When ayah ends start another ayah automatically , use the code below if want
      // TODO the problem of code below is once it starts it will continue all surah of quran
      // * CONTRIBUTION => Stop once it ends Surah until u start another surah
      //TODO : and also change the UI make sure to follow through ayah sound auto scroll i mean
      // void playNextTrack() {
      //   int nextId = id + 1;
      //   playAudio(nextId);
      // }

      // player.playerStateStream.listen((playerState) {
      //   if (playerState.processingState == ProcessingState.completed) {
      //     // * Current audio track has finished playing
      //     // * Automatically start playing the next track here
      //     playNextTrack();
      //   }
      // });
      // * =====================================================================================================/

      if (isPlaying) {
        player.pause();
      } else {
        player.play().then((_) {
          setState(() {
            isPlaying = true;
          });
        });
      }
      setState(() {
        isPlaying = !isPlaying;
      });
    } on PlayerException catch (e) {
      log("Error code: ${e.code}");

      log("Error message: ${e.message}");
      // Utilis().showSnackbar("${e.message} No connection 📶", context);
      Utilis().showAlert(context);
    } on PlayerInterruptedException catch (e) {
      log("Connection aborted: ${e.message}");
      // Utilis().showSnackbar(e.message.toString(), context);
    } catch (e) {
      log('An error occured: $e');
    }

    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace st) {
      if (e is PlayerException) {
        log('Error code: ${e.code}');
        log('Error message: ${e.message}');
        // Utilis().showSnackbar(e.message.toString(), context);
      } else {
        log('An error occurred: $e');
      }
    });
  }

  @override
  void dispose() {
    // & this dispose method it will take care memory
    // & leak and now when i exit surah detail screen it will stop quran sound if ts playing /background
    super.dispose();
    player.dispose();
  }

  @override
  void initState() {
    super.initState();
    player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 242, 250),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.surah.name,
          style: GoogleFonts.amiriQuran(
            fontSize: 24,
          ),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.surah.ayahs.length,
        itemBuilder: (context, index) {
          Ayah ayah = widget.surah.ayahs[index];
          // List<String> separatedText =
          //     ayah.text.split("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ");

          return Column(
            // minaxis size
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (index ==
                  0) // * Conditionally render the text only for the first line
                Center(
                  child: widget.surah.number == 9
                      ? const SizedBox()
                      : Text(
                          '﷽ ☪',
                          style: GoogleFonts.amiriQuran(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              // const SizedBox(
              //   width: 16,
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xff25D3CF),
                  gradient: const LinearGradient(
                    colors: [
                      // Colors.black,
                      Color(0xff25D3CF),
                      Color.fromARGB(255, 54, 151, 200),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.transparent,
                        backgroundImage: const AssetImage("assets/307063.png"),
                        child: Text(
                          ayah.numberInSurah.toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.info_outline,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          playAudio(ayah.number);
                        },
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              ayah.text == "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ"
                  ? Text(
                      ayah.text,
                      style: GoogleFonts.amiriQuran(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                      textDirection: TextDirection.rtl,
                    )
                  : Text(
                      ayah.text
                          .split("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ")
                          .last
                          .toString(),
                      style: GoogleFonts.amiriQuran(
                        fontSize: 33,
                        fontWeight: FontWeight.w500,
                      ),
                      textDirection: TextDirection.rtl,
                    ),

              const SizedBox(
                height: 16,
              ),
              FutureBuilder<SurahTransaltionModel>(
                future: _apiServices.getSurahDetails(
                  widget.surah.number,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //  Ayah ayaHH = widget.surah.ayahs[index];

                    return ShaderMask(
                      blendMode: BlendMode.srcATop,
                      shaderCallback: (bounds) {
                        const gradient = LinearGradient(
                          colors: [
                            // Colors.black,
                            Color.fromARGB(255, 21, 49, 63),
                            Color(0xff25D3CF),
                          ],
                        );
                        return gradient.createShader(bounds);
                      },
                      child: Text(snapshot.data!.result[index].translation,
                          style: const TextStyle(
                            fontSize: 23,
                          )),
                    );
                  } else {
                    return const Center(
                      child: SizedBox(),
                    );
                  }
                },
              ),

              const SizedBox(
                height: 16,
              ),

              const Divider(
                thickness: 1,
                indent: 40,
              ),
            ],
          );
        },
      ),
    );
  }
}
