
class Category {

  int id;
  String nome; 
  String descricao;
  String imagem;
  String nomeUrl;
  int produtos;

  Category({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.imagem,
    required this.nomeUrl,
    required this.produtos,
  });

  // toMap(): Método que converte os atributos da classe em um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'imagem': imagem,
      'nomeUrl': nomeUrl,
      'produtos': produtos,
    };
  }

  // fromMap(): Método que converte um Map<String, dynamic> em um objeto da classe
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      imagem: map['imagem'] ?? '',
      nomeUrl: map['nomeUrl'] ?? '',
      produtos: map['produtos'] ?? 0,
    );
  }
}