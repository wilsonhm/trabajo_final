import 'package:servicio_asistencia/apis/usuario_api.dart';
import 'package:servicio_asistencia/comp/Button.dart';
import 'package:servicio_asistencia/drawer/navigation_home_screen.dart';
import 'package:servicio_asistencia/login/sign_in.dart';
import 'package:servicio_asistencia/models/UsuarioModelo.dart';
import 'package:servicio_asistencia/util/TokenUtil.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<UsuarioApi>(
      create: (_) => UsuarioApi.create(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue),
        home: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  var token;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage("assets/imagen/logo_upeu.png"),
                  height: 200.0,
                ),
                SizedBox(height: 20),
                _buildForm(),
                SizedBox(height: 20),
                _signInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Usuario",
                labelText: "Usuario",
                helperText: "Coloque un correo",
                helperStyle: TextStyle(color: Colors.green),
                alignLabelWithHint: false,
                filled: true,
              ),
              controller: _controllerUser,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: passwordVisible,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Password",
                labelText: "Password",
                helperText: "La contraseña debe contener un carácter especial",
                helperStyle: TextStyle(color: Colors.green),
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(
                      () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
                alignLabelWithHint: false,
                filled: true,
              ),
              controller: _controllerPass,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 24,
            ),
            Button(
              label: 'Ingresar',
              onTap: () async {
                if (_formKey.currentState!.validate() && _controllerUser.text != "") {
                  final prefs = await SharedPreferences.getInstance();
                  final api = Provider.of<UsuarioApi>(context, listen: false);
                  final user = UsuarioModelo(
                    name: "",
                    email: _controllerUser.text,
                    password: _controllerPass.text,
                  );
                  bool ingreso = false;
                  api.login(user).then(
                    (value) {
                      token = value.tokenType + " " + value.accessToken;
                      prefs.setString("token", token);
                      TokenUtil.TOKEN = token;
                      ingreso = true;
                      if (ingreso == true) {
                        prefs.setString("usernameLogin", _controllerUser.text);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return NavigationHomeScreen();
                            },
                          ),
                        );
                      }
                    },
                  ).catchError(
                    (onError) {
                      print(onError.toString());
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlinedButton(
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        signInWithGoogle().then(
          (result) {
            if (result != null) {
              final api = Provider.of<UsuarioApi>(context, listen: false);
              final user = UsuarioModelo(
                name: "",
                email: "davidmp@upeu.edu.pe",
                password: "Da12345*",
              );
              api.login(user).then(
                (value) {
                  token = value.tokenType + " " + value.accessToken;
                  prefs.setString("token", token);
                    prefs.setString("usernameLogin", '${email==null?"":email}');
                  TokenUtil.TOKEN = token;
                },
              ).catchError(
                (onError) {
                  print(onError.toString());
                },
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return NavigationHomeScreen();
                  },
                ),
              );
            } else {
              print("Error!!");
            }
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/imagen/man-icon.png"), height: 35.0),
            SizedBox(width: 10),
            Text(
              'Ingresar Google',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
