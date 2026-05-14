import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class Contador extends ChangeNotifier {

  int _valor = 0;
  int get valor => _valor;

  void incrementar() {
    _valor++;
    notifyListeners();
  }

  void decrementar() {
    _valor--;
    notifyListeners();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => Contador(),

      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Contador"),
      ),

      body: Center(
        child: Consumer<Contador>(
          builder: (context, contador, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${contador.valor}",
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    contador.incrementar();
                  },
                  child: const Text("Incrementar"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    contador.decrementar();
                  },
                  child: const Text("Decrementar"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}