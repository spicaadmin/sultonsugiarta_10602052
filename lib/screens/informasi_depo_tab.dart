import 'package:flutter/material.dart';

class InformasiDepoTab extends StatelessWidget {
  const InformasiDepoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Icon(Icons.warehouse, size: 72, color: Colors.indigo)),
          SizedBox(height: 16),
          Text('Identitas Gudang Utama',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          SelectableText(
            'Depo Utama CargoFlow Subang\n'
            'Jl. Raya Pantura KM 12, Subang, Jawa Barat\n'
            'Telp: (0260) 555-0123',
          ),
          SizedBox(height: 24),
          Text('Kode Tracking API Pusat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          SelectableText(
            'CF-API-TRK-9F2A-7B31-C0DE',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 16,
              color: Colors.indigo,
            ),
          ),
          SizedBox(height: 8),
          Text('Tekan dan tahan teks untuk menyalin.',
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
