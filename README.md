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
- Batas lebar konten adaptif, dukungan teks diperbesar, serta tombol nomor soal untuk meninjau jawaban. Hasil hanya dibuka setelah semua soal dijawab.
- Animasi pilihan jawaban, progres, dan lencana hasil yang mengikuti pengaturan kurangi animasi perangkat.
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


SS Aplikasi
<img width="357" height="795" alt="image" src="https://github.com/user-attachments/assets/bc33f6b4-847a-4266-be01-9684126a16a4" />

<img width="359" height="797" alt="image" src="https://github.com/user-attachments/assets/4381279b-10e6-4500-a7e6-59abd8ece33f" />

<img width="358" height="800" alt="image" src="https://github.com/user-attachments/assets/8802d179-09cd-4857-8b2d-bacd73216ffe" />

<img width="354" height="798" alt="image" src="https://github.com/user-attachments/assets/4ec5117b-112e-4b1f-b3cb-225ac12668f1" />

<img width="370" height="857" alt="image" src="https://github.com/user-attachments/assets/06e619ed-d9dc-4aa0-a9a9-6a622a11c378" />

<img width="373" height="834" alt="image" src="https://github.com/user-attachments/assets/c914183e-4726-4815-9cb0-a1d5faece896" />



Link Video Presentasi dan Prototipe : https://drive.google.com/file/d/1lx6gOh5cujOM88paBhn_qANdjygNmXzz/view?usp=sharing
