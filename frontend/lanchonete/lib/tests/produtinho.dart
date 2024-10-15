
class Produtinho {
  int id;
  String nome;
  String descricao;
  String descricaoLonga;
  String valor;
  int categoria;
  String imagem;
  String nomeUrl;
  String combo;
  int vendas;

  Produtinho({
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

  Map<String, dynamic> toMap() {
    return {
      'id': id ,
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

  factory Produtinho.fromMap(Map<String, dynamic> map) {
    return Produtinho(
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
}
