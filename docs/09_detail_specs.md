# 09. Spesifikasi Teknis Detail (Micro-Specs)

Dokumen ini mengisi "Gap" antara Prototype HTML (`lofi`) dan Aplikasi Production Ready. HTML tidak memiliki logic validasi atau error handling, jadi kita definisikan di sini.

## 1. Validasi Input (Form Rules)

Agar UX pengguna mulus, validasi dilakukan secara **Real-time** (saat mengetik) atau **On-Submit**.

| Fitur        | Field      | Aturan Validasi (Rules)                          | Pesan Error (Bahasa Indonesia)            |
| :----------- | :--------- | :----------------------------------------------- | :---------------------------------------- |
| **Register** | `email`    | `RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')`    | "Format email tidak valid."               |
|              | `password` | Min 8 chars, 1 Uppercase.                        | "Minimal 8 karakter & 1 huruf besar."     |
|              | `phone`    | Numeric only, Min 10, Max 14. Start '0' or '62'. | "Nomor WhatsApp tidak valid."             |
|              | `angkatan` | Year between 1960 - Current Year.                | "Tahun angkatan tidak masuk akal."        |
| **Loker**    | `url`      | Valid URL format (http/https).                   | "Link pendaftaran harus diawali http://". |
| **Donasi**   | `amount`   | Min Rp 10.000.                                   | "Donasi minimal Rp 10.000 ya kak."        |

## 2. Empty States & Error Handling UI

HTML `lofi` hanya menunjukkan "Happy Path" (Saat data ada). Kita perlu state untuk kondisi ini:

### A. Network Error / Server Down

- **Tampilan**: Gambar ilustrasi "Koneksi Terputus".
- **Action**: Tombol "Coba Lagi" (Retry Button).
- **Toast**: "Gagal terhubung ke server. Periksa internetmu."

### B. Empty Data (Data Kosong)

- **Directory**: "Alumni tidak ditemukan" (Jika search result 0).
- **Loker**: "Belum ada lowongan baru saat ini."
- **Market**: "Produk kategori ini belum tersedia."

### C. Loading States (Shimmer)

- Jangan gunakan _Circular Progress_ biasa untuk layout List/Grid.
- **Directory**: Skeleton List (Avatar bulat + 2 baris teks).
- **Market**: Skeleton Grid (Kotak gambar + teks harga).

## 3. Aset & Media Paths

Lokasi aset statis yang akan digunakan dalam aplikasi (ditaruh di `assets/images/`).

- `assets/images/logo_ikasmansara.png` (Logo App)
- `assets/images/placeholder_avatar.png` (Default user avatar)
- `assets/images/placeholder_product.png` (Default product image)
- `assets/images/pattern_ekta.png` (Background Kartu E-KTA)
- `assets/images/empty_state.svg` (Ilustrasi data kosong)

## 4. Logic "Hidden" (Yang tidak ada di HTML)

Hal-hal yang harus di-handle di background:

1.  **Session Management**: Auto-login jika token masih valid (Persist Token).
2.  **Image Compression**: Foto profil & produk harus dikoempress max 500KB sebelum upload ke server (agar hemat kuota user).
3.  **Debouce Search**: Pencarian direktori harus menunggu 500ms setelah user berhenti mengetik, baru request ke server (Hemat API Call).

---

> [!IMPORTANT]
> Developer wajib membaca dokumen ini sebelum membuat Controller/Form apapun.
