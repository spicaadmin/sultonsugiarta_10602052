import 'package:flutter/material.dart';
import 'informasi_depo_tab.dart';
import 'login_screen.dart';
import 'manifes_muatan_tab.dart';
import 'rekap_resi_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _index = 0;

  static const _judul = ['Manifes Muatan', 'Rekap Resi', 'Informasi Depo'];
  static const _halaman = [
    ManifesMuatanTab(),
    RekapResiTab(),
    InformasiDepoTab(),
  ];

  void _pilih(int i) {
    setState(() => _index = i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_judul[_index])),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.local_shipping,
                        size: 32, color: Colors.indigo),
                  ),
                  SizedBox(height: 10),
                  Text('Armada: B 9123 CF',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text('Staf: petugas',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.inventory_2),
              title: const Text('Manifes Muatan'),
              onTap: () {
                _pilih(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Rekap Resi'),
              onTap: () {
                _pilih(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.warehouse),
              title: const Text('Informasi Depo'),
              onTap: () {
                _pilih(2);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Keluar'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: _halaman[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _pilih,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2), label: 'Manifes Muatan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Rekap Resi'),
          BottomNavigationBarItem(
              icon: Icon(Icons.warehouse), label: 'Informasi Depo'),
        ],
      ),
    );
  }
}
