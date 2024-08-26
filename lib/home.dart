<<<<<<< HEAD
// ignore_for_file: prefer_const_constructors, avoid_print, unused_catch_clause, non_constant_identifier_names, prefer_interpolation_to_compose_strings
=======
// ignore_for_file: prefer_const_constructors, avoid_print, unused_catch_clause, non_constant_identifier_names
>>>>>>> 2c0266186783729bc4b27b405cd4cc70e73eb5bb

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:comanda/detalhes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lan_scanner/lan_scanner.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
<<<<<<< HEAD
import 'package:animated_icon/animated_icon.dart';
=======
>>>>>>> 2c0266186783729bc4b27b405cd4cc70e73eb5bb

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
<<<<<<< HEAD
  bool ativo = false;
  IconData icone = Icons.wifi;
  double? progress = 0.0;

  final List<Host> _hosts = <Host>[];
  final TextEditingController _id_comanda = TextEditingController();
  final List _msg = [];
  var _servidor = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    resolve(Theme.of(context).platform);
    super.didChangeDependencies();
  }
=======
  final TextEditingController _id_comanda = TextEditingController();
  final List<Host> _hosts = <Host>[];
  final List _msg = [];
  var _servidor = '';

  double? progress = 0.0;
>>>>>>> 2c0266186783729bc4b27b405cd4cc70e73eb5bb

  Future<bool> scan() async {
    setState(() {
      progress = null;
      _hosts.clear();
      _msg.clear();
    });

    final scanner = LanScanner(debugLogging: false);
    final hosts = await scanner.quickIcmpScanAsync(
      ipToCSubnet(await NetworkInfo().getWifiIP() ?? ''),
    );
    setState(() {
      _hosts.addAll(hosts);
    });
    return true;
  }

<<<<<<< HEAD
  resolve(TargetPlatform platforma) async {
    ativo = false;
    _servidor = '';
    print('Me chamou');
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('user') != null) {
      setState(() {
        progress = null;
      });
      String servidor = jsonDecode('${prefs.getString('user')}')[0]['IP'];
      _servidor = 'Conectado em ' + jsonDecode('${prefs.getString('user')}')[0]['SERVIDOR'];
=======
  resolve() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('user')!);
    if (prefs.getString('user')!.isNotEmpty) {
      String servidor = jsonDecode('${prefs.getString('user')}')[0]['IP'];
      _servidor = jsonDecode('${prefs.getString('user')}')[0]['SERVIDOR'];
>>>>>>> 2c0266186783729bc4b27b405cd4cc70e73eb5bb

      print(_hosts.length);
      try {
        final response = await http.get(Uri.http(servidor, '/Ping'));
        print(response.body);
<<<<<<< HEAD
        setState(() {
          progress = 1;
          icone = Icons.wifi;
        });
      } on SocketException catch (error) {
        setState(() {
          prefs.remove('user');
          resolve(platforma);
          ativo = false;
=======
      } on SocketException catch (error) {
        setState(() {
          prefs.remove('user');
          resolve();
>>>>>>> 2c0266186783729bc4b27b405cd4cc70e73eb5bb
          print('😱 ${error.message}');
        });
      } on HttpException catch (error) {
        setState(() {
          print('😑 Nao Me respondeu por ${error.message}');
        });
      } on FormatException catch (error) {
        print('Me respondeu de um jeito ruim ${error.message}');

        print("Bad response format 👎");
      }
    } else {
<<<<<<< HEAD
      if (platforma == TargetPlatform.android && await scan()) {
        for (var i = 0; i < _hosts.length; i++) {
          try {
            if (_hosts[i].pingTime!.inMilliseconds > 0) {
=======
      if (await scan()) {
        for (var i = 0; i < _hosts.length; i++) {
          try {
            if (_hosts[i].pingTime!.inMilliseconds > 2) {
>>>>>>> 2c0266186783729bc4b27b405cd4cc70e73eb5bb
              print('${_hosts[i].internetAddress.address}|${_hosts[i].pingTime?.inMilliseconds}');
              final response = await http.get(Uri.http(_hosts[i].internetAddress.address, '/Ping'));
              if (response.statusCode != 200) throw HttpException('${response.statusCode}');
              Map<String, dynamic> json = jsonDecode(response.body);

<<<<<<< HEAD
              //print(json);

              setState(() {
                json['RESULT'][0].addAll({'IP': _hosts[i].internetAddress.address});
                _servidor = 'Conectado em ' + json['RESULT'][0]['SERVIDOR'];
=======
              print(json);

              setState(() {
                json['RESULT'][0].addAll({'IP': _hosts[i].internetAddress.address});
                _servidor = json['RESULT'][0]['SERVIDOR'];
>>>>>>> 2c0266186783729bc4b27b405cd4cc70e73eb5bb
                String user = jsonEncode(json['RESULT']);
                prefs.remove('user');
                prefs.setString('user', user);
                progress = 1.0;
<<<<<<< HEAD
                icone = Icons.wifi;
                ativo = true;
=======
>>>>>>> 2c0266186783729bc4b27b405cd4cc70e73eb5bb
              });
            }
          } on SocketException catch (error) {
            setState(() {
              // _msg[i] = ('😱 ${error.message}');
            });
          } on HttpException catch (error) {
            setState(() {
              //  _msg[i] = ('😑 Nao Me respondeu por ${error.message}');
            });
          } on FormatException catch (error) {
            setState(() {
              //  _msg[i] = ('Me respondeu de um jeito ruim ${error.message}');
            });

            print("Bad response format 👎");
          }
        }
        if (_servidor == '') {
          setState(() {
            _servidor = 'Nao foi Possivel encontrar o servidor';
<<<<<<< HEAD
            icone = Icons.wifi_off;
          });
        }
      } else if (platforma == TargetPlatform.windows) {
        setState(() {
          Map<String, dynamic> json = jsonDecode('{"PARAMS":[null], "RESULT":[{"SERVIDOR":"Revision-PC"}]}');
          jsonEncode(json['RESULT'][0].addAll({'IP': '192.168.1.25'}));
          _servidor = 'Conectado em ' + json['RESULT'][0]['SERVIDOR'];
          String user = jsonEncode(json['RESULT']);
          prefs.remove('user');
          prefs.setString('user', user);
          progress = 1.0;
          icone = Icons.wifi;
          ativo = true;
        });
      } else {
        setState(() {
          _servidor = 'Nao foi Possivel encontrar o servidor';
          icone = Icons.wifi_off;
        });
      }
    }
    ativo = true;
=======
          });
        }
      } else {
        setState(() {
          _servidor = 'Nao foi Possivel encontrar o servidor';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    resolve();
>>>>>>> 2c0266186783729bc4b27b405cd4cc70e73eb5bb
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final platform = Theme.of(context).platform;
    return Scaffold(
      appBar: AppBar(
        title: Text('Comanda'),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  resolve(platform);
                },
                child: ativo
                    ? Icon(
                        icone,
                        size: 40.0,
                      )
                    : AnimateIcon(
                        key: UniqueKey(),
                        onTap: () {},
                        iconType: IconType.continueAnimation,
                        height: 50,
                        width: 50,
                        animateIcon: AnimateIcons.wifiSearch,
                      ),
              ))
        ],
=======
    return Scaffold(
      appBar: AppBar(
        title: Text('Comanda'),
>>>>>>> 2c0266186783729bc4b27b405cd4cc70e73eb5bb
      ),
      body: SafeArea(
        child: Column(children: [
          _servidor == ''
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LinearProgressIndicator(value: progress),
                    Text(" Procurando Servidor"),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
<<<<<<< HEAD
                    Text(" $_servidor"),
=======
                    Text(" Conectado em $_servidor"),
>>>>>>> 2c0266186783729bc4b27b405cd4cc70e73eb5bb
                  ],
                ),
          Expanded(
              child: Center(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.50,
                      child: Card(
                        // color: Colors.blueAccent[400],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30),
                            Text(
                              "Digite o Numero da comanda ou da Mesa",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 30),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: _id_comanda,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.pinkAccent,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                              ),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: CupertinoButton(
                                padding: EdgeInsets.all(17),
                                color: Colors.greenAccent,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => detalhes_comanda(
                                        id_comanda: _id_comanda.text,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Acessar",
                                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(height: 7),
                          ],
                        ),
<<<<<<< HEAD
                      )))),
=======
                      ))))
>>>>>>> 2c0266186783729bc4b27b405cd4cc70e73eb5bb
        ]),
      ),
    );
  }
}
