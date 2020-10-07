import 'package:flutter/material.dart';
import 'package:my_user_jukebox/controller/UsuariosAPI.dart';
import 'package:my_user_jukebox/widget/custom_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'create_client.dart';
import 'home.dart';
import 'list_client.dart';

class EditCliente extends StatefulWidget {
  @override
  _EditClienteState createState() => _EditClienteState();
  bool criarCli;
  String hashLogin;
  String nomeCli, emailCli, datanasCli, senhaCli, idCli;

  EditCliente(
      {this.hashLogin,
      this.criarCli,
      this.nomeCli,
      this.emailCli,
      this.datanasCli,
      this.senhaCli,
      this.idCli});
}

class _EditClienteState extends State<EditCliente> {
  //
  final _formKey = GlobalKey<FormState>();

  //
  UsuariosAPI usuariosAPI = UsuariosAPI();
  String _hashApi = '';
  final TextEditingController _edtControllerHash = TextEditingController();

  //
  final TextEditingController _edtControllerNome = TextEditingController();
  final TextEditingController _edtControllerEmail = TextEditingController();
  final TextEditingController _edtControllerNascimento =
      TextEditingController();
  final TextEditingController _edtControllerSenha = TextEditingController();

  _limparCampos() {
    _edtControllerNome.text = '';
    _edtControllerEmail.text = '';
    _edtControllerNascimento.text = '';
    _edtControllerSenha.text = '';
  }

  _atualizaCliente() {
    //
    usuariosAPI.put(
        _hashApi,
        widget.idCli,
        _edtControllerNome.text,
        _edtControllerEmail.text,
        _edtControllerNascimento.text
            .replaceAll('/', '-')
            .replaceAll(':', '-')
            .replaceAll(' ', '-')
            .replaceAll('_', '-'),
        md5.convert(utf8.encode(_edtControllerSenha.text)).toString());
  }

  btnBar() {
    if ((widget.criarCli == null || widget.criarCli == false)) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
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
                      // Navigator.pushAndRemoveUntil(context, CreateCliente(), (route) => false)
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
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
                          MaterialPageRoute(builder: (context) => Home()),
                          (Route<dynamic> route) => false);
                    },
                    icon: Icon(Icons.exit_to_app_rounded)),
                Text('Sair do App')
              ],
            )
          ]);
    } else {
      return Row();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hashLogin.isEmpty) {
      //
      Navigator.pop(context);
    } else {
      _hashApi = widget.hashLogin;
    }

    _edtControllerNome.text = widget.nomeCli;
    _edtControllerEmail.text = widget.emailCli;
    _edtControllerNascimento.text = widget.datanasCli;
    _edtControllerSenha.text = widget.senhaCli;
    String _idCliente;
    if (widget.idCli.isNotEmpty || widget.idCli != null) {
      _idCliente = widget.idCli.toString();
    } else {
      _idCliente = '';
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[600],
          title: Text('My User App - Gestão Usuários',
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
          padding: EdgeInsets.only(left: 35, right: 35, top: 80),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextfield(
                    hint: 'Digite o nome',
                    titulo: 'Nome',
                    textEditingController: _edtControllerNome,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    hint: 'E-mail cliente',
                    titulo: 'E-mail',
                    textEditingController: _edtControllerEmail,
                    validador: (value) => EmailValidator.validate(value)
                        ? null
                        : "Email invalido, por favor verifique!",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    // Fazer um validador para a senha
                    hint: 'Digite a data desta forma: 10-06-2006',
                    titulo: 'Nascimento',
                    textEditingController: _edtControllerNascimento,
                    type: TextInputType.datetime,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    hint: 'Digite uma senha',
                    titulo: 'Senha',
                    oculto: true,
                    textEditingController: _edtControllerSenha,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120,
                        child: RaisedButton(
                            child: Text('Atualizar'),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _atualizaCliente();
                                // Navigator.of(context).pop();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ListClient(_hashApi)));
                              }
                            }),
                      ),
                      Container(
                        width: 120,
                        child: RaisedButton(
                            child: Text('Limpar'),
                            onPressed: () {
                              _limparCampos();
                            }),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        //
        //
        bottomNavigationBar: BottomAppBar(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: btnBar()),
        ));
  }
}
