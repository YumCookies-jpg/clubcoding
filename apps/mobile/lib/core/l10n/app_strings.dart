/// All user-facing copy lives here until a second language is requested.
/// Migrating this class to ARB is mechanical; see DL-0003 Q7.
abstract final class AppStrings {
  static const appName = 'ApiPantau';
  static const loading = 'Memuat...';
  static const retry = 'Coba lagi';
  static const backToMap = 'Kembali ke peta';

  static const splashTitle = 'ApiPantau';

  static const loginTitle = 'Masuk';
  static const loginPlaceholder = 'Login nomor HP akan tersedia pada AP-010.';

  static const mapTitle = 'Peta';
  static const mapPlaceholder = 'Peta kejadian akan tersedia pada AP-009.';

  static const reportTitle = 'Lapor';
  static const reportPlaceholder =
      'Formulir laporan akan tersedia pada AP-020.';

  static const alertsTitle = 'Peringatan';
  static const alertsPlaceholder = 'Daftar peringatan akan tersedia pada M3.';

  static const verifyTitle = 'Verifikasi';
  static const verifyPlaceholder =
      'Antrean verifikasi akan tersedia pada AP-060.';

  static const profileTitle = 'Profil';
  static const profilePlaceholder =
      'Pengaturan profil akan tersedia pada AP-053.';

  static const errorTitle = 'Terjadi kesalahan';
  static const notFoundTitle = 'Halaman tidak ditemukan';

  static const configErrorTitle = 'Konfigurasi tidak lengkap';
  static const configErrorHint =
      'Jalankan dengan --dart-define=SUPABASE_URL=... dan '
      '--dart-define=SUPABASE_ANON_KEY=...';

  static const failureNetwork = 'Tidak ada koneksi. Coba lagi.';
  static const failureAuth = 'Sesi atau kode tidak valid.';
  static const failurePermission = 'Anda tidak punya akses.';
  static const failureValidation = 'Data tidak valid.';
  static const failureServer = 'Server sedang bermasalah.';
  static const failureUnknown = 'Terjadi kesalahan.';
}
