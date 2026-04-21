import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveApp());
}

class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TelaResponsiva(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TelaResponsiva extends StatelessWidget {
  const TelaResponsiva({super.key});

  Widget buildBotao(String titulo) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildItem(String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white30)),
      ),
      child: Text(
        texto,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget cabecalho() {
    return const Column(
      children: [
        Text("Layout Adaptativo", style: TextStyle(color: Colors.white70)),
        SizedBox(height: 10),
        Text(
          "Curso Flutter",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, size) {
            bool telaGrande = size.maxWidth > 600;

            final esquerda = Column(
              children: [
                cabecalho(),
                buildBotao("Opção A"),
                buildBotao("Opção B"),
              ],
            );

            final direita = Column(
              children: [
                buildItem("Python"),
                buildItem("Java"),
                buildItem("C#"),
              ],
            );

            return Padding(
              padding: const EdgeInsets.all(16),
              child: telaGrande
                  ? Row(
                      children: [
                        Expanded(child: esquerda),
                        const SizedBox(width: 16),
                        Expanded(child: direita),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          esquerda,
                          const SizedBox(height: 20),
                          direita,
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}