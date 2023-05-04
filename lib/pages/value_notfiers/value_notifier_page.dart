import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets_componet/imc_gauge.dart';

class ValueNotifierPage extends StatefulWidget {
  const ValueNotifierPage({Key? key}) : super(key: key);

  @override
  State<ValueNotifierPage> createState() => _ValueNotifierPageState();
}

class _ValueNotifierPageState extends State<ValueNotifierPage> {
  final ECPeso = TextEditingController();
  final ECAltura = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var imc = ValueNotifier(0.0);

  Future<void> _calcImc({required double peso, required double altura}) async {
    imc.value = 0.0;

    await Future.delayed(const Duration(seconds: 1));

    imc.value = peso / pow(altura, 2);
  }

  @override
  void dispose() {
    ECPeso.dispose();
    ECAltura.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imc ValueNotifier'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: imc,
                  builder: (_, imcValue, __) => ImcGauge(imc: imcValue),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: ECPeso,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Seu Peso'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: 2,
                      turnOffGrouping: true,
                    )
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Peso obrigatório';
                    }
                  },
                ),
                TextFormField(
                  controller: ECAltura,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Sua Altura'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: 2,
                      turnOffGrouping: true,
                    ),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Altura obrigatório';
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      var formValid = formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        var formater = NumberFormat.simpleCurrency(
                            locale: 'pt_BR', decimalDigits: 2);
                        double peso = formater.parse(ECPeso.text) as double;
                        double altura = formater.parse(ECAltura.text) as double;
                        _calcImc(peso: peso, altura: altura);
                      }
                    },
                    child: const Text('Calcular IMC'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
