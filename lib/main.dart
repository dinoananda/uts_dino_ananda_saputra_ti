import 'package:flutter/material.dart';

void main() {
  runApp(const UjianOnlineApp()); // Function Running aplikasi
}

class UjianOnlineApp extends StatelessWidget { // Membuat stateless Widget untuk header
  const UjianOnlineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ujian Online ITTS', 
      debugShowCheckedModeBanner: false, // Menyembunyikan logo DEBUG
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 30, 8, 223), // Warna utama biru
        ),
      ),
      home: const UjianOnlinePage(),
    );
  }
}

class UjianOnlinePage extends StatelessWidget {
  const UjianOnlinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 228, 211), // Background header biru
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding vertikal
          child: Row(
            children: [
              Image.asset(
                'assets/logo.png', // Path gambar
                height: 50, // Ukuran gambar
              ),
              const SizedBox(width: 8), // Jarak antara logo dan teks
              const Text(
                'Ujian Online ITTS',
                style: TextStyle(
                  color: Colors.white, // Warna teks putih
                  fontWeight: FontWeight.bold, // Teks tebal
                  fontSize: 24, // Ukuran teks
                ),
              ),
            ],
          ),
        ),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Selamat datang di platform ujian online kami. '
              'Silakan isi formulir di bawah untuk memulai ujian.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Expanded(
            child: InputForm(),
          ),
        ],
      ),
    );
  }
}

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  String _examType = '';
  bool _isAgreed = false;

  void _showSummary() {
    if (_isAgreed) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ringkasan Ujian'),
            content: Text(
              'Nama: ${_nameController.text}\n'
              'Mata Pelajaran: ${_subjectController.text}\n'
              'Jenis Ujian: $_examType',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tutup'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap menyetujui untuk melanjutkan.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nama'),
          ),
          TextField(
            controller: _subjectController,
            decoration: const InputDecoration(labelText: 'Mata Pelajaran'),
          ),
          DropdownButton<String>(
            value: _examType.isEmpty ? null : _examType,
            hint: const Text('Pilih Jenis Ujian...'),
            items: const [
              DropdownMenuItem(value: 'UTS', child: Text('UTS')),
              DropdownMenuItem(value: 'UAS', child: Text('UAS')),
              DropdownMenuItem(value: 'Quiz', child: Text('Quiz')),
            ],
            onChanged: (value) {
              setState(() {
                _examType = value!;
              });
            },
          ),
          Row(
            children: [
              Checkbox(
                value: _isAgreed,
                onChanged: (value) {
                  setState(() {
                    _isAgreed = value!;
                  });
                },
              ),
              const Text('Saya siap mengikuti ujian'),
            ],
          ),
          ElevatedButton(
            onPressed: _showSummary,
            child: const Text('Ringkasan Data'),
          ),
        ],
      ),
    );
  }
}
