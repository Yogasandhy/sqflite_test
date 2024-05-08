import 'package:flutter/material.dart';
import 'package:tes_cappela/Detail.dart';
import 'package:tes_cappela/database.dart';
import 'package:tes_cappela/editscreen.dart';
import 'package:tes_cappela/model.dart';

class ListScrenn extends StatefulWidget {
  final List<Model> customers;

  const ListScrenn({Key? key, required this.customers}) : super(key: key);

  @override
  _ListScrennState createState() => _ListScrennState();
}

class _ListScrennState extends State<ListScrenn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.customers.isEmpty
          ? Center(child: Text('Tidak ada data pelanggan'))
          : ListView.builder(
              itemCount: widget.customers.length,
              itemBuilder: (context, index) {
                return ListTile(
                 title: Text("${widget.customers[index].namaLengkap ?? 'Data tidak tersedia'}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CustomerDetailScreen(customer: widget.customers[index]),
                      ),
                    );
                  },
                  // trailing: IconButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) =>
                  //             EditCustomerScreen(customer: widget.customers[index]),
                  //       ),
                  //     );
                  //   },
                  //   icon: Icon(Icons.edit),
                  // ),
                );
              },
            ),
    );
  }
}
