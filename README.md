# Yōkai Quest

Aplikasi kuis pilihan ganda bertema mitos Jepang yang dibuat dengan Flutter. Pemain memasukkan nama, menjawab 10 soal, lalu melihat skor dan pembahasan setiap jawaban.

## Identitas Mahasiswa

| Keterangan | Data |
| --- | --- |
| Nama | Tariq Rahmadari |
| NIM | 241401021 |
| Lab | Pemograman Mobile 5 |

## Informasi Aplikasi

**Nama aplikasi:** Yōkai Quest

**Tema:** Aplikasi Kuis Pilihan Ganda — Mitos Jepang

### Fitur

- Bank 50 soal mitos Jepang dengan empat pilihan jawaban dan pembahasan.
- Sepuluh soal acak per sesi. Untuk nama yang sama pada perangkat atau browser yang sama, lima sesi pertama menggunakan seluruh 50 soal tanpa pengulangan. Setelah itu, siklus baru dimulai dan soal dari sesi tepat sebelumnya dihindari.
- Riwayat soal tersimpan secara lokal per nama menggunakan `shared_preferences`. Kuis tetap dapat dimainkan jika penyimpanan lokal tidak tersedia, tetapi jaminan soal baru antarsesi tidak berlaku dalam keadaan itu.
- Progres dan pilihan jawaban tetap ada ketika berpindah soal, halaman, atau ukuran layar berubah selama sesi berlangsung.
- Halaman hasil menampilkan skor, jawaban pemain, jawaban benar, dan pembahasan.
- Tema terang dan gelap; tata letak responsif untuk ponsel, tablet, dan web.
- Ilustrasi serta ikon SVG bertema Jepang, font Manrope lokal, dan widget UI yang dapat digunakan ulang.

Soal dan riwayat tidak memerlukan API maupun database. Riwayat hanya tersimpan pada perangkat atau browser tempat kuis dimainkan; menghapus data aplikasi atau browser akan menghapus riwayat tersebut.

## Menjalankan Aplikasi

Pastikan Flutter SDK tersedia, lalu jalankan dari direktori proyek:

```sh
flutter pub get
flutter run
```

Untuk menjalankan khusus di browser:

```sh
flutter run -d chrome
```

## Memeriksa Proyek

```sh
flutter analyze
flutter test
flutter build web
```

## Struktur Utama

| Lokasi | Isi |
| --- | --- |
| `lib/features/home/` | Halaman nama pemain dan awal kuis |
| `lib/features/quiz/question.dart` | Bank soal dan jawaban |
| `lib/features/quiz/question_picker.dart` | Pemilihan soal dan pergantian siklus |
| `lib/features/quiz/question_history.dart` | Penyimpanan riwayat lokal per nama |
| `lib/features/quiz/quiz_session_factory.dart` | Pembuatan sesi dari bank soal dan riwayat |
| `lib/features/quiz/quiz_page.dart` | Halaman pertanyaan dan progres |
| `lib/features/result/` | Skor dan ulasan jawaban |
| `lib/widgets/` | Komponen UI yang digunakan ulang |
| `assets/svg/` | Ilustrasi dan ikon |

Font Manrope menggunakan lisensi OFL yang tersedia di `assets/fonts/OFL.txt`.
