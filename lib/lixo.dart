// ignore_for_file: non_constant_identifier_names, unnecessary_cast

import 'dart:convert';

class Produto {
  final int ID_PRODUTO;
  final String DESCRICAO;
  final double PRECO;
  final double QTD;
  Produto({
    required this.ID_PRODUTO,
    required this.DESCRICAO,
    required this.PRECO,
    required this.QTD,
  });

  Produto copyWith({
    int? ID_PRODUTO,
    String? DESCRICAO,
    double? PRECO,
    double? QTD,
  }) {
    return Produto(
      ID_PRODUTO: ID_PRODUTO ?? this.ID_PRODUTO,
      DESCRICAO: DESCRICAO ?? this.DESCRICAO,
      PRECO: PRECO ?? this.PRECO,
      QTD: QTD ?? this.QTD,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID_PRODUTO': ID_PRODUTO,
      'DESCRICAO': DESCRICAO,
      'PRECO': PRECO,
      'QTD': QTD,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      ID_PRODUTO: map['ID_PRODUTO'].toInt() as int,
      DESCRICAO: map['DESCRICAO'] as String,
      PRECO: double.parse('${map['PRECO']}') as double,
      QTD: double.parse('${map['QTD']}') as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Produto.fromJson(String source) => Produto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Prodeuto(ID_PRODUTO: $ID_PRODUTO, DESCRICAO: $DESCRICAO, PRECO: $PRECO, QTD: $QTD)';
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
