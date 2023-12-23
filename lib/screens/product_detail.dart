import 'package:flutter/material.dart';
import 'package:toko_kadal_mobile/screens/list_product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toko_kadal_mobile/models/product.dart';
import 'package:toko_kadal_mobile/widgets/left_drawer.dart';

class DetailItem extends StatelessWidget {
  final Product item;

  // const DetailItem(this.item, {super.key});
  const DetailItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: LeftDrawer(),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text("NAME : ${item.fields.name}"),
            Text("AMOUNT : ${item.fields.amount}"),
            const SizedBox(height: 10),
            Text("${item.fields.description}"),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text('List Produk'),
              // Bagian redirection ke MyHomePage
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}