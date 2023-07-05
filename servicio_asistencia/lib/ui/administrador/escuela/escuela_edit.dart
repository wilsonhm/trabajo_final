import 'package:servicio_asistencia/apis/escuela/escuela_api.dart';
import 'package:servicio_asistencia/bloc/escuela/escuela_bloc.dart';
import 'package:servicio_asistencia/comp/DropDownFormField.dart';
import 'package:servicio_asistencia/models/escuela/EscuelaModelo.dart';
import 'package:servicio_asistencia/theme/AppTheme.dart';
import 'package:servicio_asistencia/util/TokenUtil.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EscuelaFormEdit extends StatefulWidget {
EscuelaModelo modelE;
  EscuelaFormEdit({required this.modelE}):super();
  @override
  _EscuelaFormEditState createState() => _EscuelaFormEditState(modelE: modelE);
}

class _EscuelaFormEditState extends State<EscuelaFormEdit> {
  EscuelaModelo modelE;
  _EscuelaFormEditState({required this.modelE}):super();
  late int _id = 0;
  late String _nombreeap = "";
  late String _estado = "D";
  late String _inicaleseap = "";
  late int _facultadId = 0;
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
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );

   void capturaNombreEap(valor) {
    this._nombreeap = valor;
  }

  void capturaEstado(valor) {
    this._estado = valor;
  }

  void capturaInicialesEap(valor) {
    this._inicaleseap = valor;
  }

  void capturaFacultadId(valor) {
    this._facultadId = valor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Escuela"),
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
                _buildDatoCadena(capturaNombreEap, "Nombre EAP:"),
                _buildDatoLista(capturaEstado, _estado, "Estado:", lista),
                _buildDatoCadena(capturaInicialesEap, "Iniciales EAP:"),
                _buildDatoEntero(capturaFacultadId, "ID de Facultad:"),
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
                                EscuelaModelo mp = new EscuelaModelo.unlaunched();
                                mp.id = _id;
                                mp.nombreeap = _nombreeap;
                                mp.estado = _estado;
                                mp.inicialesEap = _inicaleseap;
                                mp.facultadId = _facultadId;
                                final prefs = await SharedPreferences.getInstance();
                                BlocProvider.of<EscuelaBloc>(context).add(CreateEscuelaEvent(mp));
                                Navigator.pop(context,(){});
                               /* var api = await Provider.of<ActividadApi>(context,listen: false)
                                    .createActividad(TokenUtil.TOKEN, mp);
                                print("ver: ${api.toJson()['success']}");
                                if (api.toJson()['success'] == true) {
                                  Navigator.pop(context, () {
                                    setState(() {});
                                  });
                                }*/
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