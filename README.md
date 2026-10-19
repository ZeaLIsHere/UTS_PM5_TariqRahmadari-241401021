# Yōkai Quest

## Identitas Mahasiswa

| Keterangan | Data |
| --- | --- |
| Nama | Tariq Rahmadari |
| NIM | 241401021 |
| Lab | Pemograman Mobile 5 |

## Informasi Aplikasi

**Nama aplikasi:** Yōkai Quest

**Deskripsi singkat:** Aplikasi kuis pilihan ganda bertema mitos Jepang yang dibuat dengan Flutter. Pengguna memasukkan nama, menjawab pertanyaan, lalu melihat skor dan pembahasan jawabannya.

### Fitur-fitur yang tersedia

- Nama pemain, bank 50 soal mitos Jepang, 10 soal acak per sesi, progres dan skor.
- Riwayat soal tersimpan per nama di perangkat/browser. Lima sesi pertama untuk nama yang sama memakai 50 soal tanpa pengulangan; setelah itu siklus dimulai lagi tanpa mengulang soal dari sesi sebelumnya.
- Jawaban tersimpan saat berpindah soal dan saat layar berubah ukuran.
- Halaman hasil dengan pembahasan setiap soal.
- Tema terang dan gelap, tampilan adaptif untuk ponsel, tablet, dan web.
- Ilustrasi dan ikon SVG bertema mitos Jepang pada beranda, kuis, hasil, serta ikon web.
- Font Manrope lokal dan ikon Material.

## Menjalankan

```sh
flutter pub get
flutter run
```

## Memeriksa

```sh
flutter analyze
flutter test
flutter build web
```

Data soal berada di `lib/features/quiz/question.dart`. Riwayat lokal akan terhapus jika data aplikasi/browser dihapus dan tidak tersinkron antarperangkat. Font Manrope menggunakan lisensi OFL di `assets/fonts/OFL.txt`.
