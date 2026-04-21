import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const AppForm());
}

class AppForm extends StatelessWidget {
  const AppForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TelaFormulario(),
    );
  }
}

class TelaFormulario extends StatefulWidget {
  const TelaFormulario({super.key});

  @override
  State<TelaFormulario> createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final formKey = GlobalKey<FormState>();

  final nomeCtrl = TextEditingController();
  final foneCtrl = TextEditingController();
  final dataCtrl = TextEditingController();

  void enviar() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Dados:\n${nomeCtrl.text}\n${foneCtrl.text}\n${dataCtrl.text}",
          ),
        ),
      );
    }
  }

  Widget campo(IconData icon, String label, TextEditingController ctrl,
      {TextInputType? tipo, List<TextInputFormatter>? format}) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: ctrl,
            keyboardType: tipo,
            inputFormatters: format,
            decoration: InputDecoration(labelText: label),
            validator: (v) => v == null || v.isEmpty ? "Campo obrigatório" : null,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              campo(Icons.person, "Nome completo", nomeCtrl),
              const SizedBox(height: 12),
              campo(Icons.phone, "Celular", foneCtrl,
                  tipo: TextInputType.phone),
              const SizedBox(height: 12),
              campo(Icons.date_range, "Nascimento", dataCtrl,
                  tipo: TextInputType.number,
                  format: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                    DataFormatter(),
                  ]),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: enviar,
                child: const Text("Confirmar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DataFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(oldValue, newValue) {
    String t = newValue.text;

    if (t.length > 8) return oldValue;

    String novo = '';

    for (int i = 0; i < t.length; i++) {
      if (i == 2 || i == 4) novo += '/';
      novo += t[i];
    }

    return TextEditingValue(
      text: novo,
      selection: TextSelection.collapsed(offset: novo.length),
    );
  }
}