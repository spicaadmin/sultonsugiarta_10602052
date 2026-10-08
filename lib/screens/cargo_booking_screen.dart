import 'package:flutter/material.dart';
import '../data/cargo_data.dart';

class CargoBookingScreen extends StatefulWidget {
  final Armada armada;

  const CargoBookingScreen({super.key, required this.armada});

  @override
  State<CargoBookingScreen> createState() => _CargoBookingScreenState();
}

class _CargoBookingScreenState extends State<CargoBookingScreen> {
  static const _kategoriList = [
    'General Cargo',
    'Makanan Beku/Perishable',
    'Alat Berat',
  ];
  static const _proteksiList = {
    'Asuransi Barang Rusak': 150000,
    'Jasa Forklift Muat': 200000,
    'Pengawalan Prioritas': 350000,
  };

  String _kategori = _kategoriList.first;
  final Set<String> _proteksiDipilih = {};
  DateTime? _tanggal;
  TimeOfDay? _jam;
  double _tonase = 1;
  bool _reefer = false;

  double get _maxTonase => widget.armada.nama == 'Colt Diesel'
      ? 4
      : widget.armada.nama == 'Fuso'
          ? 8
          : 20;

  int get _tarifDasar => widget.armada.nama == 'Colt Diesel'
      ? 500000
      : widget.armada.nama == 'Fuso'
          ? 900000
          : 1800000;

  int get _totalBiaya {
    var total = _tarifDasar + (_tonase * 100000).round();
    if (_kategori == 'Makanan Beku/Perishable') total += 250000;
    if (_kategori == 'Alat Berat') total += 400000;
    for (final p in _proteksiDipilih) {
      total += _proteksiList[p]!;
    }
    if (_reefer) total += 600000;
    return total;
  }

  String _rp(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return 'Rp $buf';
  }

  Future<void> _pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: _tanggal ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (hasil != null) setState(() => _tanggal = hasil);
  }

  Future<void> _pilihJam() async {
    final hasil = await showTimePicker(
      context: context,
      initialTime: _jam ?? TimeOfDay.now(),
    );
    if (hasil != null) setState(() => _jam = hasil);
  }

  void _hitungBiaya() {
    if (_tanggal == null || _jam == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Lengkapi tanggal penjemputan dan jam keberangkatan.')),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetCtx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rincian Biaya Surat Jalan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            _baris('Armada', widget.armada.nama),
            _baris('Kategori', _kategori),
            _baris('Tonase', '${_tonase.toStringAsFixed(1)} Ton'),
            _baris('Proteksi',
                _proteksiDipilih.isEmpty ? '-' : _proteksiDipilih.join(', ')),
            _baris('Reefer Container', _reefer ? 'Aktif' : 'Tidak'),
            _baris('Penjemputan',
                '${_tanggal!.day}/${_tanggal!.month}/${_tanggal!.year} ${_jam!.format(context)}'),
            const Divider(),
            _baris('Total Biaya', _rp(_totalBiaya), tebal: true),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => _konfirmasi(sheetCtx),
                child: const Text('Konfirmasi & Terbitkan Surat Jalan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _baris(String label, String nilai, {bool tebal = false}) {
    final style = TextStyle(
        fontWeight: tebal ? FontWeight.bold : FontWeight.normal,
        fontSize: tebal ? 16 : 14);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 130, child: Text(label, style: style)),
          Expanded(child: Text(nilai, style: style)),
        ],
      ),
    );
  }

  void _konfirmasi(BuildContext sheetCtx) {
    showDialog(
      context: sheetCtx,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Terbitkan Surat Jalan?'),
        content: Text(
            'Surat jalan untuk ${widget.armada.nama} dengan total ${_rp(_totalBiaya)} akan diterbitkan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              final noResi = 'CF-${DateTime.now().millisecondsSinceEpoch % 10000}';
              Navigator.pop(dialogCtx); // tutup dialog
              Navigator.pop(sheetCtx); // tutup bottom sheet
              Navigator.pop(
                context,
                'Resi $noResi berhasil diterbitkan untuk ${widget.armada.nama}',
              ); // kirim returning data ke layar utama
            },
            child: const Text('Setuju'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tonaseMax = _maxTonase;
    if (_tonase > tonaseMax) _tonase = tonaseMax;

    return Scaffold(
      appBar: AppBar(title: Text('Booking: ${widget.armada.nama}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.local_shipping, color: Colors.indigo),
              title: Text(widget.armada.nama),
              subtitle: Text('Kapasitas ${widget.armada.kapasitas}'),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Kategori Muatan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          RadioGroup<String>(
            groupValue: _kategori,
            onChanged: (v) => setState(() => _kategori = v!),
            child: Column(
              children: _kategoriList
                  .map((k) => RadioListTile<String>(
                        title: Text(k),
                        value: k,
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 8),
          const Text('Proteksi Pengiriman',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ..._proteksiList.keys.map(
            (p) => CheckboxListTile(
              title: Text(p),
              value: _proteksiDipilih.contains(p),
              onChanged: (v) => setState(() {
                if (v == true) {
                  _proteksiDipilih.add(p);
                } else {
                  _proteksiDipilih.remove(p);
                }
              }),
            ),
          ),
          const SizedBox(height: 8),
          const Text('Jadwal Pengambilan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pilihTanggal,
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_tanggal == null
                      ? 'Pilih Tanggal'
                      : '${_tanggal!.day}/${_tanggal!.month}/${_tanggal!.year}'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pilihJam,
                  icon: const Icon(Icons.access_time),
                  label: Text(_jam == null ? 'Pilih Jam' : _jam!.format(context)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Pengaturan Muatan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text('Estimasi Tonase: ${_tonase.toStringAsFixed(1)} Ton'),
          Slider(
            value: _tonase,
            min: 1,
            max: tonaseMax,
            divisions: ((tonaseMax - 1) * 2).round(),
            label: '${_tonase.toStringAsFixed(1)} Ton',
            onChanged: (v) => setState(() => _tonase = v),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Min: 1 Ton', style: TextStyle(color: Colors.grey)),
              Text('Maks: ${tonaseMax.toStringAsFixed(0)} Ton',
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
          SwitchListTile(
            title: const Text('Mesin Pendingin (Reefer Container)'),
            value: _reefer,
            onChanged: (v) => setState(() => _reefer = v),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: FilledButton.icon(
              onPressed: _hitungBiaya,
              icon: const Icon(Icons.calculate),
              label: const Text('Hitung Biaya Logistik'),
            ),
          ),
        ],
      ),
    );
  }
}
