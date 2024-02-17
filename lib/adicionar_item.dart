// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names
import 'dart:convert';
import 'package:comanda/dm_module.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class AdicionarItem extends StatefulWidget {
  const AdicionarItem({super.key});

  @override
  _AdicionarItemState createState() => _AdicionarItemState();
}

class _AdicionarItemState extends State<AdicionarItem> {
  List<Categorias> categorias = [];
  List<Widget> n_categoria = [];

  carrega_categorias() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.http(jsonDecode('${prefs.getString('user')}')[0]['IP'], '/ListarProdutoComanda'));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.flight)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
          title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.flight, size: 350),
            Icon(Icons.directions_transit, size: 350),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
