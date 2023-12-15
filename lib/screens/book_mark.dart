import 'package:flutter/material.dart';
import 'package:koran_karim/utilitis/utilis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMark extends StatefulWidget {
  const BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  Future<List<String>> getBookMarkSurah() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? surah = prefs.getString(Utilis().SURAH_KEY);
    return surah != null ? [surah] : [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 242, 250),
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("Bookmark"),
      ),
      body: FutureBuilder<List<String>>(
        future: getBookMarkSurah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<String> bookmarkedSurahs = snapshot.data!;

            return ListView.builder(
              itemCount: bookmarkedSurahs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      const Text(
                          "To Bookmark a surah just click the surah ayahs ⚠️"),
                      const SizedBox(
                        height: 16,
                      ),
                      Card(
                        color: const Color.fromARGB(255, 240, 242, 250),
                        child: ListTile(
                          leading: const CircleAvatar(
                            radius: 30,
                          ),
                          title: Text(bookmarkedSurahs[index]),
                          subtitle: Text(bookmarkedSurahs[index]),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Text('No bookmarked surahs found.');
          }
        },
      ),
    );
  }
}
