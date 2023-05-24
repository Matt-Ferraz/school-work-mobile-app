import 'package:flutter/material.dart';
import 'choose_subject.dart';

//export ANDROID_HOME=/Users/mateusferraz/Library/Android/sdk/ndk/25.2.9519653
class HomeScreen extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();

  HomeScreen({super.key});

  void printName(BuildContext context) {
    String name = _textFieldController.text;
    if (name.isNotEmpty) {
      print(name);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubjectSelection(name: name),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('OOPS!'),
          content: const Text('Nome obrigatório!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            //   child: Lottie.network(
            //     "https://assets7.lottiefiles.com/packages/lf20_qrtp2d9r.json",
            //     width: 360,
            //     height: 360, // controller
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: const Text.rich(
                TextSpan(
                  text: 'Olá, seja bem vindo a ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: 'escola artificial',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                    TextSpan(
                      text: '! Como podemos te chamar?',
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _textFieldController,
                decoration: const InputDecoration(
                  labelText: 'Nome de usuário',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        // width: 400,
        margin: const EdgeInsets.fromLTRB(40, 0, 10, 0),
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(4.0),
          child: Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                printName(context);
              },
              child: const Text(
                'Continuar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
