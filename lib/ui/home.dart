import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_user_jukebox/ui/list_client.dart';
import 'package:my_user_jukebox/widget/custom_textfield.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _edtControllerEmail = TextEditingController();
  final TextEditingController _edtControllerSenha = TextEditingController();

  // botao login
  _onClickLogin(BuildContext context) {
    if (_edtControllerEmail.text.isEmpty || _edtControllerSenha.text.isEmpty) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.deepPurpleAccent[200],
          padding: EdgeInsets.only(left: 60, right: 60, top: 220, bottom: 300),
          child: Container(
            // alterar para only
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 60),
            color: Colors.white.withOpacity(0.15),
            child: Column(
              children: [
                CustomTextfield(
                  hint: 'E-mail cliente',
                  titulo: 'E-mail',
                  type: TextInputType.emailAddress,
                  textEditingController: _edtControllerEmail,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
          // child: Icon(Icons.supervised_user_circle),
          icon: Icon(Icons.accessibility_new_sharp),
          label: Text('Efetuar Login'),
          backgroundColor: Colors.amber[600],
          onPressed: () {
            _onClickLogin(context);
            print('botão apertado');
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => ListClient()));
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.person_add)),
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
