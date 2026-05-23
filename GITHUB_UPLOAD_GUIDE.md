# Cara Upload JustSnap ke GitHub dan Jadikan Website

## 1. Buat repository GitHub

1. Buka GitHub.
2. Klik **New repository**.
3. Namakan repository, contoh: `justsnap`.
4. Pilih **Public**.
5. Klik **Create repository**.

## 2. Upload semua fail projek

Upload semua fail dan folder projek ini ke repository GitHub:

- `.github`
- `assets`
- `lib`
- `test`
- `web`
- `.gitignore`
- `analysis_options.yaml`
- `pubspec.yaml`
- `README.md`

Pastikan fail berada terus di root repository, bukan di dalam folder berganda seperti `justsnap/justsnap/`.

## 3. Aktifkan GitHub Pages

1. Pergi ke repository GitHub anda.
2. Buka **Settings**.
3. Pilih **Pages**.
4. Di bahagian **Build and deployment**, pilih **GitHub Actions**.

## 4. Tunggu website siap

Selepas upload ke branch `main`, GitHub akan menjalankan workflow bernama **Deploy JustSnap Website**.

Apabila selesai, link website akan muncul di:

```text
Settings > Pages
```

Format link biasanya:

```text
https://username.github.io/justsnap/
```

## 5. Jika build gagal

Semak tab **Actions** di GitHub. Pastikan:

- `pubspec.yaml` berada di root repository.
- Folder `assets/images` lengkap.
- Branch utama repository bernama `main`.
