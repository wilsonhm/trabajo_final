import 'package:floor/floor.dart';

@Entity(tableName: "facultad")
class FacultadModelo {
  @primaryKey
  late int id = 0;
  late String nombrefac;
  late String estado;
  late String inicales;

  FacultadModelo({
    required this.id,
    required this.nombrefac,
    required this.estado,
    required this.inicales,
  });

  FacultadModelo.unlaunched();

  FacultadModelo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombrefac = json['nombrefac'];
    estado = json['estado'];
    inicales = json['inicales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombrefac'] = this.nombrefac;
    data['estado'] = this.estado;
    data['inicales'] = this.inicales;
    return data;
  }
}

class RespFacultadModelo {
  late bool success;
  late List<FacultadModelo> data;
  late String message;

  RespFacultadModelo({required this.success, required this.data, required this.message});

  RespFacultadModelo.unlaunched();

  RespFacultadModelo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] as List).map((e) => FacultadModelo.fromJson(e as Map<String, dynamic>)).toList();
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

