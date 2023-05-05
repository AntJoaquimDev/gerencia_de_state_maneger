import 'dart:async';
import 'dart:math';

import 'package:gerencia_de_state_maneger/bloc_pattern/imc_state.dart';

class ImcBlocPatternController {
  final _imcStreamController = StreamController<ImcState>.broadcast()
    ..add(ImcState(imc: 0));
  Stream<ImcState> get imcOut => _imcStreamController.stream;

  Future<void> calcImc({required double peso, required double altura}) async {
    try {
      _imcStreamController.add(ImcStateLoading());
      await Future.delayed(const Duration(seconds: 1));
      final imc = peso / pow(altura, 2);
      // throw Exception(); para testa o message
      _imcStreamController.add(ImcState(imc: imc));
    } on Exception catch (e) {
      _imcStreamController.add(ImcStateError(message: 'Erro ao Calcular Imc.'));
    }
  }

  void dispose() {
    _imcStreamController.close();
  }
}
