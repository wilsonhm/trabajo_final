import 'package:floor/floor.dart';

@Entity(tableName: "asistencia")
class AsistenciaModelo {
  @primaryKey
  late int id = 0;
  late String fecha;
  late String hora;
  late double latituda;
  late double longituda;
  late String tipo;
  @ColumnInfo(name: "tipo_reg")
  late String tipoReg;
  @ColumnInfo(name: "id_matricula")
  late int idMatricula;
  @ColumnInfo(name: "id_evento")
  late int idEvento;
  @ColumnInfo(name: "id_persona")
  late int idPersona;
  late int calificacion;

  AsistenciaModelo({
    required this.id,
    required this.fecha,
    required this.hora,
    required this.latituda,
    required this.longituda,
    required this.tipo,
    required this.tipoReg,
    required this.idMatricula,
    required this.idEvento,
    required this.idPersona,
    required this.calificacion,
  });

  AsistenciaModelo.unlaunched();

  AsistenciaModelo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fecha = json['fecha'];
    hora = json['hora'];
    latituda = json['latituda'];
    longituda = json['longituda'];
    tipo = json['tipo'];
    tipoReg = json['tipo_reg'];
    idMatricula = json['id_matricula'];
    idEvento = json['id_evento'];
    idPersona = json['id_persona'];
    calificacion = json['calificacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fecha'] = this.fecha;
    data['hora'] = this.hora;
    data['latituda'] = this.latituda;
    data['longituda'] = this.longituda;
    data['tipo'] = this.tipo;
    data['tipo_reg'] = this.tipoReg;
    data['id_matricula'] = this.idMatricula;
    data['id_evento'] = this.idEvento;
    data['id_persona'] = this.idPersona;
    data['calificacion'] = this.calificacion;
    return data;
  }
}

class RespAsistenciaModelo {
  late bool success;
  late List<AsistenciaModelo> data;
  late String message;

  RespAsistenciaModelo({required this.success, required this.data, required this.message});

  RespAsistenciaModelo.unlaunched();

  RespAsistenciaModelo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] as List).map((e) => AsistenciaModelo.fromJson(e as Map<String, dynamic>)).toList();
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
