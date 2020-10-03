import 'package:flutter/material.dart';
import 'package:my_user_jukebox/ui/edit_client.dart';

class ListClient extends StatefulWidget {
  @override
  _ListClientState createState() => _ListClientState();
}

class _ListClientState extends State<ListClient> {
  List _listaClientes = ['rafa', 'Valesca'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[600],
          title: Text('My User App - Clientes'),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: _listaClientes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_listaClientes[index]),
                        );
                      }))
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
                            onPressed: () {},
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
                                      builder: (context) => EditCliente()));
                            },
                            icon: Icon(Icons.group_add_rounded)),
                        Text('Criar Usuário')
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.exit_to_app_rounded)),
                        Text('Sair do App')
                      ],
                    )
                  ])),
        ));
  }
}
