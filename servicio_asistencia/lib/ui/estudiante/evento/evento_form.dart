/*import 'package:servicio_asistencia/bloc/evento/evento_bloc.dart';
import 'package:servicio_asistencia/comp/DropDownFormField.dart';
import 'package:servicio_asistencia/models/evento/EventoModelo.dart';
import 'package:servicio_asistencia/theme/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EventoForm extends StatefulWidget {
  @override
  _EventoFormState createState() => _EventoFormState();
}

class _EventoFormState extends State<EventoForm> {
  late int _id = 0;
  late String _nom_evento = "";
  late DateTime _fecha = DateTime.now();
  late String _horai = "";
  late int _min_toler = 0;
  late double _latitud = 0.0;
  late double _longitud = 0.0;
  late String _estado = "D";
  late bool _evaluar = false;
  late String _perfil_evento = "";
  late int _periodoId = 0;

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

  void capturaNombreEvento(valor) {
    this._nom_evento = valor;
  }

  void capturaFecha(valor) {
    this._fecha = valor;
  }

  void capturaHoraInicio(valor) {
    this._horai = valor;
  }

  void capturaMinutosTolerancia(valor) {
    this._min_toler = valor;
  }

  void capturaLatitud(valor) {
    this._latitud = valor;
  }

  void capturaLongitud(valor) {
    this._longitud = valor;
  }

  void capturaEstado(valor) {
    this._estado = valor;
  }

  void capturaEvaluar(valor) {
    this._evaluar = valor;
  }

  void capturaPerfilEvento(valor) {
    this._perfil_evento = valor;
  }

  void capturaPeriodoId(valor) {
    this._periodoId = valor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Evento"),
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
                _buildDatoCadena(capturaNombreEvento, "Nombre del evento:"),
                _buildDatoFecha(capturaFecha, _fecha, "Fecha:"),
                _buildDatoCadena(capturaHoraInicio, "Hora de inicio:"),
                _buildDatoEntero(
                    capturaMinutosTolerancia, "Minutos de tolerancia:"),
                _buildDatoDecimal(capturaLatitud, "Latitud:"),
                _buildDatoDecimal(capturaLongitud, "Longitud:"),
                _buildDatoLista(capturaEstado, _estado, "Estado:", lista),
                _buildDatoBooleano(capturaEvaluar, _evaluar, "Evaluar:"),
                _buildDatoCadena(capturaPerfilEvento, "Perfil del evento:"),
                _buildDatoEntero(capturaPeriodoId, "ID de período:"),
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
                            EventoModelo mp = EventoModelo(
                              id: _id,
                              nom_evento: _nom_evento,
                              fecha:  _fecha.value.text,
                              horai: _horai,
                              min_toler: _min_toler,
                              latitud: _latitud,
                              longitud: _longitud,
                              estado: _estado,
                              evaluar: _evaluar,
                              perfil_evento: _perfil_evento,
                              periodoId: _periodoId,
                            );
                            final prefs =
                                await SharedPreferences.getInstance();
                            BlocProvider.of<EventoBloc>(context)
                                .add(CreateEventoEvent(mp));
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

  Widget _buildDatoDecimal(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(double.parse(value!));
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

  Widget _buildDatoFecha(Function obtValor, DateTime valor, String label) {
    return ListTile(
      title: Text(label),
      subtitle: Text(valor.toString()),
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: valor,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        ).then((selectedDate) {
          if (selectedDate != null) {
            setState(() {
              obtValor(selectedDate);
            });
          }
        });
      },
    );
  }

  Widget _buildDatoLista(
      Function obtValor, String _dato, String label, List<dynamic> listaDato) {
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

  Widget _buildDatoBooleano(Function obtValor, bool valor, String label) {
    return CheckboxListTile(
      title: Text(label),
      value: valor,
      onChanged: (bool? value) {
        setState(() {
          obtValor(value);
        });
      },
    );
  }
}*/
