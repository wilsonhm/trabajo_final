import 'package:servicio_asistencia/bloc/periodo/periodo_bloc.dart';
import 'package:servicio_asistencia/comp/DropDownFormField.dart';
import 'package:servicio_asistencia/models/periodo/PeriodoModelo.dart';
import 'package:servicio_asistencia/theme/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PeriodoForm extends StatefulWidget {
  @override
  _PeriodoFormState createState() => _PeriodoFormState();
}

class _PeriodoFormState extends State<PeriodoForm> {
  late int _id = 0;
  late String _nombre = "";
  late String _estado = "D";

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

  void capturaNombre(valor) {
    this._nombre = valor;
  }

  void capturaEstado(valor) {
    this._estado = valor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Período"),
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
                _buildDatoCadena(capturaNombre, "Nombre:"),
                _buildDatoLista(capturaEstado, _estado, "Estado:", lista),
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
                            PeriodoModelo mp = PeriodoModelo(
                              id: _id,
                              nombre: _nombre,
                              estado: _estado,
                            );
                            final prefs =
                                await SharedPreferences.getInstance();
                            BlocProvider.of<PeriodoBloc>(context)
                                .add(CreatePeriodoEvent(mp));
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
