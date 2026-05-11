Future<String> fetchPedido() {
  return Future.delayed(
    Duration(seconds: 2),
    () => throw Exception('Falha ao buscar pedido'),
  );
}

Future<void> printPedido() async {
  try {
    var pedido = await fetchPedido();
    print('Pedido recebido: $pedido');
  } catch (e) {
    print('Erro encontrado: $e');
  } finally {
    print('Operação finalizada.');
  }
}

Future<void> main() async {
  await printPedido();
}
