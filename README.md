# JustSnap

JustSnap ialah aplikasi Flutter multi-platform untuk mengurus barang bawaan travel menggunakan aliran AI Object Detection. Kod ini menyokong paparan telefon iOS/Android dan web PC melalui susun atur responsif.

## Cara jalankan

```bash
flutter pub get
flutter run -d chrome
```

Untuk Android/iOS, jalankan:

```bash
flutter run
```

Jika folder platform belum wujud pada mesin baharu, jana shell platform Flutter dahulu:

```bash
flutter create .
```

## Jadikan website online

Projek ini sudah disediakan dengan GitHub Actions untuk deploy ke GitHub Pages. Upload projek ke repository GitHub, kemudian aktifkan:

```text
Settings > Pages > Build and deployment > GitHub Actions
```

Panduan penuh ada di `GITHUB_UPLOAD_GUIDE.md`.

## Struktur

- `lib/models` - model data item, beg, dan hasil imbasan AI.
- `lib/services` - data demo dan servis object detection yang boleh diganti dengan TFLite/ML Kit.
- `lib/screens` - skrin utama, imbasan, alert, sejarah, pengurusan, dan tentang kami.
- `lib/widgets` - komponen UI reusable dan responsif.
- `assets/images` - aset rasmi JustSnap daripada fail yang diberi.

## Nota AI

Fail `lib/services/object_detection_service.dart` menyediakan simulasi pengesanan objek supaya aplikasi boleh digunakan terus tanpa model berat. Untuk produksi, gantikan implementasi `MockObjectDetectionService` dengan servis TFLite/ML Kit yang memproses frame kamera atau imej yang dipilih.
