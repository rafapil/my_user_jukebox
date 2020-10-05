import 'package:flutter/material.dart';
import 'package:my_user_jukebox/controller/UsuariosAPI.dart';
import 'package:my_user_jukebox/widget/custom_textfield.dart';

class CreateCliente extends StatefulWidget {
  @override
  _CreateClienteState createState() => _CreateClienteState();
  String hashLogin;

  CreateCliente(
    this.hashLogin,
  );
}

class _CreateClienteState extends State<CreateCliente> {
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

  _novoCliente() {
    //
    usuariosAPI.post(
        _hashApi,
        _edtControllerNome.text,
        _edtControllerEmail.text,
        _edtControllerNascimento.text,
        _edtControllerSenha.text);
  }

  btnBar() {
    if ((widget.hashLogin == null || widget.hashLogin == false)) {
      return Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // children: <Widget>[
          //   Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       IconButton(
          //           onPressed: () => Navigator.pop(context),
          //           icon: Icon(Icons.list_alt_outlined)),
          //       Text('Listar Todos')
          //     ],
          //   ),
          //   Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       IconButton(
          //           onPressed: () {
          //             //
          //             _limparCampos();
          //           },
          //           icon: Icon(Icons.group_add_rounded)),
          //       Text('Criar Usuário')
          //     ],
          //   ),
          //   Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       IconButton(
          //           onPressed: () {}, icon: Icon(Icons.exit_to_app_rounded)),
          //       Text('Sair do App')
          //     ],
          //   )
          // ]
          );
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
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  // Fazer um validador para a senha
                  hint: 'Digite a data desta forma: 10-06-2006',
                  titulo: 'Nascimento',
                  textEditingController: _edtControllerNascimento,
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
                      width: 170,
                      child: RaisedButton(
                          child: Text('Salvar Novo'),
                          onPressed: () {
                            _novoCliente();
                            _limparCampos();
                            // print('salvar');
                          }),
                    ),
                    Container(
                      width: 170,
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
        //
        //
        bottomNavigationBar: BottomAppBar(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: btnBar()),
        ));
  }
}
