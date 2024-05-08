import 'package:flutter/material.dart';
import 'package:tes_cappela/Home.dart';
import 'package:tes_cappela/RegisterScreen.dart';
import 'package:tes_cappela/database.dart';
import 'CustomTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DatabaseInstance _databaseInstance = DatabaseInstance();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Center(
                    child: Image.asset('assets/LoginScreen.png'),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Pastikan akun login anda sudah benar",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 25,
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
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        try {
                          var user = await _databaseInstance.getusers(
                              emailController.text, passwordController.text);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) {
                            return Home(user: user);
                          }));

                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              content: Text('Login berhasil'),
                              leading:
                                  Icon(Icons.check_circle, color: Colors.green),
                              backgroundColor: Colors.lightGreen[100]!,
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentMaterialBanner();
                                  },
                                ),
                              ],
                            ),
                          );

                          Future.delayed(Duration(seconds: 2), () {
                            ScaffoldMessenger.of(context)
                                .hideCurrentMaterialBanner();
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              content: Text('Email atau password salah'),
                              leading: Icon(Icons.error),
                              backgroundColor: Colors.red,
                              actions: [
                                TextButton(
                                  child: Text('TUTUP'),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentMaterialBanner();
                                  },
                                ),
                              ],
                            ),
                          );
                          Future.delayed(Duration(seconds: 2), () {
                            ScaffoldMessenger.of(context)
                                .hideCurrentMaterialBanner();
                          });
                        }
                      },
                      child: SizedBox(
                        width: 60,
                        child: Center(
                          child: Text("Login"),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return RegisterScreen();
                        })).then((value) {
                          setState(() {});
                        });
                      },
                      child: SizedBox(
                        width: 60,
                        child: Center(
                          child: Text("Register"),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ))),
    );
  }
}
