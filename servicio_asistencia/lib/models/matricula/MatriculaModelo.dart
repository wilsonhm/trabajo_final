import 'package:floor/floor.dart';

@Entity(tableName: "matricula")
class MatriculaModelo {
  @primaryKey
  late int id = 0;
  late String estado;
  late int periodoId;
  late int personaId;

  MatriculaModelo({
    required this.id,
    required this.estado,
    required this.periodoId,
    required this.personaId,
  });

  MatriculaModelo.unlaunched();

  MatriculaModelo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estado = json['estado'];
    periodoId = json['periodo_id'];
    personaId = json['persona_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['estado'] = this.estado;
    data['periodo_id'] = this.periodoId;
    data['persona_id'] = this.personaId;
    return data;
  }
}

class RespMatriculaModelo {
  late bool success;
  late List<MatriculaModelo> data;
  late String message;

  RespMatriculaModelo({
    required this.success,
    required this.data,
    required this.message,
  });

  RespMatriculaModelo.unlaunched();

  RespMatriculaModelo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] as List).map((e) => MatriculaModelo.fromJson(e as Map<String, dynamic>)).toList();
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
