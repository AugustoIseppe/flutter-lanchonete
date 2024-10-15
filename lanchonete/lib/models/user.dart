
class User {
  int id;
  String nome;
  String cpf;
  String telefone;
  String usuario;
  String senha;
  String nivel;
  String imagem;

  User({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.telefone,
    required this.usuario,
    required this.senha,
    required this.nivel,
    required this.imagem,

  });

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      telefone: json['telefone'],
      usuario: json['usuario'],
      senha: json['senha'],
      nivel: json['nivel'],
      imagem: json['imagem'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
      'usuario': usuario,
      'senha': senha,
      'nivel': nivel,
      'imagem': imagem,
    };
  }
}