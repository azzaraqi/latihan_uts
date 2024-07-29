import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              // Ganti dengan gambar profil pengguna
              backgroundImage: AssetImage('gambar/user_profile.png'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Nama Pengguna',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'email@pengguna.com',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Informasi Tambahan:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Tanggal Lahir: 01 Januari 1990',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Alamat: Jl. Contoh No. 123',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Nomor Telepon: 081234567890',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Tambahkan aksi untuk mengedit profil
              },
              child: Text('Edit Profil'),
            ),
            ElevatedButton(
              onPressed: () {
                // Tambahkan aksi untuk keluar
              },
              child: Text('Keluar'),
            ),
          ],
        ),
      ),
    );
  }
}
