# Spesifikasi Teknis Aplikasi IKA SMANSARA

Dokumen ini berisi spesifikasi teknis, alur kerja, skema database, dan rencana implementasi untuk aplikasi mobile IKA SMANSARA menggunakan React Native (Expo) dan PocketBase.

## 1. Ringkasan Proyek
Aplikasi portal untuk Ikatan Alumni SMAN 1 Jepara yang menghubungkan alumni, sekolah, dan masyarakat umum.
**Tech Stack:**
- **Frontend:** React Native (Expo Router)
- **Backend/Database:** PocketBase
- **Styling:** NativeWind (Tailwind CSS) atau StyleSheet standar

## 2. Hak Akses Pengguna (Roles)
1.  **Alumni (Full Access)**
    - Verifikasi via tahun angkatan/NIS (opsional).
    - Akses: Direktori, E-KTA, Loker (Post/View), Market (Jual/Beli), Forum (Post/Comment), Donasi, Berita.
2.  **Masyarakat Umum (Public)**
    - Akses Terbatas: Berita Sekolah, Donasi (View/Donate), Market (View Only), Forum (View Only).

## 3. Fitur & Alur Kerja (Workflow)

### A. Autentikasi & Onboarding
- **Login:** Email & Password.
- **Register:**
    - **Alumni:** Input data diri + Tahun Angkatan + Pekerjaan + Domisili.
    - **Umum:** Input data diri dasar.
- **Onboarding:** Slide pengenalan fitur saat pertama kali buka aplikasi.

### B. Dashboard (Home)
- Menampilkan E-KTA (untuk Alumni).
- Menu Cepat (Grid).
- Slider Program Donasi (Urgent/Terbaru).
- List Berita Terbaru.

### C. Direktori Alumni (Khusus Alumni)
- **Fitur:** List alumni dengan filter (Angkatan, Pekerjaan, Kota).
- **Detail:** Melihat profil lengkap alumni lain (No HP/Email jika diizinkan).

### D. E-KTA
- Kartu digital dengan QR Code unik (bisa berisi ID member).
- Tampilan visual kartu member.

### E. Marketplace (UMKM Alumni)
- **List:** Grid produk/jasa alumni.
- **Detail:** Deskripsi, harga, kontak penjual (WhatsApp link).
- **Add Product:** Form tambah produk (Khusus Alumni).

### F. Lowongan Kerja (Loker)
- **List:** Daftar lowongan kerja.
- **Detail:** Deskripsi, kualifikasi, cara melamar.
- **Post Loker:** Form input lowongan (Khusus Alumni).

### G. Donasi
- **List:** Program donasi aktif.
- **Detail:** Progress bar, target, deskripsi, list donatur (opsional).
- **Action:** Form komitmen donasi / instruksi transfer / upload bukti.

### H. Forum Diskusi
- **List:** Thread diskusi per kategori.
- **Detail:** Isi thread + Komentar.
- **Create:** Buat thread baru.

### I. Berita
- Informasi sekolah dan kegiatan alumni.

## 4. Skema Database (PocketBase)

Berikut adalah rancangan koleksi (tables) di PocketBase:

### `users`
| Field | Type | Notes |
| :--- | :--- | :--- |
| `id` | System | |
| `username` | Text | |
| `email` | Email | |
| `name` | Text | |
| `avatar` | File | Foto profil |
| `role` | Select | `alumni`, `public` |
| `graduation_year` | Number | (Alumni only) |
| `student_id_number` | Text | NIS/NISN (Optional verification) |
| `profession` | Text | Pekerjaan saat ini |
| `company` | Text | Tempat kerja |
| `domicile` | Text | Kota domisili |
| `phone` | Text | WhatsApp number |
| `bio` | Text | |
| `is_verified` | Bool | Status verifikasi alumni |

### `news`
| Field | Type | Notes |
| :--- | :--- | :--- |
| `title` | Text | |
| `content` | Editor | HTML/Markdown content |
| `image` | File | Thumbnail |
| `category` | Select | `school`, `alumni_activity`, `achievement` |
| `author` | Relation | Relation to `users` (admin) |

### `jobs` (Loker)
| Field | Type | Notes |
| :--- | :--- | :--- |
| `title` | Text | Posisi |
| `company` | Text | Nama Perusahaan |
| `location` | Text | Lokasi kerja |
| `type` | Select | `fulltime`, `contract`, `internship`, `freelance` |
| `salary_range` | Text | e.g., "5jt - 10jt" |
| `description` | Editor | |
| `contact_link` | Url | Link lamaran atau Email |
| `posted_by` | Relation | Relation to `users` |
| `is_active` | Bool | Default True |

### `products` (Marketplace)
| Field | Type | Notes |
| :--- | :--- | :--- |
| `name` | Text | |
| `price` | Number | |
| `description` | Text | |
| `images` | File | Multiple files |
| `category` | Select | `food`, `service`, `merchandise`, `other` |
| `seller` | Relation | Relation to `users` |
| `whatsapp_link` | Url | Link direct WA |

### `donations`
| Field | Type | Notes |
| :--- | :--- | :--- |
| `title` | Text | |
| `description` | Editor | |
| `target_amount` | Number | |
| `current_amount` | Number | Auto-update or manual admin update |
| `deadline` | Date | |
| `banner` | File | |
| `is_urgent` | Bool | |

### `donation_logs`
| Field | Type | Notes |
| :--- | :--- | :--- |
| `donation_id` | Relation | Relation to `donations` |
| `donor_name` | Text | Bisa anonim atau ambil dari user |
| `amount` | Number | |
| `message` | Text | Doa/Dukungan |
| `proof_file` | File | Bukti transfer |
| `status` | Select | `pending`, `verified` |

### `forums`
| Field | Type | Notes |
| :--- | :--- | :--- |
| `title` | Text | |
| `content` | Text | |
| `category` | Select | `general`, `career`, `hobby`, `nostalgia` |
| `author` | Relation | Relation to `users` |

### `forum_comments`
| Field | Type | Notes |
| :--- | :--- | :--- |
| `forum_id` | Relation | Relation to `forums` |
| `user` | Relation | Relation to `users` |
| `content` | Text | |

## 5. Rencana Implementasi (Roadmap)

Urutan pengerjaan yang disarankan agar efisien:

### Fase 1: Setup & Core Foundation
1.  **Inisialisasi Project:** Setup Expo (TypeScript disarankan), setup NativeWind/Tailwind.
2.  **Setup PocketBase:** Deploy PocketBase (lokal/cloud), buat koleksi `users`.
3.  **Authentication Flow:** Implementasi Login, Register, dan Logout.
4.  **Navigation Structure:** Setup Expo Router (Tabs: Home, Directory, Market, Profile).

### Fase 2: Home & Profile (Basic Features)
1.  **Home UI:** Implementasi layout dashboard, slider banner, menu grid.
2.  **Profile & E-KTA:** Tampilan profil user, edit profil, dan generate tampilan E-KTA.
3.  **News Integration:** Buat koleksi `news` dan tampilkan di Home.

### Fase 3: Community Features (Alumni Only)
1.  **Directory:** List user dengan search & filter.
2.  **Jobs (Loker):** CRUD Loker (Create, Read, Update, Delete).
3.  **Marketplace:** CRUD Produk.

### Fase 4: Engagement & Transaction
1.  **Forum:** Implementasi diskusi sederhana.
2.  **Donation:** Tampilan detail donasi dan form konfirmasi donasi.

### Fase 5: Polishing
1.  **Role Based Access Control:** Pastikan user umum tidak bisa akses fitur alumni.
2.  **Loading States & Error Handling:** Skeleton loading, pull to refresh.
3.  **Testing & Deployment.**
