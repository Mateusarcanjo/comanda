// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, unused_local_variable, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:comanda/dm_module.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class AdicionarItem extends StatefulWidget {
  const AdicionarItem({super.key});

  @override
  _AdicionarItemState createState() => _AdicionarItemState();
}

class _AdicionarItemState extends State<AdicionarItem> {
  String basicAuth = 'Basic ${base64Encode(utf8.encode('testserver:testserver'))}';
  List<Categorias> categorias = [];
  bool lista_grid = false;
  List<Produto> produtos = [];
  List<Widget> n_categoria = [Tab(child: Text('Carregando'))];
  TextEditingController qtdController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  MultiSelectController Multi_controller = MultiSelectController();
  List<Widget> tela_categoria = [Text('Carregando')];
  List<ValueItem<dynamic>> adicional = [];

  var _qtd = 1;

  @override
  void initState() {
    super.initState();
    carrega_categorias();
    lista_adicional();
  }

  carrega_categorias() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      final response = await http.get(
        Uri.http(jsonDecode('${prefs.getString('user')}')[0]['IP'], '/ListarCategoria'),
        headers: {'authorization': basicAuth},
      );
      var _dados = jsonDecode(response.body);
      var _tempLista = [];
      for (var element in _dados) {
        final listarProduto = await http.get(
          Uri.http(jsonDecode('${prefs.getString('user')}')[0]['IP'], '/ListarProduto', {'id_categoria': '${element['ID_CATEGORIA']}'}),
          headers: {'authorization': basicAuth},
        );
        //print(listarProduto.body);
        try {
          _tempLista.add(jsonDecode(listarProduto.body));
          setState(() {
            n_categoria = List.generate(_dados.length, (i) {
              return Tab(
                  child: Text(
                _dados[i]['DESCRICAO'],
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ));
            });

            setState(() {
              tela_categoria = List.generate(_dados.length, (i) {
                List<Widget> tempwidget = [];
                for (var element in _tempLista[i]) {
                  tempwidget.add(GestureDetector(
                      onTap: () {
                        setState(() {
                          qtdController.text = '1';
                        });
                        Future<void> future = showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                return FractionallySizedBox(
                                  heightFactor: 0.9,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.arrow_drop_down_circle),
                                        title: Text(element['DESCRICAO']),
                                        subtitle: Text('Composição:' + element['COMPOSICAO']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('Preco.: R\$ ${element['PRECO'].toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                                            Text(' '),
                                            Text('Total.: R\$ ' + ((element['PRECO']) * _qtd).toStringAsFixed(2), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (_qtd > 1) {
                                                      _qtd = _qtd - 1;
                                                    }
                                                    qtdController.text = '$_qtd';
                                                  });
                                                },
                                                icon: Icon(Icons.minimize)),
                                            SizedBox(
                                                width: 50.0,
                                                child: TextField(
                                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                    onChanged: (String value) {
                                                      print('Valor $value');
                                                      setState(() {
                                                        if (value == '') {
                                                          _qtd = 0;
                                                        } else {
                                                          _qtd = int.parse(value);
                                                          qtdController.text = value;
                                                        }
                                                      });
                                                    },
                                                    keyboardType: TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    controller: qtdController,
                                                    style: TextStyle(fontSize: 25, height: 3.0, color: const Color.fromARGB(255, 70, 56, 56)))),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _qtd = _qtd + 1;
                                                    qtdController.text = '$_qtd';
                                                  });
                                                },
                                                icon: Icon(Icons.add)),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: [
                                            MultiSelectDropDown(
                                              onOptionSelected: (options) {
                                                setState(() {});
                                              },
                                              options: adicional,
                                              //maxItems: 2,
                                              // disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
                                              controller: Multi_controller,
                                              selectionType: SelectionType.multi,
                                              hint: 'Adicionais ?',
                                              chipConfig: const ChipConfig(wrapType: WrapType.scroll, backgroundColor: Color.fromARGB(255, 57, 54, 244)),
                                              dropdownHeight: 300,
                                              optionTextStyle: const TextStyle(fontSize: 16), singleSelectItemStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                              selectedOptionIcon: const Icon(Icons.check_circle),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Multi_controller.selectedOptions.isNotEmpty
                                                ? SingleChildScrollView(
                                                    scrollDirection: Axis.vertical,
                                                    child: SizedBox(
                                                        height: MediaQuery.of(context).size.height / 4,
                                                        child: DataTable(
                                                          border: TableBorder(
                                                            horizontalInside: BorderSide(
                                                              color: Colors.black,
                                                              style: BorderStyle.solid,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          columns: [DataColumn(label: Text('ID')), DataColumn(label: Text('Descrição')), DataColumn(label: Text('Valor'))],
                                                          rows: Multi_controller.selectedOptions
                                                              .map((element) => DataRow(cells: [
                                                                    DataCell(Text('#' + (Multi_controller.selectedOptions.indexOf(element) + 1).toString())),
                                                                    DataCell(Text(element.label.substring(0, element.label.indexOf('|x|')))),
                                                                    DataCell(Text(element.label.substring(element.label.indexOf('|x|') + 3))),
                                                                  ]))
                                                              .toList(),
                                                        )))
                                                : Text('')
                                          ],
                                        ),
                                      )),
                                      Padding(padding: const EdgeInsets.all(16.0), child: Column()),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 5,
                                                backgroundColor: Colors.black87,
                                                foregroundColor: Colors.white,
                                                textStyle: TextStyle(color: Colors.black, fontStyle: FontStyle.italic, fontSize: 25),
                                              ),
                                              onPressed: () {
                                                if (_qtd > 0) {
                                                  adiciona_carrinho(element);
                                                  setState(() {
                                                    _qtd = 1;
                                                  });
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Adicionar Item'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            }).whenComplete(() {
                          setState(() {
                            qtdController.text = '1';
                            _qtd = 1;
                          });
                        });
                        future.then((void value) => Multi_controller.clearAllSelection());
                      },
                      child: Card(
                          elevation: 3,
                          child: Column(
                            children: [
                              !lista_grid
                                  ? ListTile(
                                      title: Text(
                                        '${element['ID_PRODUTO']} x ${element['DESCRICAO']}',
                                        style: GoogleFonts.lato(
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        UtilBrasilFields.obterReal(double.parse('${element['PRECO']}')),
                                        style: GoogleFonts.lato(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 27, 70, 224),
                                        ),
                                      ),
                                      trailing: Icon(Icons.shopping_cart_checkout, color: Colors.red),
                                    )
                                  : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          maxLines: 2,
                                          '${element['DESCRICAO']}',
                                          style: GoogleFonts.lato(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          UtilBrasilFields.obterReal(double.parse('${element['PRECO']}')),
                                          style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 27, 70, 224),
                                          ),
                                        ),
                                      ],
                                      //leading: UtilBrasilFields.isCNPJValido(items[index]['cnpj']) ? Icon(Icons.emoji_transportation, color: Colors.black) : Icon(Icons.emoji_people, color: Colors.black45),
                                    )
                            ],
                          ))));
                  //print(element);
                }
                if (lista_grid) {
                  return GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemCount: tempwidget.length,
                    itemBuilder: (context, index) {
                      return tempwidget[index];
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: tempwidget.length,
                    itemBuilder: (context, index) {
                      return tempwidget[index];
                    },
                  );
                }
              });
            });
          });
        } catch (e) {
          print(e.toString());
        }
      }
    }
  }

  adiciona_carrinho(dynamic _produto) {
    Produto produto = Produto.fromMap(_produto);

    setState(() {
      produto.QTD = _qtd;
      produto.ADICIONAIS = Multi_controller.selectedOptions.map((element) {
        return element.value;
      }).toList();
    });

    produtos.add((produto));
  }

  lista_adicional() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      final response = await http.get(
        Uri.http(jsonDecode('${prefs.getString('user')}')[0]['IP'], '/ListaAdicional'),
        headers: {'authorization': basicAuth},
      );
      try {
        var _adicionais = jsonDecode(response.body)['RESULT'][0];

        List<ValueItem<dynamic>> _adicional = [];

        for (var i = 0; i < _adicionais.length; i++) {
          _adicional.add(ValueItem(label: '${_adicionais[i]['DESCRICAO']} |x| R\$${double.parse(_adicionais[i]['PRECO'].toString())}', value: _adicionais[i]['ID_PRODUTO']));
        }
        setState(() {
          adicional = _adicional;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }
          Navigator.pop(context, produtos);
        },
        child: DefaultTabController(
          length: n_categoria.length,
          child: Scaffold(
            appBar: AppBar(
                bottom: TabBar(
                  isScrollable: true,
                  tabs: n_categoria,
                ),
                actions: [
                  Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          carrega_categorias();
                        },
                        child: Icon(
                          Icons.refresh,
                          size: 40.0,
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            lista_grid = !lista_grid;
                          });
                          carrega_categorias();
                        },
                        child: Icon(
                          lista_grid ? Icons.list : Icons.view_compact,
                          size: 40.0,
                        ),
                      )),
                ]),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: tela_categoria,
            ),
          ),
        ));
  }
}
