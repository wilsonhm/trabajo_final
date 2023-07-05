import 'package:floor/floor.dart';

@Entity(tableName: "escuela")
class EscuelaModelo {
  @primaryKey
  late int id = 0;
  late String nombreeap;
  late String estado;
  @ColumnInfo(name: "inicaleseap")
  late String inicialesEap;
  @ColumnInfo(name: "facultad_id")
  late int facultadId;

  EscuelaModelo({
    required this.id,
    required this.nombreeap,
    required this.estado,
    required this.inicialesEap,
    required this.facultadId,
  });

  EscuelaModelo.unlaunched();

  EscuelaModelo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombreeap = json['nombreeap'];
    estado = json['estado'];
    inicialesEap = json['inicaleseap'];
    facultadId = json['facultad_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombreeap'] = this.nombreeap;
    data['estado'] = this.estado;
    data['inicaleseap'] = this.inicialesEap;
    data['facultad_id'] = this.facultadId;
    return data;
  }
}

class RespEscuelaModelo {
  late bool success;
  late List<EscuelaModelo> data;
  late String message;

  RespEscuelaModelo({required this.success, required this.data, required this.message});

  RespEscuelaModelo.unlaunched();

  RespEscuelaModelo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] as List).map((e) => EscuelaModelo.fromJson(e as Map<String, dynamic>)).toList();
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
