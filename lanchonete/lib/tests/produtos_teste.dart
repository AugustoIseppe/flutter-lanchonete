class Produtos {
  int id;
  String nome;
  String descricao;
  String descricaoLonga;
  int valor;
  int categoria;
  String imagem; // Tratando imagem como String (URL)
  String nomeUrl;
  String combo;
  int vendas;

  Produtos({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.descricaoLonga,
    required this.valor,
    required this.categoria,
    required this.imagem,
    required this.nomeUrl,
    required this.combo,
    required this.vendas,
  });

  factory Produtos.fromMap(Map<String, dynamic> map) {
    return Produtos(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      descricaoLonga: map['descricaoLonga'] ?? '',
      valor: map['valor'] ?? 0,
      categoria: map['categoria'] ?? 0,
      imagem: map['imagem'] ?? '',
      nomeUrl: map['nomeUrl'] ?? '',
      combo: map['combo'] ?? '',
      vendas: map['vendas'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'descricaoLonga': descricaoLonga,
      'valor': valor,
      'categoria': categoria,
      'imagem': imagem,
      'nomeUrl': nomeUrl,
      'combo': combo,
      'vendas': vendas,
    };
  }
}

// Model Class for DatumProdutos
class DatumProdutos {
  final List<Produtos> data;

  DatumProdutos({required this.data});

  factory DatumProdutos.fromJson(Map<String, dynamic> json) {
    return DatumProdutos(
      data: List<Produtos>.from(json["data"].map((x) => Produtos.fromMap(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
  }
}
