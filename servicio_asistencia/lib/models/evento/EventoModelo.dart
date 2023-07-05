import 'package:floor/floor.dart';

@Entity(tableName: "periodo")


class EventoModelo {
  @primaryKey
  late int id = 0;
  late String nom_evento;
  late String fecha;
  late String horai;
  late int min_toler;
  late double latitud;
  late double longitud;
  late String estado;
  late String evaluar;
  late String perfil_evento;
  @ColumnInfo(name: "periodo_id")
  late int periodoId;

  EventoModelo({
    required this.id,
    required this.nom_evento,
    required this.fecha,
    required this.horai,
    required this.min_toler,
    required this.latitud,
    required this.longitud,
    required this.estado,
    required this.evaluar,
    required this.perfil_evento,
    required this.periodoId,
  });

  EventoModelo.unlaunched();

  EventoModelo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom_evento = json['nom_evento'];
    fecha = json['fecha'];
    horai = json['horai'];
    min_toler = json['min_toler'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    estado = json['estado'];
    evaluar = json['evaluar'];
    perfil_evento = json['perfil_evento'];
    periodoId = json['periodo_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom_evento'] = this.nom_evento;
    data['fecha'] = this.fecha;
    data['horai'] = this.horai;
    data['min_toler'] = this.min_toler;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['estado'] = this.estado;
    data['evaluar'] = this.evaluar;
    data['perfil_evento'] = this.perfil_evento;
    data['periodo_id'] = this.periodoId;
    return data;
  }
}

class RespEventoModelo {
  late bool success;
  late List<EventoModelo> data;
  late String message;

  RespEventoModelo({required this.success, required this.data, required this.message});

  RespEventoModelo.unlaunched();

  RespEventoModelo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] as List).map((e) => EventoModelo.fromJson(e as Map<String, dynamic>)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data.map((e) => e.toJson()).toList();
    data['message'] = this.message;
    return data;
  }
}
