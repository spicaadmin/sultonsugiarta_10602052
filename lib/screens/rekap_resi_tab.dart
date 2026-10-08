import 'package:flutter/material.dart';
import '../data/cargo_data.dart';

class RekapResiTab extends StatelessWidget {
  const RekapResiTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStatePropertyAll(Colors.indigo.shade50),
          columns: const [
            DataColumn(label: Text('No. Resi')),
            DataColumn(label: Text('Armada')),
            DataColumn(label: Text('Kategori')),
            DataColumn(label: Text('Tonase')),
            DataColumn(label: Text('Status')),
          ],
          rows: daftarResi
              .map(
                (r) => DataRow(cells: [
                  DataCell(Text(r.noResi)),
                  DataCell(Text(r.armada)),
                  DataCell(Text(r.kategori)),
                  DataCell(Text(r.tonase)),
                  DataCell(Text(r.status)),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }
}
