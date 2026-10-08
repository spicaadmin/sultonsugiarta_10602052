import 'package:flutter/material.dart';
import '../data/cargo_data.dart';
import 'cargo_booking_screen.dart';

class ManifesMuatanTab extends StatelessWidget {
  const ManifesMuatanTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const Material(
            color: Colors.white,
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.local_shipping), text: 'Armada Tersedia'),
                Tab(icon: Icon(Icons.warning_amber), text: 'Syarat Muatan Berbahaya'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                _ArmadaTab(),
                _HazmatTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArmadaTab extends StatelessWidget {
  const _ArmadaTab();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: daftarArmada.length,
      itemBuilder: (context, index) {
        final armada = daftarArmada[index];
        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      armada.gambar,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 80,
                        height: 80,
                        color: Colors.indigo.shade50,
                        child: const Icon(Icons.local_shipping,
                            size: 40, color: Colors.indigo),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        armada.kapasitas,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            title: Text(armada.nama,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(armada.deskripsi),
            trailing: ElevatedButton(
              onPressed: () async {
                final hasil = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CargoBookingScreen(armada: armada),
                  ),
                );
                if (hasil != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(hasil),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Pilih Armada'),
            ),
          ),
        );
      },
    );
  }
}

class _HazmatTab extends StatefulWidget {
  const _HazmatTab();

  @override
  State<_HazmatTab> createState() => _HazmatTabState();
}

class _HazmatTabState extends State<_HazmatTab> {
  final List<HazmatItem> _items = buatDaftarHazmat();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (index, isExpanded) {
          setState(() => _items[index].expanded = isExpanded);
        },
        children: _items
            .map(
              (item) => ExpansionPanel(
                isExpanded: item.expanded,
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) => ListTile(
                  leading:
                      const Icon(Icons.warning_amber, color: Colors.orange),
                  title: Text(item.judul),
                ),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(item.isi),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
