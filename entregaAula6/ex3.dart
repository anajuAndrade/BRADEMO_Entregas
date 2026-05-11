import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(this.userId, this.id, this.title, this.body);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(json['userId'], json['id'], json['title'], json['body']);
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title, 'body': body};
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String resultado = '';
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    getListaPosts();
  }

  // Get por Id
  Future<void> getPostPorId(int id) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        resultado =
            '''
GET POR ID:

Título: ${data['title']}

Conteúdo:
${data['body']}
''';
      });
    }
  }

  // Get lista
  Future<void> getListaPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);

      setState(() {
        posts = jsonResponse.map((post) => Post.fromJson(post)).toList();

        resultado = 'Lista carregada com sucesso!';
      });
    }
  }

  // Post
  Future<void> criarPost() async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': 'Novo Post',
        'body': 'Conteudo do post',
        'userId': 1,
      }),
    );

    setState(() {
      resultado = 'POST:\n${response.body}';
    });
  }

  // Put
  Future<void> atualizarPost() async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': 1,
        'title': 'Post Atualizado',
        'body': 'Conteudo do post atualizado',
        'userId': 1,
      }),
    );

    setState(() {
      resultado = 'PUT:\n${response.body}';
    });
  }

  // Delete
  Future<void> deletarPost() async {
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );

    setState(() {
      resultado = 'DELETE:\nStatus ${response.statusCode}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Requisições HTTP',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => getPostPorId(1),
                  child: const Text('GET por Id'),
                ),
                ElevatedButton(
                  onPressed: getListaPosts,
                  child: const Text('GET LISTA'),
                ),
                ElevatedButton(onPressed: criarPost, child: const Text('POST')),
                ElevatedButton(
                  onPressed: atualizarPost,
                  child: const Text('PUT'),
                ),
                ElevatedButton(
                  onPressed: deletarPost,
                  child: const Text('DELETE'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(resultado, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            const Text(
              'Lista de Posts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(posts[index].title),
                      subtitle: Text(posts[index].body),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
