Future<String> fetchPedido() {
  return Future.delayed(
    Duration(seconds: 2),
    () => 'Large Latte',
  );
}

Future<String> createPedido() async {
  var pedido = await fetchPedido();
  return 'Seu pedido é: $pedido';
}

Future<void> main() async {
  print('Buscando pedido do usuário');
  
  try {
    String mensagem = await createPedido();
    print(mensagem);
  } catch (e) {
    print('Erro: $e');
  }
}