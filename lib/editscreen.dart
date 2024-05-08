import 'package:flutter/material.dart';
import 'package:tes_cappela/CustomTextField.dart';
import 'package:tes_cappela/ListCustomer.dart';
import 'package:tes_cappela/database.dart';
import 'package:tes_cappela/model.dart';

class EditCustomerScreen extends StatefulWidget {
  final Model customer;

  const EditCustomerScreen({Key? key, required this.customer})
      : super(key: key);

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  DatabaseInstance _databaseInstance = DatabaseInstance();

  late TextEditingController namecusController;
  late TextEditingController alamatController;
  late TextEditingController tgllahirController;
  late TextEditingController nmrtelponController;

  @override
  void initState() {
    super.initState();

    // Inisialisasi controllers dengan data pelanggan saat ini
    namecusController =
        TextEditingController(text: widget.customer.namaLengkap);
    alamatController = TextEditingController(text: widget.customer.alamat);
    tgllahirController =
        TextEditingController(text: widget.customer.TanggalLahir);
    nmrtelponController =
        TextEditingController(text: widget.customer.nomorTelepon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Customer"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  controller: namecusController,
                  hintText: "Masukan Nama",
                  type: TextFieldType.normal,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: alamatController,
                    hintText: "Masukan Alamat",
                    type: TextFieldType.normal),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: tgllahirController,
                    hintText: "Masukan Tanggal Lahir",
                    type: TextFieldType.normal),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: nmrtelponController,
                    hintText: "Masukan Nomor Telepon",
                    type: TextFieldType.normal),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
  onPressed: () async {
    try {
      await _databaseInstance.database();
      await _databaseInstance.update(
          {
            'namaLengkap': namecusController.text,
            'alamat': alamatController.text,
            'TanggalLahir': tgllahirController.text,
            'nomorTelepon': nmrtelponController.text,
          },
          widget.customer.UserId!); // Tambahkan UserId pelanggan saat memanggil update

      // Kembali ke halaman sebelumnya setelah data diperbarui
      Navigator.pop(context);
    } catch (e) {
      print('Error: $e');
      // Tampilkan pesan error ke pengguna
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  },
  child: Text("Submit"),
)

              ],
            ),
          )),
    );
  }
}
