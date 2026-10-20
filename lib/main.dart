import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// ===================== MODEL DATA =====================
class Lagu {
  final String judul; // String
  final String artis; // String
  final String genre; // String
  final double durasiMenit; // double
  final int tahunRilis; // int
  final bool favorit; // bool

  const Lagu({
    required this.judul,
    required this.artis,
    required this.genre,
    required this.durasiMenit,
    required this.tahunRilis,
    required this.favorit,
  });
}

// ===================== APLIKASI =====================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Satu-satunya MaterialApp di seluruh aplikasi
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Musik',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.deepOrange.shade50,
      ),
      home: const LayarUtama(),
    );
  }
}

// ===================== HALAMAN UTAMA =====================
class LayarUtama extends StatelessWidget {
  const LayarUtama({super.key});

  @override
  Widget build(BuildContext context) {
    // Data milik sendiri (object dari model Lagu)
    final List<Lagu> daftarLagu = const [
      Lagu(
        judul: "Hati-Hati di Jalan",
        artis: "Tulus",
        genre: "Pop",
        durasiMenit: 4.1,
        tahunRilis: 2022,
        favorit: true,
      ),
      Lagu(
        judul: "Bertaut",
        artis: "Nadin Amizah",
        genre: "Folk",
        durasiMenit: 3.9,
        tahunRilis: 2020,
        favorit: true,
      ),
      Lagu(
        judul: "Secukupnya",
        artis: "Hindia",
        genre: "Indie Pop",
        durasiMenit: 3.7,
        tahunRilis: 2019,
        favorit: false,
      ),
      Lagu(
        judul: "Sephia",
        artis: "Sheila on 7",
        genre: "Rock",
        durasiMenit: 4.6,
        tahunRilis: 1999,
        favorit: false,
      ),
    ];

    final int jumlahFavorit = daftarLagu.where((l) => l.favorit).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Musik Saya')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RingkasanKoleksi(
                totalLagu: daftarLagu.length,
                totalFavorit: jumlahFavorit,
              ),
              const SizedBox(height: 16),
              const Text(
                'Koleksi Lagu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              for (final lagu in daftarLagu) KartuLagu(lagu: lagu),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  debugPrint("Tombol Tambah Lagu Diklik");
                },
                child: const Text("Tambah Lagu"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== CUSTOM WIDGET 1: RINGKASAN =====================
class RingkasanKoleksi extends StatelessWidget {
  final int totalLagu;
  final int totalFavorit;

  const RingkasanKoleksi({
    super.key,
    required this.totalLagu,
    required this.totalFavorit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.deepOrange.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.library_music, size: 40, color: Colors.deepOrange),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Koleksi',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                Text(
                  '$totalLagu lagu',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                Text(
                  '$totalFavorit lagu favorit',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===================== CUSTOM WIDGET 2: KARTU LAGU =====================
class KartuLagu extends StatelessWidget {
  final Lagu lagu;

  const KartuLagu({super.key, required this.lagu});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.music_note, color: Colors.deepOrange),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lagu.judul,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    lagu.artis,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${lagu.genre} • ${lagu.tahunRilis} • ${lagu.durasiMenit} menit',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              lagu.favorit ? Icons.favorite : Icons.favorite_border,
              color: lagu.favorit ? Colors.red : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}