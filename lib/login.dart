import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:interdisciplinar/pagina_inicial.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var focusNomeUsuario = new FocusNode();
  var focusSenhaUsuario = new FocusNode();

  TextEditingController nomeUsuario = TextEditingController();
  TextEditingController senhaUsuario = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  /*final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 60, left: 40, right: 40),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.asset("images/logo_taruma.png"),
                ),
                TextFormField(
                  focusNode: focusNomeUsuario,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  validator: (valor) {
                    if (valor.isEmpty) {
                      FocusScope.of(context).requestFocus(focusNomeUsuario);
                      return "Informe o nome";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Usuário", icon: Icon(Icons.people)),
                  keyboardType: TextInputType.text,
                  controller: nomeUsuario,
                ),
                TextFormField(
                  focusNode: focusSenhaUsuario,
                  autofocus: true,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  validator: (valor) {
                    if (valor.isEmpty) {
                      FocusScope.of(context).requestFocus(focusSenhaUsuario);
                      return "Informe a senha";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Senha", icon: Icon(Icons.lock)),
                  keyboardType: TextInputType.text,
                  controller: senhaUsuario,
                ),
                RaisedButton(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        //fazer verificação no firebase
                        Firestore.instance
                            .collection("usuarios")
                            .where("login", isEqualTo: nomeUsuario.text)
                            .where("senha", isEqualTo: senhaUsuario.text)
                            .getDocuments()
                            .then((QuerySnapshot doc) {
                          if (doc.documents.length != 0) {
                            //achou o usuario

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaginaInicial()));
                          }
                        });
                      }
                    }),

                //botaoLogin()
              ],
            ),
          ),
        ));
  }

  /*Future<FirebaseUser> _signIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }

  GoogleSignInButton botaoLogin() {
    return GoogleSignInButton(
      onPressed: () => _signIn()
          .then((FirebaseUser user) => print(user))
          .catchError((e) => print(e)),
    );
  }*/
}
