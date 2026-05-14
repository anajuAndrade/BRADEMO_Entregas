import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("tarefasBox");

  runApp(const MainApp());
}

class TarefaProvider extends ChangeNotifier {

  List<String> _tarefas = [];

  final Box box = Hive.box("tarefasBox");

  TarefaProvider() {
    carregarTarefas();
  }

  List<String> get tarefas => _tarefas;

  void carregarTarefas() {
    List<dynamic>? dados = box.get("lista");
    if (dados != null) {
      _tarefas = List<String>.from(dados);
    }
    notifyListeners();
  }

  void adicionarTarefa(String tarefa) {
    _tarefas.add(tarefa);
    box.put("lista", _tarefas);
    notifyListeners();
  }

  
  void removerTarefa(int index) {
    _tarefas.removeAt(index);
    box.put("lista", _tarefas);
    notifyListeners();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(

      create: (_) => TarefaProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  HomePage({super.key});

  final TextEditingController controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<TarefaProvider>(
          builder: (context, provider, _) {
            return Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: "Nova tarefa",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      provider.adicionarTarefa(
                        controller.text,
                      );
                      controller.clear();
                    }
                  },

                  child: const Text("Adicionar"),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.tarefas.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          provider.tarefas[index],
                        ),

                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            provider.removerTarefa(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}