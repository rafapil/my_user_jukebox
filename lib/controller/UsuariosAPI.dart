import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_user_jukebox/model/Usuario.dart';

const URLBASE = 'https://crudcrud.com/api/';

class UsuariosAPI {
  //
  // ver uma forma de colocar uma protecao aqui!
  String hashApi;

  //
  Future<List<Usuario>> login() async {
    //
    http.Response response = await http.get(URLBASE + hashApi + "/users");
    //
    var dadosJson = json.decode(response.body);
    //
  }

  Future<List<Usuario>> recuperarPostagens(hash) async {
    //
    http.Response response = await http.get(URLBASE + hash + "/users");
    //
    var dadosJson = json.decode(response.body);
    //
    List<Usuario> postagens = List();

    print(dadosJson);

    for (var user in dadosJson) {
      Usuario p = Usuario(user["_id"], user["nome"], user["email"],
          user["datanasc"], user["senha"]);
      postagens.add(p);
      print(p);
    }
    return postagens;
  }

  post(hash, nome, email, datanasc, senha) async {
    var corpo = json.encode(
      {"nome": nome, "email": email, "datanasc": datanasc, "senha": senha},
    );

    http.Response response = await http.post(
      URLBASE + hash + "/users",
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: corpo,
    );
    //
    print("Resposta codigo: ${response.statusCode}");
    print("Resposta: ${response.body}");
  }

  put(hash, id, nome, email, datanasc, senha) async {
    var corpo = json.encode(
      {"nome": nome, "email": email, "datanasc": datanasc, "senha": senha},
    );
    // Observe que usando o Put para atualizar só muda ele mesmo
    http.Response response = await http.put(
      URLBASE + hash + "/users/" + id,
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: corpo,
    );

    print("Resposta codigo: ${response.statusCode}");
    print("Resposta: ${response.body}");
    print(URLBASE + hash + "/users/" + id);
  }

  delete(hash, id) async {
    http.Response response = await http.delete(
      URLBASE + hash + "/users/" + id,
      headers: {"Content-type": "application/json; charset=UTF-8"},
    );
    // Formas de recuperar no log
    print("Resposta codigo: ${response.statusCode}");
    print("Resposta: ${response.body}");
  }
}
