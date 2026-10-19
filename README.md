# Yōkai Quest

Aplikasi kuis pilihan ganda bertema mitos Jepang, dibuat dengan Flutter.

## Fitur

- Nama pemain, 10 soal lokal, progres dan skor.
- Jawaban tersimpan saat berpindah soal dan saat layar berubah ukuran.
- Halaman hasil dengan pembahasan setiap soal.
- Tema terang dan gelap, tampilan adaptif untuk ponsel, tablet, dan web.
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

Data soal berada di `lib/features/quiz/question.dart`. Font Manrope menggunakan lisensi OFL di `assets/fonts/OFL.txt`.
