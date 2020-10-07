import 'package:flutter/material.dart';
import 'package:my_user_jukebox/controller/UsuariosAPI.dart';
import 'package:my_user_jukebox/model/Usuario.dart';
import 'package:my_user_jukebox/ui/edit_client.dart';
import 'create_client.dart';
import 'home.dart';

class ListClient extends StatefulWidget {
  @override
  _ListClientState createState() => _ListClientState();

  String hashLogin;

  ListClient(this.hashLogin);
}

class _ListClientState extends State<ListClient> {
  UsuariosAPI usuariosAPI = UsuariosAPI();
  String _hashApi = '';
  final TextEditingController _edtControllerHash = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Ajustar esse if para fazer uma validacao melhor usar shared pref!!!
    if (widget.hashLogin.isEmpty) {
      //
      Navigator.pop(context);
    } else {
      _hashApi = widget.hashLogin;
    }

    _atualizarCliente(datanasc, email, nome, senha, id) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditCliente(
                  hashLogin: _hashApi,
                  datanasCli: datanasc,
                  emailCli: email,
                  nomeCli: nome,
                  senhaCli: senha,
                  idCli: id,
                  criarCli: false)));
    }

    _deleteCliente(id) {
      setState(() {
        usuariosAPI.delete(_hashApi, id);
      });
    }

    _carregarCliente() {
      setState(() {
        usuariosAPI.recuperarPostagens(_hashApi);
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[600],
          title: Text('My User App - Clientes',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          actions: [
            IconButton(
                icon: Icon(Icons.add_business),
                padding: EdgeInsets.only(right: 15),
                iconSize: 32,
                color: Colors.white,
                tooltip: 'Cadastrar novo Hash',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Cadastrar novo Hash',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          titlePadding: EdgeInsets.only(top: 18, left: 23),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  'Alterar a hash fará com que todos os dados sejam perdidos!'),
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: _edtControllerHash,
                                decoration: InputDecoration(
                                    hintText: 'Digite a nova key:',
                                    border: OutlineInputBorder()),
                              ),
                            ],
                          ),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                _hashApi = _edtControllerHash.text;
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Salvar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            FlatButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Cancelar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                }
                //
                )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: FutureBuilder<List<Usuario>>(
                future: usuariosAPI.recuperarPostagens(_hashApi),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        print("Erro na API");
                      } else {
                        //
                        return ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            //
                            List<Usuario> lista = snapshot.data;
                            Usuario user = lista[index];
                            //
                            return ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                              title: Text(
                                'Nome do cliente: ' + user.nome.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              subtitle: Text('Email: ' +
                                  user.email.toString() +
                                  '\nData de Nascimento: ' +
                                  user.datanasc.toString()),
                              onTap: () => _atualizarCliente(user.datanasc,
                                  user.email, user.nome, user.senha, user.sId),
                              onLongPress: () {
                                //
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Deletar Cliente?'),
                                        content: Text(
                                            'Tem certeza que deseja deletar o cliente?'),
                                        actions: [
                                          FlatButton(
                                              onPressed: () {
                                                _deleteCliente(user.sId);
                                                Navigator.pop(context);
                                              },
                                              child: Text('Sim')),
                                          FlatButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Não'))
                                        ],
                                      );
                                    });
                              },
                            );
                          },
                        );
                      }
                  }
                  return Container();
                },
              )
                  //
                  //
                  )
            ],
          ),
        ),
        //
        // nagegacao inferior
        //
        bottomNavigationBar: BottomAppBar(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              _carregarCliente;
                            },
                            icon: Icon(Icons.list_alt_outlined)),
                        Text('Listar Todos')
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              //
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateCliente(
                                            _hashApi,
                                          )));
                            },
                            icon: Icon(Icons.group_add_rounded)),
                        Text('Criar Usuário')
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                  (Route<dynamic> route) => false);
                            },
                            icon: Icon(Icons.exit_to_app_rounded)),
                        Text('Sair do App')
                      ],
                    )
                  ])),
        ));
  }
}
