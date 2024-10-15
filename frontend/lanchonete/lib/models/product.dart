class Produtos {
  int id;
  String nome;
  String descricao;
  String descricao_longa;
  String valor;
  int categoria;
  String imagem;
  String nomeUrl;
  String combo;
  int vendas;

  Produtos({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.descricao_longa,
    required this.valor,
    required this.categoria,
    required this.imagem,
    required this.nomeUrl,
    required this.combo,
    required this.vendas,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'descricao_longa': descricao_longa,
      'valor': valor,
      'categoria': categoria,
      'imagem': imagem,
      'nomeUrl': nomeUrl,
      'combo': combo,
      'vendas': vendas,
    };
  }

  factory Produtos.fromMap(Map<String, dynamic> map) {
    return Produtos(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      descricao_longa: map['descricao_longa'] ?? 'NADINHAA',
      valor: map['valor'] ?? 0,
      categoria: map['categoria'] ?? 0,
      imagem: map['imagem'] ?? '',
      nomeUrl: map['nomeUrl'] ?? '',
      combo: map['combo'] ?? '',
      vendas: map['vendas'] ?? 0,
    );
  }
}
