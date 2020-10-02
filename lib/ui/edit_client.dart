import 'package:flutter/material.dart';
import 'package:my_user_jukebox/widget/custom_textfield.dart';

class EditCliente extends StatefulWidget {
  @override
  _EditClienteState createState() => _EditClienteState();
}

class _EditClienteState extends State<EditCliente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[600],
          title: Text('My User App - Gestão Usuários'),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 35, right: 35, top: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextfield(
                hint: 'Digite o nome',
                titulo: 'Nome',
                // textEditingController: ,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                hint: 'E-mail cliente',
                titulo: 'E-mail',
                // textEditingController: ,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                hint: 'Digite a data de nascimento',
                titulo: 'Nascimento',
                // textEditingController: ,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                hint: 'Digite uma senha',
                titulo: 'Senha',
                // textEditingController: ,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 170,
                    child: RaisedButton(
                        child: Text('Salvar'),
                        onPressed: () {
                          print('salvar');
                        }),
                  ),
                  Container(
                    width: 170,
                    child: RaisedButton(
                        child: Text('Limpar'),
                        onPressed: () {
                          print('salvar');
                        }),
                  )
                ],
              )
            ],
          ),
        ),
        //
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
