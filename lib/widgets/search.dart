// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:koran_karim/services/api_services.dart';

// import '../models/surah_model.dart';
// import '../screens/detail_screen.dart';

// class Search extends SearchDelegate {
//   List? surahList;
//   Search({required this.surahList});
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = "";
//         },
//         icon: const Icon(
//           Icons.clear,
//         ),
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         Navigator.pop(context);
//       },
//       icon: const Icon(
//         Icons.arrow_back_ios,
//       ),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Container();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestionList = query.isEmpty
//         ? surahList
//         : surahList!
//             .where((element) =>
//                 element.name.toString().toLowerCase().contains(query))
//             .toList();
//     return suggestionList != null
//         ? FutureBuilder(
//             future: ApiServices().getSurah(),
//             builder: (context, snapshot) {
//               return ListView.builder(
//                 itemCount: suggestionList.length,
//                 itemBuilder: (context, index) {
//                   SurahModel surahModel = snapshot.data!;

//                   ListView.builder(
//                     // shrinkWrap: true,
//                     physics: const BouncingScrollPhysics(),

//                     itemCount: surahModel.data.surahs.length,
//                     itemBuilder: (context, surahIndex) {
//                       Surah surah = surahModel.data.surahs[surahIndex];

//                       return InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => DetailScreen(
//                                 surah: surah,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Card(
//                           shadowColor: Colors.black26,
//                           elevation: 2,
//                           color: const Color.fromARGB(255, 240, 242, 250),
//                           child: ListTile(
//                             contentPadding: const EdgeInsets.all(8),
//                             leading: CircleAvatar(
//                               backgroundColor: Colors.transparent,
//                               backgroundImage:
//                                   const AssetImage("assets/307063.png"),
//                               radius: 30,
//                               child: Text(
//                                 (surahIndex + 1).toString(),
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.black,
//                                   fontSize: 19,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                             title: Text(
//                               surah.englishName,
//                               style: GoogleFonts.poppins(
//                                 fontSize: 18,
//                               ),
//                             ),
//                             subtitle: Text(
//                               "Ayah: ${surah.ayahs.length.toString()}",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 16,
//                               ),
//                             ),
//                             trailing: Text(
//                               surah.name,
//                               style: GoogleFonts.amiriQuran(
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                   return null;
//                 },
//               );
//             })
//         : const Center(
//             child: CircularProgressIndicator(color: Colors.red),
//           );
//   }
// }
