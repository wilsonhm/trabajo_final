import 'package:floor/floor.dart';
@Entity(tableName: "periodo")
class PeriodoModelo {
  @primaryKey
  late int id=0;
  late String nombre;
  late String estado;

  PeriodoModelo({
    required this.id,
    required this.nombre,
    required this.estado,
  });

  PeriodoModelo.unlaunched();

  PeriodoModelo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['estado'] = this.estado;
    return data;
  }
}

class RespPeriodoModelo {
  late bool success;
  late List<PeriodoModelo> data;
  late String message;

  RespPeriodoModelo({required this.success, required this.data, required this.message});

  RespPeriodoModelo.unlaunched();

  RespPeriodoModelo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] as List).map((e) => PeriodoModelo.fromJson(e as Map<String, dynamic>)).toList();
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
