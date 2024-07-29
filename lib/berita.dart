// Make sure to import necessary dependencies
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pra_uts/Model/model_berita.dart';


class PageListBerita extends StatefulWidget {
  const PageListBerita({Key? key}) : super(key: key);

  @override
  _PageListBeritaState createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {
  late Future<List<Datum>?> _beritaFuture;
  List<Datum> listBerita = [];
  List<Datum> filteredBerita = [];
  TextEditingController txtCari = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _beritaFuture = getBerita();
  }

  Future<List<Datum>?> getBerita() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/latihan_uts/get_berita.php'));
      if (response.statusCode == 200) {
        return modelBeritaFromJson(response.body).data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  void filterBerita(String query) {
    setState(() {
      filteredBerita = listBerita.where((berita) =>
          berita.judul!.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: txtCari,
              onChanged: (query) {
                filterBerita(query);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Datum>?>(
              future: _beritaFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.orange));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  listBerita = snapshot.data!;
                  if (filteredBerita.isEmpty) {
                    filteredBerita = listBerita;
                  }
                  return ListView.builder(
                    itemCount: filteredBerita.length,
                    itemBuilder: (context, index) {
                      Datum data = filteredBerita[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => PageDetailBerita(data)),
                          );
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'http://localhost/latihan_uts/gambar/${data.gambar}',
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(child: Text('Image not available'));
                                    },
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  data.judul ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  data.konten ?? '',
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black54, fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


class PageDetailBerita extends StatelessWidget {
  final Datum? data;

  const PageDetailBerita(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(data!.judul),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'http://localhost/latihan_uts/gambar/${data?.gambar}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              data?.judul ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            // subtitle: Text(
            //   DateFormat('MMM d, yyyy').format(data?.tglBerita ?? DateTime.now()),
            //   style: TextStyle(color: Colors.grey),
            // ),
            trailing: Icon(
              Icons.star,
              color: Colors.orange,
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              data?.konten ?? "",
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}