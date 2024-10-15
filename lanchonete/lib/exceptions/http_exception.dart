class HttpException implements Exception {
  static const Map<String, String> errors = {
    "ER_TRUNCATED_WRONG_VALUE_FOR_FIELD": "Valor inválido",
  };

  final String code;

  HttpException(this.code);

  @override
  String toString() {
    return errors[code] ?? "Ocorreu um erro no processo de cadastro de categoria: $code";
  }
}
