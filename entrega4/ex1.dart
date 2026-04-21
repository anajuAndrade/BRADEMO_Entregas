import 'package:flutter/material.dart';

void main() {
  runApp(const AppGrid());
}

class AppGrid extends StatelessWidget {
  const AppGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TelaGrid(),
    );
  }
}

class TelaGrid extends StatelessWidget {
  const TelaGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final lista = [
      {
        "nome": "Lavanda",
        "img": "https://wp-cdn.etiquetaunica.com.br/blog/wp-content/uploads/2019/12/27161629/capa-lavanda.jpg"
      },
      {
        "nome": "Verde Água",
        "img": "https://www.avimortecidos.com.br/static/6370/sku/tricoline-tecido-tricoline-liso-verde-agua-100-algodao-d595--p-1563221389439.jpeg"
      },
      {
        "nome": "Azul bebe",
        "img": "https://http2.mlstatic.com/D_NQ_NP_974058-MLB45088162718_032021-O.webp"
      },
      {
        "nome": "Rosa bebê",
        "img": "https://cdn.awsli.com.br/2500x2500/2514/2514405/produto/218522363/rosa-bhrm9lkqal.png"
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Galeria de Flores")),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: lista.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, i) {
          final item = lista[i];

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(item["img"]!),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item["nome"]!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}