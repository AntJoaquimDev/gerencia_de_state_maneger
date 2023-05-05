import 'package:flutter/material.dart';
import 'package:gerencia_de_state_maneger/bloc_pattern/imc_bloc_pattern_page.dart';
import 'package:gerencia_de_state_maneger/change_notifier/change_notifier_page.dart';
import 'package:gerencia_de_state_maneger/value_notfiers/value_notifier_page.dart';
import 'package:gerencia_de_state_maneger/setState/imc_setstate_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _goToPage(context, const ImcSetstatePage()),
              child: const Text('setState'),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, const ValueNotifierPage()),
              child: const Text('ValueNotifier'),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, const ChangeNotifierPage()),
              child: const Text('ChangeNotifier'),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, const ImcBlocPatternPage()),
              child: const Text('Bloc_Pattern'),
            ),
          ],
        ),
      ),
    );
  }
}
