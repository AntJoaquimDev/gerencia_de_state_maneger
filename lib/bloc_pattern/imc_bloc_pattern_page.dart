import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_de_state_maneger/bloc_pattern/imc_bloc_pattern_Controller.dart';
import 'package:gerencia_de_state_maneger/bloc_pattern/imc_state.dart';
import 'package:gerencia_de_state_maneger/widgets_componet/imc_gauge.dart';
import 'package:gerencia_de_state_maneger/widgets_componet/imc_gauge_range.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcBlocPatternPage extends StatefulWidget {
  const ImcBlocPatternPage({Key? key}) : super(key: key);

  @override
  State<ImcBlocPatternPage> createState() => _ImcBlocPatternPageState();
}

class _ImcBlocPatternPageState extends State<ImcBlocPatternPage> {
  final controller = ImcBlocPatternController();
  final ECPeso = TextEditingController();
  final ECAltura = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var imc = 0.0;

  @override
  void dispose() {
    controller.dispose();
    ECPeso.dispose();
    ECAltura.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imc Bloc Pattern'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder<ImcState>(
                    stream: controller.imcOut,
                    builder: (context, snapshot) {
                      var imc = snapshot.data?.imc ?? 0;
                      return ImcGauge(imc: imc);
                    }),
                const SizedBox(height: 20),
                StreamBuilder<ImcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {
                    final dataValue = snapshot.data;

                    if (dataValue is ImcStateLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (dataValue is ImcStateError) {
                      return Text(dataValue.message);
                    }
                    return const SizedBox.shrink();

                    // return Visibility(
                    //     visible: snapshot.data is ImcStateLoading,
                    //     child: const Center(
                    //       child: CircularProgressIndicator(),
                    //     ));
                  },
                ),
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
                        controller.calcImc(peso: peso, altura: altura);
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
