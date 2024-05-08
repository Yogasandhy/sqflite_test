import 'package:flutter/material.dart';
import 'package:tes_cappela/model.dart';

class CustomerDetailScreen extends StatelessWidget {
  final Model customer;

  const CustomerDetailScreen({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pelanggan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nama Lengkap: ${customer.namaLengkap}'),
            Text('Alamat: ${customer.alamat}'),
            Text('Tanggal Lahir: ${customer.TanggalLahir}'),
            Text('Nomor Telepon: ${customer.nomorTelepon}'),
          ],
        ),
      ),
    );
  }
}
