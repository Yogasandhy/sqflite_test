import 'package:flutter/material.dart';
import 'package:tes_cappela/CustomTextField.dart';
import 'package:tes_cappela/ListCustomer.dart';
import 'package:tes_cappela/database.dart';
import 'package:tes_cappela/model.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  DatabaseInstance _databaseInstance = DatabaseInstance();

  TextEditingController namecusController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tgllahir = TextEditingController();
  TextEditingController nmrtelpon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Customer"),
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
                    controller: tgllahir,
                    hintText: "Masukan Tanggal Lahir",
                    type: TextFieldType.normal),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: nmrtelpon,
                    hintText: "Masukan Nomor Telepon",
                    type: TextFieldType.normal),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _databaseInstance.database();
                    int id = await _databaseInstance.insert({
                      'namaLengkap': namecusController.text,
                      'alamat': alamatController.text,
                      'TanggalLahir': tgllahir.text,
                      'nomorTelepon': nmrtelpon.text,
                    });

                    if (id != 0) {
                      try {
                        List<Model> customers =
                            await _databaseInstance.getAllCustomers();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ListScrenn(customers: customers),
                          ),
                        );
                      } catch (e) {
                        print('Error: $e');
                      }
                    } else {
                      print('Insert operation failed');
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
