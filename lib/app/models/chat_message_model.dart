class ChatMessageModel {
  int? fornecedor;
  int? usuario;
  String mensagem;

  ChatMessageModel({
    this.fornecedor,
    this.usuario,
    required this.mensagem,
  });
}
