import 'package:flutter/material.dart';
import 'package:lat_kuis/data/animals_data.dart';
import 'package:lat_kuis/pages/about_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.username = "Guest"});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Memberikan warna background sedikit pink/ungu muda seperti pada gambar
      backgroundColor: const Color(0xFFFAF8FC), 
      appBar: AppBar(
        title: const Text(
          "Animals List",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false, // Menghilangkan panah back default
        actions: [ // Actions itu di kanan
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            // Menggunakan icon logout di kanan sesuai referensi gambar
            icon: const Icon(Icons.logout_outlined), 
            color: Colors.white,
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Mengatur jumlah kolom menjadi 2
          crossAxisSpacing: 16, // Jarak horizontal antar card
          mainAxisSpacing: 16, // Jarak vertikal antar baris card
          childAspectRatio: 0.6, // Mengatur rasio tinggi-lebar card. (Ubah nilainya jika card kepotong)
        ),
        itemCount: dummyAnimals.length,
        itemBuilder: (context, index) {
          final animal = dummyAnimals[index]; // Variabel bantuan agar kodenya lebih rapi
          
          return InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage(index: index)) 
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16), // Ujung card melengkung
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1), // Bayangan tipis
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Semua isi di dalam Column rata kiri
                children: [
                  // --- 1. Area Gambar ---
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          animal.image,
                          fit: BoxFit.cover, // Gambar memenuhi area
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // --- 2. Area Teks ---
                  Text(
                    animal.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    animal.type,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // --- 3. Area Habitat (Label Kotak) ---
                  Wrap(
                    spacing: 8, // Jarak horizontal antar label habitat
                    runSpacing: 8, // Jarak vertikal jika habitat lebih dari 1 baris
                    children: animal.habitat.map<Widget>((hab) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          hab,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}