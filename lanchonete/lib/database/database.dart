
import 'package:mysql1/mysql1.dart';

class Database {
  static final Database _instance = Database._internal();
  MySqlConnection? _connection;

  final String host = 'localhost';
  final String user = 'root';
  final String password = '';
  final int port = 3306;
  final String db = 'lanchonete';



  factory Database() {
    return _instance;
  }

  Database._internal();


  Future<MySqlConnection> openConnection() async {
    try {
      final settings = ConnectionSettings(
        host: host,
        port: port,
        user: user,
        password: password,
        db: db,
      );
      _connection = await MySqlConnection.connect(settings);
    } catch (e, s) {
      print('Erro ao conectar ao banco de dados: $e');
      print('Stack trace: $s');
    }
    return _connection != null ? _connection! : throw Exception('Erro ao conectar ao banco de dados');
  }


  Future<void> closeConnection() async {
    await _connection?.close();
    _connection = null;
  }

  MySqlConnection get connection {
    if (_connection == null) {
      throw Exception('Database connection is not open');
    }
    return _connection!;
  }
}