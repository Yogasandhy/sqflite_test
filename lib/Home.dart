import 'package:flutter/material.dart';
import 'package:tes_cappela/Customer.dart';
import 'package:tes_cappela/database.dart';
import 'package:tes_cappela/model.dart';

class Home extends StatefulWidget {
  final Model user;


  const Home({Key? key, required this.user }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseInstance _databaseInstance = DatabaseInstance();
  String? selectedCar;
  List<String> car = ['BK 123', 'BK 897'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hi, ${widget.user.Nama}',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Logout'),
                        content: Text('Apakah anda ingin logout?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('OK'),
                            onPressed: () async {
                              await _databaseInstance
                                  .logout(widget.user.UserId!);
                              Navigator.of(context).pop();
                              Navigator.pushNamed(context, '/login');
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Text(
              "Sebelum berangkat mohon pilih nomor polisi kendaran dan masukkan KM kendaran"),
          SizedBox(
            height: 20,
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.yellow,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: DropdownButton<String>(
              hint: const Text('No. Polisi'),
              value: selectedCar,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCar = newValue;
                });
              },
              items: car.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pilih KM"),
                SizedBox(
                  width: 10,
                ),
                Container(
                    width: 150,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.yellow),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.yellow),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ))
              ],
            ),
          ),
      

          FloatingActionButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder){
              return CustomerScreen();
            }));
          }, child: Icon(Icons.add),)
        ],
      ),
    ));
  }
}
