import 'package:flutter/material.dart';
import 'teacher_chat.dart'; // Import the home screen file
import 'package:lottie/lottie.dart';

class Subject {
  final String name;
  final String animation;

  Subject({required this.name, required this.animation});
}

class SubjectSelection extends StatelessWidget {
  final String name;
  final List<Subject> subjects = [
    Subject(
        name: 'História',
        animation:
            "https://assets2.lottiefiles.com/packages/lf20_q4uh69ab.json"),
    Subject(
        name: 'Geografia',
        animation:
            "https://assets2.lottiefiles.com/packages/lf20_gwsharow.json"),
    Subject(
        name: 'Matemática',
        animation:
            "https://assets1.lottiefiles.com/packages/lf20_e27xvycf.json"),
    Subject(
        name: 'Filosofia',
        animation:
            "https://assets1.lottiefiles.com/packages/lf20_9NxFrGo71i.json"),
    Subject(
        name: 'Sociologia',
        animation:
            "https://assets4.lottiefiles.com/packages/lf20_dx5nwnnb.json"),
    Subject(
        name: 'Biologia',
        animation:
            "https://assets10.lottiefiles.com/packages/lf20_DkTFNo.json"),
    Subject(
        name: 'Literatura',
        animation:
            "https://assets2.lottiefiles.com/packages/lf20_bnxoocv2.json"),
    Subject(
        name: 'Línguas',
        animation: "https://assets3.lottiefiles.com/packages/lf20_HjK9Ol.json"),
    Subject(
        name: 'Programação',
        animation:
            "https://assets7.lottiefiles.com/packages/lf20_bzgbs6lx.json"),
    Subject(
        name: 'Química',
        animation:
            "https://assets10.lottiefiles.com/packages/lf20_aC7zKstsAk.json"),
  ];

  SubjectSelection({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text.rich(
          TextSpan(
            text: 'Bem vindo, ',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: name,
                style: const TextStyle(fontSize: 20, color: Colors.deepPurple),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        // separatorBuilder: (context, index) => ,
        itemBuilder: (context, index) {
          Subject sub = subjects[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.all(20),
            elevation: 5,
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(25, 25, 10, 25),
              leading: SizedBox(
                width: 100,

                // height: 360,
                child: sub.animation.isNotEmpty
                    ? Lottie.network(sub.animation)
                    : Container(),
              ),
              title: Text(
                sub.name,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  // color: Colors.deepPurple
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Teacher_chat(name: name, person: sub.name),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
