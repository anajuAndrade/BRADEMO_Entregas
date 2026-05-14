import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  await Hive.initFlutter();
  await Hive.openBox("configBox");

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  bool modoRelax = true;

  @override
  void initState() {
    super.initState();
    carregarEstado();
  }

  Future<void> carregarEstado() async {
    final box = await Hive.openBox("configBox");


    bool? valorSalvo = box.get("modo");
    if (valorSalvo != null) {
      setState(() {
        modoRelax = valorSalvo;
      });
    }
  }

  Future<void> alternarModo() async {
    final box = await Hive.openBox("configBox");
    setState(() {
      modoRelax = !modoRelax;
    });
    box.put("modo", modoRelax);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor:
            modoRelax ? Colors.blue : Colors.green,
        body: Center(
          child: ElevatedButton(
            onPressed: alternarModo,

            child: Text(
              modoRelax
                  ? "Modo Relax"
                  : "Modo Focado",
            ),
          ),
        ),
      ),
    );
  }
}