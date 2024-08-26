// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:convert';
import 'package:comanda/adicionar_item.dart';
import 'package:shadow/shadow.dart';
import 'package:http/http.dart' as http;
import 'package:comanda/dm_module.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class detalhes_comanda extends StatefulWidget {
  detalhes_comanda({super.key, required this.id_comanda}); // O construtor que permite receber seus dois parâmetros.

  final String id_comanda;

  @override
  State<StatefulWidget> createState() {
    return _detalhes_comanda();
  }
}

class _detalhes_comanda extends State<detalhes_comanda> {
  List<item_comanda> itens_comanda = [];
  double total_pedido = 0;
  String basicAuth = 'Basic ${base64Encode(utf8.encode('testserver:testserver'))}';
  lista_itens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      final response = await http.get(
        Uri.http(jsonDecode('${prefs.getString('user')}')[0]['IP'], '/ListarProdutoComanda', {'id_comanda': widget.id_comanda}),
        headers: {'authorization': basicAuth},
      );
      List _dados;
      try {
        _dados = jsonDecode(response.body);
      } catch (e) {
        _dados = [];
      }
      setState(() {
        itens_comanda = List.generate(_dados.length, (i) {
          total_pedido = total_pedido + _dados[i]['VALOR_TOTAL'].toDouble();
          return item_comanda.fromMap(_dados[i]);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    lista_itens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.more_horiz,
                  size: 40.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _navigateAndDisplaySelection(context);
                },
                child: Icon(
                  Icons.add,
                  size: 40.0,
                ),
              )),
        ],
        title: const Text('Detalhes'),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shadow(
              options: ShadowOptions(
                blur: 3,
              ),
              child: Text(
                ' Comanda / Mesa',
                textAlign: TextAlign.left,
                style: GoogleFonts.lato(fontSize: 40),
              )),
          Shadow(
              options: ShadowOptions(blur: 1, offset: Offset(4, 4)),
              child: Text(
                ' ${widget.id_comanda}',
                style: GoogleFonts.lato(
                  fontSize: 40,
                  color: Color.fromARGB(255, 74, 112, 247),
                  fontWeight: FontWeight.bold,
                ),
              )),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                reverse: false,
                itemCount: itens_comanda.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {},
                          title: Text(
                            '${UtilBrasilFields.obterReal(double.parse(itens_comanda[index].QTD), moeda: false, decimal: ((itens_comanda[index].QTD.contains('.'))) ? itens_comanda[index].QTD.length - itens_comanda[index].QTD.indexOf('.') - 1 : 0)} x ${itens_comanda[index].DESCRICAO}',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            UtilBrasilFields.obterReal(itens_comanda[index].VALOR_TOTAL),
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 27, 70, 224),
                            ),
                          ),
                          //leading: UtilBrasilFields.isCNPJValido(items[index]['cnpj']) ? Icon(Icons.emoji_transportation, color: Colors.black) : Icon(Icons.emoji_people, color: Colors.black45),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        )
                      ],
                    ),
                  );
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.bottomRight,
                    child: Shadow(
                      options: ShadowOptions(
                        blur: 4,
                        offset: Offset(3, 3),
                      ),
                      child: Text(
                        UtilBrasilFields.obterReal(total_pedido),
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w400,
                          fontSize: 50,
                          color: Color.fromARGB(255, 52, 92, 236),
                        ),
                      ),
                    )),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          elevation: 5,
                          backgroundColor: Colors.black,
                          fixedSize: Size(MediaQuery.of(context).size.width * 0.99, 45),
                        ),
                        child: Text(
                          'Fechar ',
                          style: GoogleFonts.lato(color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    List<Produto> _Produtos = [];
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdicionarItem()),
    ).then((val) {
      setState(() {
        _Produtos = val;
      });
      print(val); //you get details from screen2 here
    });
  }
}
