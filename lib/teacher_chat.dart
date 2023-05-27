import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Message {
  String role;
  String content;

  Map<String, dynamic> toJson() {
    return {
      "role": role,
      "content": content,
    };
  }

  Message(this.role, this.content);
}

class Teacher_chat extends StatefulWidget {
  final String name;
  final String person;

  const Teacher_chat({Key? key, required this.name, required this.person})
      : super(key: key);

  @override
  _Teacher_chatState createState() => _Teacher_chatState();
}

class _Teacher_chatState extends State<Teacher_chat> {
  List<Message> chatContext = [];
  TextEditingController messageController = TextEditingController();
  List<Message> chatMessages = [];
  bool isTextFieldEnabled = true;

  @override
  void initState() {
    super.initState();

    // Initialize chatContext with system messag
    chatContext = [
      Message(
        "assistant",
        "Eu quero que você atue como um professor de ${widget.person}. Eu vou fornecer alguns tópicos relacionados ao estudo de ${widget.person}, e será seu trabalho explicar esses conceitos de maneira fácil de entender. Isso pode incluir fornecer exemplos, fazer perguntas ou decompor ideias complexas em partes menores que sejam mais fáceis de compreender. Atue de forma jovial, de acordo com comportamentos que te façam aproximar de alunos mais jovens, de 15 a 18 anos principalmente, com gírias e expressões.",
      ),
    ];
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    String prompt = messageController.text;

    if (prompt.isEmpty) {
      prompt = "Olá, se apresente por favor";
    }

    setState(() {
      chatContext.add(Message("user", prompt));
      chatMessages.addAll(chatContext);
      chatContext.clear();
    });

    setState(() {
      isTextFieldEnabled = false; // Disable the text field
    });

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final uri = Uri.parse('http://127.0.0.1:5000/teacher').replace(
      queryParameters: {
        "prompt": jsonEncode(
          chatMessages.map((message) => message.toJson()).toList(),
        ),
      },
    );

    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.contains("IMAGE")) {
        List<String> partes = responseData.split('IMAGE:');
        for (var parte in partes) {
          if (parte.isNotEmpty) print("parte: ${parte}\n\n");
        }
      }

      setState(() {
        chatContext.add(Message("system", responseData));
        chatMessages.addAll(chatContext);
        chatContext.clear();
      });
    } else {
      setState(() {
        chatContext.add(Message("system",
            "Estou tendo problemas para me conectar, verifique a conexão com a internet e tente novamente"));
        chatMessages.addAll(chatContext);
        chatContext.clear();
      });
      print("Request failed with status: ${response.statusCode}");
      // Handle error case
    }

    setState(() {
      isTextFieldEnabled = true; // Enable the text field again
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professor de ${widget.person}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                if (index == 0) return Container();
                final message = chatMessages[index];
                final title = message.role == "user"
                    ? widget.name
                    : "Professor de ${widget.person}";
                final titleColor = message.role == "user"
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: titleColor,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            message.content,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: TextField(
              controller: messageController,
              enabled: isTextFieldEnabled, // Enable/disable the text field
              decoration: InputDecoration(
                hintText: isTextFieldEnabled
                    ? 'Pergunte algo... sério, qualquer coisa'
                    : "Professor de ${widget.person} está pensando...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: isTextFieldEnabled
                      ? () {
                          fetchMessages();
                          messageController.clear();
                        }
                      : null, // Disable the button if the text field is disabled
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Teacher_chat(name: 'John', person: 'Alice'),
  ));
}
