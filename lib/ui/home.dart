import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_user_jukebox/controller/UsuariosAPI.dart';
import 'package:my_user_jukebox/ui/edit_client.dart';
import 'package:my_user_jukebox/ui/list_client.dart';
import 'package:my_user_jukebox/widget/custom_textfield.dart';
import 'package:email_validator/email_validator.dart';

import 'create_client.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //
  final _formKey = GlobalKey<FormState>();

  //
  UsuariosAPI usuariosAPI = UsuariosAPI();
  /*
  * Caso queira trocar a hash para efeuar os testes basta alterar aqui ou pode ser realizado pela UI normalmente
  *  */
  String _hashApi = 'd1774a0786474911a7db8072ebf8a229';
  final TextEditingController _edtControllerEmail = TextEditingController();
  final TextEditingController _edtControllerSenha = TextEditingController();
  final TextEditingController _edtControllerHash = TextEditingController();

  // botao login
  _onClickLogin(BuildContext context) async {
    if (_hashApi.isEmpty || _hashApi == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text(
                  'O hash da API está ausente ou expirado\n\nInsira o mesmo antes de continuar'),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.pop(context), child: Text('Ok'))
              ],
            );
          });
    } else if (_edtControllerEmail.text.isEmpty ||
        _edtControllerSenha.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text('Login ou Senha invalidos\n\nTente novamente'),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.pop(context), child: Text('Ok'))
              ],
            );
          });
    } else {
      //
      usuariosAPI.hashApi = _hashApi;
      if (usuariosAPI.login() != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ListClient(_hashApi)));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Erro de autenticação'),
                content: Text(
                    'Dados invalidos ou problemas de comunicação\n\nTente novamente mais tarde'),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Ok'))
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // pegando o tamanho da tela para nao ter erro com iphone menores
    final _screenWidh = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        title: Text(
          'My User',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, color: Colors.amber),
        ),
        centerTitle: true,
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
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            // color: Colors.deepPurpleAccent[200],
            padding: EdgeInsets.only(
                left: 60,
                right: 60,
                top: _screenWidh / 3,
                bottom: _screenWidh / 2.2),
            child: Container(
              // alterar para only
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              color: Colors.white.withOpacity(0.15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      hint: 'E-mail cliente',
                      titulo: 'E-mail',
                      type: TextInputType.emailAddress,
                      textEditingController: _edtControllerEmail,
                      validador: (value) => EmailValidator.validate(value)
                          ? null
                          : "Email invalido, por favor verifique!",
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomTextfield(
                      hint: 'Sua senha de acesso',
                      titulo: 'Senha',
                      oculto: true,
                      textEditingController: _edtControllerSenha,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
          // child: Icon(Icons.supervised_user_circle),
          icon: Icon(Icons.accessibility_new_sharp),
          label: Text('Efetuar Login'),
          backgroundColor: Colors.amber[600],
          onPressed: () {
            if (_formKey.currentState.validate()) {
              // _formKey.currentState.save();
              //print('Email passou!!!');
              _onClickLogin(context);
            }
          }
          //
          ),
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
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateCliente(
                                    _hashApi,
                                  ))),
                      icon: Icon(Icons.person_add)),
                  Text('Criar uma conta')
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.security)),
                  Text('Recuperar senha')
                ],
              )
            ]),
      )),
    );
  }
}
