// ignore_for_file: avoid_print , ignore_for_file: prefer__ructors,  unused_import, prefer__literals_to_create_immutables, non_ant_identifier_names, prefer__ructors, unused_local_variable, unused_catch_clause, prefer_const_constructors, prefer_const_constructors_in_immutables
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:comanda/detalhes.dart';
import 'package:comanda/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo Comanda',
      home: MyHomePage(),
    );
  }
}
