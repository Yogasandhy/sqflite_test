import 'package:flutter/material.dart';
import 'package:tes_cappela/database.dart';
import 'CustomTextField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // Tambahkan baris ini
  DatabaseInstance _databaseInstance = DatabaseInstance();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    _databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buat Akun"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: nameController,
                  hintText: 'Masukkan nama',
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Email",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Masukkan email',
                  type: TextFieldType.email,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Masukkan password',
                  type: TextFieldType.password,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Konfirmasi Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: 'Konfirmasi password',
                  type: TextFieldType.confirmPassword,
                  passwordController: passwordController,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: OutlinedButton(
                    onPressed: () async {
                      try {
                        var existingUser = await _databaseInstance
                            .getUserByEmail(emailController.text);
                        if (existingUser != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Akun sudah pernah dibuat'),
                            ),
                          );
                        } else {
                          await _databaseInstance.insert({
                            'Nama': nameController.text,
                            'Email': emailController.text,
                            'Password': passwordController.text,
                            'KonfirmasiPassword':
                                confirmPasswordController.text,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Akun berhasil dibuat'),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        print(
                            'Terjadi error saat mencoba memasukkan data ke database: $e');
                      }
                    },
                    child: Text("Register"),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
