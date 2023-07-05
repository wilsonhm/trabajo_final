import 'package:floor/floor.dart';

@Entity(tableName: "asisteciapa")
class AsisteciapaModelo {
  @primaryKey
  late int id = 0;
  late String fecha;
  @ColumnInfo(name: "hora_reg")
  late String horaReg;
  late double latituda;
  late double longituda;
  late String tipo;
  late int calificacion;
  late String cui;
  @ColumnInfo(name: "tipo_cui")
  late String tipoCui;
  @ColumnInfo(name: "actividad_id")
  late int actividadId;

  AsisteciapaModelo({
    required this.id,
    required this.fecha,
    required this.horaReg,
    required this.latituda,
    required this.longituda,
    required this.tipo,
    required this.calificacion,
    required this.cui,
    required this.tipoCui,
    required this.actividadId,
  });

  AsisteciapaModelo.unlaunched();

  AsisteciapaModelo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fecha = json['fecha'];
    horaReg = json['hora_reg'];
    latituda = json['latituda'];
    longituda = json['longituda'];
    tipo = json['tipo'];
    calificacion = json['calificacion'];
    cui = json['cui'];
    tipoCui = json['tipo_cui'];
    actividadId = json['actividad_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fecha'] = this.fecha;
    data['hora_reg'] = this.horaReg;
    data['latituda'] = this.latituda;
    data['longituda'] = this.longituda;
    data['tipo'] = this.tipo;
    data['calificacion'] = this.calificacion;
    data['cui'] = this.cui;
    data['tipo_cui'] = this.tipoCui;
    data['actividad_id'] = this.actividadId;
    return data;
  }
}

class RespAsisteciapaModelo {
  late bool success;
  late List<AsisteciapaModelo> data;
  late String message;

  RespAsisteciapaModelo({
    required this.success,
    required this.data,
    required this.message,
  });

  RespAsisteciapaModelo.unlaunched();

  RespAsisteciapaModelo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] as List).map(
      (e) => AsisteciapaModelo.fromJson(e as Map<String, dynamic>)
    ).toList();
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
