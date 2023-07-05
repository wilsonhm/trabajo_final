import 'package:servicio_asistencia/bloc/matricula/matricula_bloc.dart';
import 'package:servicio_asistencia/comp/DropDownFormField.dart';
import 'package:servicio_asistencia/models/matricula/MatriculaModelo.dart';
import 'package:servicio_asistencia/theme/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MatriculaFormEdit extends StatefulWidget {
   MatriculaModelo modelM;
    MatriculaFormEdit({required this.modelM}):super();
  @override
  _MatriculaFormEditState createState() => _MatriculaFormEditState(modelM:modelM);
}

class _MatriculaFormEditState extends State<MatriculaFormEdit> {
    MatriculaModelo modelM;
  _MatriculaFormEditState({required this.modelM}):super();
  late int _id = 0;
  late String _estado = "D";
  late int _periodoId = 0;
  late int _personaId = 0;

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

  void capturaEstado(valor) {
    this._estado = valor;
  }

  void capturaPeriodoId(valor) {
    this._periodoId = valor;
  }

  void capturaPersonaId(valor) {
    this._personaId = valor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Matrícula"),
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
                _buildDatoLista(capturaEstado, _estado, "Estado:", lista),
                _buildDatoEntero(capturaPeriodoId, "ID de Período:"),
                _buildDatoEntero(capturaPersonaId, "ID de Persona:"),
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
                            MatriculaModelo mp = MatriculaModelo(
                              id: _id,
                              estado: _estado,
                              periodoId: _periodoId,
                              personaId: _personaId,
                            );
                            final prefs =
                                await SharedPreferences.getInstance();
                            BlocProvider.of<MatriculaBloc>(context)
                                .add(CreateMatriculaEvent(mp));
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
          return 'El ID es un campo requerido.';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(int.parse(value!));
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
