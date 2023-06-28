import 'package:asistencia_app/apis/actividad_api.dart';
import 'package:asistencia_app/comp/DropDownFormField.dart';
import 'package:asistencia_app/drawer/navigation_home_screen.dart';
import 'package:asistencia_app/modelo/ActividadModelo.dart';
import 'package:asistencia_app/theme/AppTheme.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActividadForm extends StatefulWidget {
  @override
  _ActividadFormState createState() => _ActividadFormState();
}

class _ActividadFormState extends State<ActividadForm> {
  late int _periodoId = 0;
  late String _nombreActividad = "";
  TextEditingController _fecha = new TextEditingController();
  DateTime? selectedDate;
  TextEditingController _horai = new TextEditingController();
  TextEditingController _minToler = new TextEditingController();
  TimeOfDay? selectedTime;
  late String _estado = "D";
  Position? currentPosition;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  late String _evaluar = "NO";
  late String _userCreate;
  var _data = [];
  List<Map<String, String>> lista = [
    {'value': 'A', 'display': 'Activo'},
    {'value': 'D', 'display': 'Desactivo'}
  ];
  List<Map<String, String>> listaEva = [
    {'value': 'SI', 'display': 'SI'},
    {'value': 'NO', 'display': 'NO'}
  ];

  @override
  void initState() {
    super.initState();
    print("ver: ${lista.map((item) => item['value']).toList()}");
    print("verv: ${lista.map((item) => item['display']).toList()}");
  }

  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );

  void capturaNombreAct(valor) {
    this._nombreActividad = valor;
  }

  void capturaPeriodo(valor) {
    this._periodoId = valor;
  }

  void capturaFecha(valor) {
    this._fecha.text = valor;
  }

  void capturaHorai(valor) {
    this._horai.text = valor;
  }

  void capturaMinToler(valor) {
    this._minToler.text = valor;
  }

  void capturaEstado(valor) {
    this._estado = valor;
  }

  void capturaEvaluar(valor) {
    this._evaluar = valor;
  }

  TextEditingController capMinToler() {
    return this._minToler;
  }

  TextEditingController capHorai() {
    return this._horai;
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Actividad"),
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
                    _buildDatoEntero(capturaPeriodo, "PeriodoID:"),
                    _buildDatoCadena(capturaNombreAct, "Nombre Actividad:"),
                    _buildDatoFecha(capturaFecha, "F.Evento"),
                    _buildDatoHora(capturaHorai, capHorai, "H.Inicio:"),
                    _buildDatoHora(
                        capturaMinToler, capMinToler, "M.Tolerancia:"),
                    _buildDatoLista(capturaEstado, _estado, "Estado:", lista),
                    _buildDatoLista(
                        capturaEvaluar, _evaluar, "Evaluar:", listaEva),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Cancelar')),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing Data'),
                                  ),
                                );
                                _formKey.currentState!.save();
                                ActividadModelo mp = new ActividadModelo.unlaunched();
                                mp.periodoId = _periodoId;
                                mp.nombreActividad = _nombreActividad;
                                mp.fecha = _fecha.value.text;
                                mp.horai = _horai.value.text;
                                mp.minToler = _minToler.value.text;
                                mp.latitud = currentPosition!.latitude.toString();
                                mp.longitud =currentPosition!.longitude.toString();
                                mp.estado = _estado;
                                mp.evaluar = _evaluar;
                                final prefs = await SharedPreferences.getInstance();
                                mp.userCreate ="${prefs.getString('usernameLogin')}";
                                mp.asistenciapas = [];
                                /* print("P:${_periodoId},NA:${_nombreActividad}, E:${_estado}, "
                                    "F:${_fecha.value.text}
                                    HI:${_horai.value.text} MT:${_minToler.value.text} "
                                    "La: ${currentPosition!.latitude},
                                    Lo:${currentPosition!.longitude} "
                                    "U:${prefs.getString('usernameLogin')} EV:${_evaluar}");*/
                                var api = await Provider.of<ActividadApi>(context,listen: false)
                                    .createActividad(TokenUtil.TOKEN, mp);
                                print("ver: ${api.toJson()['success']}");
                                if (api.toJson()['success'] == true) {
                                  Navigator.pop(context, () {
                                    setState(() {});
                                  });

                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'No estan bien los datos de los campos!'),
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
              ))),
    );
  }

  Widget _buildDatoEntero(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Id es campo Requerido';
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
          return 'Nombre Requerido!';
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

  Future<void> _selectDate(BuildContext context, Function obtValor) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        obtValor(selectedDate.toString());
      });
    }
  }

  Widget _buildDatoFecha(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: _fecha,
      keyboardType: TextInputType.datetime,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onTap: () {
        _selectDate(context, obtValor);
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }

  Future<void> _selectTime(BuildContext context, Function obtValor) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext? context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        obtValor("${selectedTime!.hour}:${selectedTime!.minute}");
//_horai.text="${selectedTime!.hour}:${selectedTime!.minute}";
      });
    }
  }

  Widget _buildDatoHora(Function obtValor, Function capControl, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: capControl(),
      keyboardType: TextInputType.datetime,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onTap: () {
        _selectTime(context, obtValor);
      },
      onSaved: (String? value) {
        obtValor(value!);
//_horai.text=value!;
      },
    );
  }

  Future<bool> permiso() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<void> getCurrentLocation() async {
    final hasPermission = await permiso();
    if (!hasPermission) {
      return;
    }
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentPosition = position;
//getCurrentLocationAddress();
      });
    }).catchError((e) {
      print(e);
    });
  }
}
