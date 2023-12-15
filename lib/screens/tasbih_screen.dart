import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int _tasbihCounter = 0;

  void _incrementTasbih() {
    _tasbihCounter++;
  }

  Future<String> getTasbih() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("tasbihKey").toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromARGB(255, 240, 242, 250),
        appBar: AppBar(
          title: FutureBuilder<String>(
              future: getTasbih(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("Previous count: ${snapshot.data}");
                } else {
                  return const Center(
                    child: Text("...."),
                  );
                }
              }),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        body: InkWell(
          onTap: () async {
            setState(() {
              _incrementTasbih();
            });
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setInt("tasbihKey", _tasbihCounter);
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/tasbih_bg.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      _tasbihCounter.toString(),
                      style: GoogleFonts.revalia(
                        fontSize: 55,
                        fontWeight: FontWeight.w500,
                        color: _tasbihCounter == 33 ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: Colors.teal,
        //     onPressed: () async {
        //       setState(() {
        //         _tasbihCounter = 0;
        //       });
        //       SharedPreferences prefs = await SharedPreferences.getInstance();
        //       prefs.setInt("tasbihKey", _tasbihCounter);
        //     },
        //     child: const Icon(
        //       Icons.save,
        //       color: Colors.white,
        //     )),
      ),
    );
  }
}
