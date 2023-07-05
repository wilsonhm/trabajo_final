import 'package:servicio_asistencia/bloc/persona/persona_bloc.dart';
import 'package:servicio_asistencia/comp/DropDownFormField.dart';
import 'package:servicio_asistencia/models/persona/PersonaModelo.dart';
import 'package:servicio_asistencia/theme/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PersonaForm extends StatefulWidget {
  @override
  _PersonaFormState createState() => _PersonaFormState();
}

class _PersonaFormState extends State<PersonaForm> {
  late int _id = 0;
  late int _dni = 0;
  late String _codigo = "";
  late String _nombre = "";
  late String _apellidoPaterno = "";
  late String _apellidoMaterno = "";
  late String _telefono = "";
  late String _genero = "";
  late String _correo = "";
  late String _estado = "D";
  late int _escuelaId = 0;

  var _data = [];
  List<Map<String, String>> lista = [
    {'value': 'A', 'display': 'Activo'},
    {'value': 'D', 'display': 'Desactivo'}
  ];

  @override
  void initState() {
    super.initState();
    print("ver: ${lista.map((item) => item['value']).toList()}");
    print("verv: ${lista.map((item) => item['display']).toList()}");
  }

  final _formKey = GlobalKey<FormState>();

  void capturaDni(valor) {
    this._dni = valor;
  }

  void capturaCodigo(valor) {
    this._codigo = valor;
  }

  void capturaNombre(valor) {
    this._nombre = valor;
  }

  void capturaApellidoPaterno(valor) {
    this._apellidoPaterno = valor;
  }

  void capturaApellidoMaterno(valor) {
    this._apellidoMaterno = valor;
  }

  void capturaTelefono(valor) {
    this._telefono = valor;
  }

  void capturaGenero(valor) {
    this._genero = valor;
  }

  void capturaCorreo(valor) {
    this._correo = valor;
  }

  void capturaEstado(valor) {
    this._estado = valor;
  }

  void capturaEscuelaId(valor) {
    this._escuelaId = valor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Persona"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          color: AppTheme.nearlyWhite,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildDatoCadena(capturaDni, "DNI:"),
                _buildDatoCadena(capturaCodigo, "Código:"),
                _buildDatoCadena(capturaNombre, "Nombre:"),
                _buildDatoCadena(capturaApellidoPaterno, "Apellido Paterno:"),
                _buildDatoCadena(capturaApellidoMaterno, "Apellido Materno:"),
                _buildDatoCadena(capturaTelefono, "Teléfono:"),
                _buildDatoCadena(capturaGenero, "Género:"),
                _buildDatoCadena(capturaCorreo, "Correo:"),
                _buildDatoLista(capturaEstado, _estado, "Estado:", lista),
                _buildDatoEntero(capturaEscuelaId, "ID de Escuela:"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Procesando datos'),
                              ),
                            );
                            _formKey.currentState!.save();
                            PersonaModelo mp = PersonaModelo(
                              id: _id,
                              dni: _dni,
                              codigo: _codigo,
                              nombre: _nombre,
                              apellidoPaterno: _apellidoPaterno,
                              apellidoMaterno: _apellidoMaterno,
                              telefono: _telefono,
                              genero: _genero,
                              correo: _correo,
                              estado: _estado,
                              escuelaId: _escuelaId,
                            );
                            final prefs =
                                await SharedPreferences.getInstance();
                            BlocProvider.of<PersonaBloc>(context)
                                .add(CreatePersonaEvent(mp));
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'No se han proporcionado datos válidos.',
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatoEntero(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'ID es un campo requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(int.parse(value!));
      },
    );
  }

  Widget _buildDatoCadena(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }

  Widget _buildDatoLista(
      Function obtValor, _dato, String label, List<dynamic> listaDato) {
    return DropDownFormField(
      titleText: label,
      hintText: 'Seleccione',
      value: _dato,
      onSaved: (value) {
        setState(() {
          obtValor(value);
        });
      },
      onChanged: (value) {
        setState(() {
          obtValor(value);
        });
      },
      dataSource: listaDato,
      textField: 'display',
      valueField: 'value',
    );
  }
}
