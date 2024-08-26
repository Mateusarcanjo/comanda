// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

class item_comanda {
  final int ID_CONSUMO;
  final String QTD;
  final String DESCRICAO;
  final String OBS;
  final String OBS_OPCIONAL;
  final double VALOR_TOTAL;
  final double VALOR_OPCIONAL;
  item_comanda({
    required this.ID_CONSUMO,
    required this.QTD,
    required this.DESCRICAO,
    required this.OBS,
    required this.OBS_OPCIONAL,
    required this.VALOR_TOTAL,
    required this.VALOR_OPCIONAL,
  });

  item_comanda copyWith({
    int? ID_CONSUMO,
    String? QTD,
    String? DESCRICAO,
    String? OBS,
    String? OBS_OPCIONAL,
    double? VALOR_TOTAL,
    double? VALOR_OPCIONAL,
  }) {
    return item_comanda(
      ID_CONSUMO: ID_CONSUMO ?? this.ID_CONSUMO,
      QTD: QTD ?? this.QTD,
      DESCRICAO: DESCRICAO ?? this.DESCRICAO,
      OBS: OBS ?? this.OBS,
      OBS_OPCIONAL: OBS_OPCIONAL ?? this.OBS_OPCIONAL,
      VALOR_TOTAL: VALOR_TOTAL ?? this.VALOR_TOTAL,
      VALOR_OPCIONAL: VALOR_OPCIONAL ?? this.VALOR_OPCIONAL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID_CONSUMO': ID_CONSUMO,
      'QTD': QTD,
      'DESCRICAO': DESCRICAO,
      'OBS': OBS,
      'OBS_OPCIONAL': OBS_OPCIONAL,
      'VALOR_TOTAL': VALOR_TOTAL,
      'VALOR_OPCIONAL': VALOR_OPCIONAL,
    };
  }

  factory item_comanda.fromMap(Map<String, dynamic> map) {
    return item_comanda(
      ID_CONSUMO: map['ID_CONSUMO'].toInt() as int,
      QTD: map['QTD'].toString(),
      DESCRICAO: map['DESCRICAO'] as String,
      OBS: map['OBS'] as String,
      OBS_OPCIONAL: map['OBS_OPCIONAL'] as String,
      VALOR_TOTAL: map['VALOR_TOTAL'].toDouble() as double,
      VALOR_OPCIONAL: map['VALOR_OPCIONAL'].toDouble() as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory item_comanda.fromJson(String source) => item_comanda.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item_comanda(ID_CONSUMO: $ID_CONSUMO, QTD: $QTD, DESCRICAO: $DESCRICAO, OBS: $OBS, OBS_OPCIONAL: $OBS_OPCIONAL, VALOR_TOTAL: $VALOR_TOTAL, VALOR_OPCIONAL: $VALOR_OPCIONAL)';
  }

  @override
  bool operator ==(covariant item_comanda other) {
    if (identical(this, other)) return true;

    return other.ID_CONSUMO == ID_CONSUMO && other.QTD == QTD && other.DESCRICAO == DESCRICAO && other.OBS == OBS && other.OBS_OPCIONAL == OBS_OPCIONAL && other.VALOR_TOTAL == VALOR_TOTAL && other.VALOR_OPCIONAL == VALOR_OPCIONAL;
  }

  @override
  int get hashCode {
    return ID_CONSUMO.hashCode ^ QTD.hashCode ^ DESCRICAO.hashCode ^ OBS.hashCode ^ OBS_OPCIONAL.hashCode ^ VALOR_TOTAL.hashCode ^ VALOR_OPCIONAL.hashCode;
  }
}

class Categorias {
  final int ID_CATEGORIA;
  final String DESCRICAO;
  final String ICONE;
  Categorias({
    required this.ID_CATEGORIA,
    required this.DESCRICAO,
    required this.ICONE,
  });

  Categorias copyWith({
    int? ID_CATEGORIA,
    String? DESCRICAO,
    String? ICONE,
  }) {
    return Categorias(
      ID_CATEGORIA: ID_CATEGORIA ?? this.ID_CATEGORIA,
      DESCRICAO: DESCRICAO ?? this.DESCRICAO,
      ICONE: ICONE ?? this.ICONE,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID_CATEGORIA': ID_CATEGORIA,
      'DESCRICAO': DESCRICAO,
      'ICONE': ICONE,
    };
  }

  factory Categorias.fromMap(Map<String, dynamic> map) {
    return Categorias(
      ID_CATEGORIA: map['ID_CATEGORIA'].toInt() as int,
      DESCRICAO: map['DESCRICAO'] as String,
      ICONE: map['ICONE'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Categorias.fromJson(String source) => Categorias.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Categorias(ID_CATEGORIA: $ID_CATEGORIA, DESCRICAO: $DESCRICAO, ICONE: $ICONE)';

  @override
  bool operator ==(covariant Categorias other) {
    if (identical(this, other)) return true;

    return other.ID_CATEGORIA == ID_CATEGORIA && other.DESCRICAO == DESCRICAO && other.ICONE == ICONE;
  }

  @override
  int get hashCode => ID_CATEGORIA.hashCode ^ DESCRICAO.hashCode ^ ICONE.hashCode;
}
<<<<<<< HEAD

class Produto {
  final int ID_PRODUTO;
  final String DESCRICAO;
  final double PRECO;
  int QTD;
  List ADICIONAIS = [];
  Produto({
    required this.ID_PRODUTO,
    required this.DESCRICAO,
    required this.PRECO,
    required this.QTD,
    required ADICIONAIS,
  });

  Produto copyWith({
    int? ID_PRODUTO,
    String? DESCRICAO,
    double? PRECO,
    int? QTD,
  }) {
    return Produto(ID_PRODUTO: ID_PRODUTO ?? this.ID_PRODUTO, DESCRICAO: DESCRICAO ?? this.DESCRICAO, PRECO: PRECO ?? this.PRECO, QTD: QTD ?? this.QTD, ADICIONAIS: ADICIONAIS);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID_PRODUTO': ID_PRODUTO,
      'DESCRICAO': DESCRICAO,
      'PRECO': PRECO,
      'QTD': QTD,
      'ADICIONAIS': ADICIONAIS,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(ID_PRODUTO: map['ID_PRODUTO'].toInt() as int, DESCRICAO: map['DESCRICAO'] as String, PRECO: double.parse('${map['PRECO']}'), QTD: (map['QTD'] ?? 1), ADICIONAIS: map['ADICIONAIS']);
  }

  String toJson() => json.encode(toMap());

  factory Produto.fromJson(String source) => Produto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Produto(ID_PRODUTO: $ID_PRODUTO, DESCRICAO: $DESCRICAO, PRECO: $PRECO, QTD: $QTD,ADICIONAIS:$ADICIONAIS)';
  }

  @override
  bool operator ==(covariant Produto other) {
    if (identical(this, other)) return true;

    return other.ID_PRODUTO == ID_PRODUTO && other.DESCRICAO == DESCRICAO && other.PRECO == PRECO && other.QTD == QTD;
  }

  @override
  int get hashCode {
    return ID_PRODUTO.hashCode ^ DESCRICAO.hashCode ^ PRECO.hashCode ^ QTD.hashCode;
  }
}
=======
>>>>>>> 2c0266186783729bc4b27b405cd4cc70e73eb5bb
