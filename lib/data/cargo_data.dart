class Armada {
  final String nama;
  final String kapasitas;
  final String deskripsi;
  final String gambar;

  const Armada({
    required this.nama,
    required this.kapasitas,
    required this.deskripsi,
    required this.gambar,
  });
}

class Resi {
  final String noResi;
  final String armada;
  final String kategori;
  final String tonase;
  final String status;

  const Resi({
    required this.noResi,
    required this.armada,
    required this.kategori,
    required this.tonase,
    required this.status,
  });
}

class HazmatItem {
  final String judul;
  final String isi;
  bool expanded;

  HazmatItem({required this.judul, required this.isi, this.expanded = false});
}

const List<Armada> daftarArmada = [
  Armada(
    nama: 'Colt Diesel',
    kapasitas: '4 Ton',
    deskripsi: 'Cocok untuk pengiriman dalam kota dan antar kota jarak dekat.',
    gambar: 'https://picsum.photos/seed/coltdiesel/200/200',
  ),
  Armada(
    nama: 'Fuso',
    kapasitas: '8 Ton',
    deskripsi: 'Armada menengah untuk muatan industri dan distribusi regional.',
    gambar: 'https://picsum.photos/seed/fuso/200/200',
  ),
  Armada(
    nama: 'Tronton',
    kapasitas: '20 Ton',
    deskripsi: 'Armada besar untuk muatan berat dan pengiriman antar pulau.',
    gambar: 'https://picsum.photos/seed/tronton/200/200',
  ),
];

final List<Resi> daftarResi = [
  const Resi(
    noResi: 'CF-0001',
    armada: 'Colt Diesel',
    kategori: 'General Cargo',
    tonase: '3 Ton',
    status: 'Terkirim',
  ),
  const Resi(
    noResi: 'CF-0002',
    armada: 'Fuso',
    kategori: 'Perishable',
    tonase: '6 Ton',
    status: 'Dalam Perjalanan',
  ),
  const Resi(
    noResi: 'CF-0003',
    armada: 'Tronton',
    kategori: 'Alat Berat',
    tonase: '18 Ton',
    status: 'Diproses',
  ),
];

List<HazmatItem> buatDaftarHazmat() => [
      HazmatItem(
        judul: 'Cairan Mudah Terbakar',
        isi:
            'Gunakan wadah tertutup rapat, pasang label bahaya, dan jauhkan dari sumber panas atau percikan api selama pengangkutan.',
      ),
      HazmatItem(
        judul: 'Bahan Kimia Korosif',
        isi:
            'Wajib menggunakan kemasan tahan korosi, sopir memakai APD lengkap, dan sediakan perlengkapan penanganan tumpahan.',
      ),
      HazmatItem(
        judul: 'Gas Bertekanan',
        isi:
            'Tabung harus diikat tegak, dilindungi dari benturan, dan tidak boleh terpapar suhu tinggi di dalam kontainer.',
      ),
      HazmatItem(
        judul: 'Bahan Beracun',
        isi:
            'Pisahkan dari muatan makanan, sertakan dokumen MSDS, dan pastikan pengemudi memiliki sertifikasi B3.',
      ),
    ];
