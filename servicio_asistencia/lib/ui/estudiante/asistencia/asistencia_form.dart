/*import 'package:servicio_asistencia/bloc/asistencia/asistencia_bloc.dart';
import 'package:servicio_asistencia/comp/DropDownFormField.dart';
import 'package:servicio_asistencia/models/asistencia/AsistenciaModelo.dart';
import 'package:servicio_asistencia/theme/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AsistenciaForm extends StatefulWidget {
  @override
  _AsistenciaFormState createState() => _AsistenciaFormState();
}

class _AsistenciaFormState extends State<AsistenciaForm> {
  late int _id = 0;
  late String _fecha;
  late String _hora;
  late String _latituda;
  late String _longituda;
  late String _tipo_reg;
  late int _matriculaId;
  late int _eventoId;
  late int _personaId;
  late String _calificacion;
  

  var _data = [];
  List<Map<String, String>> lista = [
    {'value': 'A', 'display': 'Activo'},
    {'value': 'D', 'display': 'Inactivo'}
  ];

  final _formKey = GlobalKey<FormState>();

  void capturaDni(String valor) {
    _hora =valor;
  }

  void capturaCodigo(String valor) {
    _fecha = valor;
  }

  void capturaNombre(String valor) {
    _latituda = valor;
  }

  void capturaApellidoPaterno(String valor) {
    _longituda = valor;
  }

  void capturaApellidoMaterno(String valor) {
    _tipo_reg = valor;
  }

  void capturaTelefono(String valor) {
    _telefono = valor;
  }

  void capturaGenero(String valor) {
    _genero = valor;
  }

  void capturaCorreo(String valor) {
    _correo = valor;
  }



  void capturaPersonaId(int valor) {
    _personaId = valor;
  }
    void capturaEstado(String valor) {
    _estado = valor;
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
                            AsistenciaModelo mp = AsistenciaModelo(
                              id: _id,
                              fecha: _dni,
                              hora: _codigo,
                              latituda: _nombre,
                              longituda: _apellidoPaterno,
                              tipo: _apellidoMaterno,
                              tipoReg: _telefono,
                              idMatricula: _genero,
                              idEvento: _correo,
                              idPersona: _estado,
                              calificacion: _escuelaId,
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
      Function obtValor, String dato, String label, List<dynamic> listaDato) {
    return DropDownFormField(
      titleText: label,
      hintText: 'Seleccione',
      value: dato,
      onSaved: (value) {
        obtValor(value);
      },
      onChanged: (value) {
        obtValor(value);
      },
      dataSource: listaDato,
      textField: 'display',
      valueField: 'value',
    );
  }
}*/
