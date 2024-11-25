import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _penulisController = TextEditingController();
  final _deskripsiController = TextEditingController();

  Future<void> _addBook() async {
    if (_formKey.currentState!.validate()) {
      final judul = _judulController.text.trim();
      final penulis = _penulisController.text.trim();
      final deskripsi = _deskripsiController.text.trim();

      try {
        final response = await Supabase.instance.client
            .from('Buku')
            .insert({
          'judul': judul,
          'penulis': penulis,
          'deskripsi': deskripsi,
        });

        if (response.error == null) {
          // Berhasil menambahkan buku
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Buku berhasil ditambahkan!')),
          );
          _judulController.clear();
          _penulisController.clear();
          _deskripsiController.clear();
          Navigator.pop(context, true);
        } else {
          // Gagal menambahkan buku
          throw response.error!.message;
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _penulisController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Buku Baru'),
        centerTitle: true,
        backgroundColor: Colors.cyan[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  labelText: 'Judul',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _penulisController,
                decoration: const InputDecoration(
                  labelText: 'Penulis',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Penulis tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Deskripsi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _addBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan[200],
                ),
                child: const Text(
                  'Simpan Buku',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
