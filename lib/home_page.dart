import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:perpustakaan/insert.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  // Buat variabel untuk menyimpan daftar buku
  List<Map<String, dynamic>> Buku = [];

  @override
  void initState() {
    super.initState();
    fetchBook();
  }

  Future<void> fetchBook() async {
    final response = await Supabase.instance.client.from('Buku').select();

    setState(() {
      Buku = List<Map<String, dynamic>>.from(response);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade300,
          title: const Text('Daftar Buku'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: fetchBook,
            ),
          ],
        ),
        body: Buku.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: Buku.length,
                itemBuilder: (context, index) {
                  final book = Buku[index];
                  return ListTile(
                    title: Text(book['judul'] ?? 'Judul',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: Column(
                      children: [
                        Text(book['penulis'] ?? 'Penulis',
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 14)),
                        Text(book['deskripsi'] ?? 'Deskripsi',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tombol edit
                        IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            }),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },
                        )
                      ],
                    ),
                  );

                }),
                                  floatingActionButton:FloatingActionButton(
                    onPressed: () async {
                      // Navigasi ke halaman AddBookPage
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddBookPage(),
                        ),
                      );

                      // Jika result bernilai true, panggil fungsi fetchBook
                      if (result == true) {
                        fetchBook(); // Pastikan fungsi fetchBook() sudah diimplementasikan
                      }
                    },
                    backgroundColor: Colors.blueAccent,
                    child: const Icon(Icons.add,  color: Colors.white),
                  ));
  }
}
