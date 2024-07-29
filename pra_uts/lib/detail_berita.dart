// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'model/model_berita.dart';

// class PageDetailBerita extends StatelessWidget {
//   //konstruktor penampung data
//   final Datum? data;
//   const PageDetailBerita(this.data, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text(data!.judul),
//       ),
//       body: ListView(
//         children: [
//           // Padding(
//           //   padding: EdgeInsets.all(10),
//           //   child: ClipRRect(
//           //     borderRadius: BorderRadius.circular(10),
//           //     child: Image.network(
//           //       'https://localhost/latihan_uts/get_berita.php',
//           //       //${data?.gambar}',
//           //       fit: BoxFit.fill,
//           //     ),
//           //   ),
//           // ),
//           ListTile(
//             title: Text(
//               data?.judul ?? "",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//             ),
//             // subtitle:
//             //     Text(DateFormat().format(data?.tglBerita ?? DateTime.now())),
//             // trailing: Icon(
//             //   Icons.star,
//             //   color: Colors.blue,
//             // ),
//           ),
//           Container(
//             margin: EdgeInsets.all(10),
//             child: Text(
//               data?.konten ?? "",
//               style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }