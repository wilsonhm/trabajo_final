import 'package:servicio_asistencia/bloc/evento/evento_bloc.dart';
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
  late String _nomEvento = "";
  late DateTime _fecha = DateTime.now();
  late TimeOfDay _horaI = TimeOfDay.now();
  late int _minToler = 0;
  late double _latitud = 0.0;
  late double _longitud = 0.0;
  late String _estado = "D";
  late bool _evaluar = false;
  late String _perfilEvento = "";
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
                _buildDatoCadena(capturaNomEvento, "Nombre del evento:"),
                _buildFechaSelector(capturaFecha, "Fecha:"),
                _buildHoraSelector(capturaHoraI, "Hora de inicio:"),
                _buildDatoNumerico(capturaMinToler, "Minutos de tolerancia:"),
                _buildDatoCadena(capturaLatitud, "Latitud:"),
                _buildDatoCadena(capturaLongitud, "Longitud:"),
                _buildDatoLista(capturaEstado, _estado, "Estado:", lista),
                _buildEvaluarSelector(capturaEvaluar, "Evaluar:"),
                _buildDatoCadena(capturaPerfilEvento, "Perfil del evento:"),
                _buildDatoNumerico(capturaPeriodoId, "ID del período:"),
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
                              nom_evento: _nomEvento,
                              fecha: _fecha,
                              horai: _horaI,
                              min_toler: _minToler,
                              latitud: _latitud,
                              longitud: _longitud,
                              estado: _estado,
                              evaluar: _evaluar,
                              perfil_evento: _perfilEvento,
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

  Widget _buildFechaSelector(Function obtValor, String label) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _fecha != null ? _fecha : DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null && picked != _fecha) {
          obtValor(picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              _fecha != null ? _fecha.toString() : 'Seleccionar fecha',
            ),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget _buildHoraSelector(Function obtValor, String label) {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: _horaI != null ? _horaI : TimeOfDay.now(),
        );
        if (picked != null && picked != _horaI) {
          obtValor(picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              _horaI != null ? _horaI.format(context) : 'Seleccionar hora',
            ),
            Icon(Icons.access_time),
          ],
        ),
      ),
    );
  }

  Widget _buildDatoNumerico(Function obtValor, String label) {
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

  Widget _buildEvaluarSelector(Function obtValor, String label) {
    return Row(
      children: <Widget>[
        Text(label),
        Checkbox(
          value: _evaluar,
          onChanged: (bool? value) {
            setState(() {
              obtValor(value);
            });
          },
        ),
      ],
    );
  }

  void capturaNomEvento(String valor) {
    this._nomEvento = valor;
  }

  void capturaFecha(DateTime valor) {
    this._fecha = valor;
  }

  void capturaHoraI(TimeOfDay valor) {
    this._horaI = valor;
  }

  void capturaMinToler(int valor) {
    this._minToler = valor;
  }

  void capturaLatitud(String valor) {
    this._latitud = double.parse(valor);
  }

  void capturaLongitud(String valor) {
    this._longitud = double.parse(valor);
  }

  void capturaEstado(String valor) {
    this._estado = valor;
  }

  void capturaEvaluar(bool? valor) {
    this._evaluar = valor ?? false;
  }

  void capturaPerfilEvento(String valor) {
    this._perfilEvento = valor;
  }

  void capturaPeriodoId(int valor) {
    this._periodoId = valor;
  }
}
