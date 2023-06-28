import 'package:floor/floor.dart';

@Entity(tableName: "persona")
class PersonaModelo {
  late String dni;
  late String codigo;
  late String nombre;
  @ColumnInfo(name: "apellido_paterno")
  late String apellidoPaterno;
  @ColumnInfo(name: "apellido_materno")
  late String apellidoMaterno;
  late String telefono;
  late String genero;
  late String correo;
  late String estado;
  @ColumnInfo(name: "escuela_id")
  late int escuelaId;




  PersonaModelo(
      {  
    required this.dni,
    required this.codigo,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.telefono,
    required this.genero,
    required this.correo,
    required this.estado,
    required this.escuelaId,});
  PersonaModelo.unlaunched();

  PersonaModelo.fromJson(Map<String, dynamic> json) {
  dni = json['dni'];
  codigo = json['codigo'];
  nombre = json['nombre'];
  apellidoPaterno = json['apellido_paterno'];
  apellidoMaterno = json['apellido_materno'];
  telefono = json['telefono'];
  genero = json['genero'];
  correo = json['correo'];
  estado = json['estado'];
  escuelaId = json['escuela_id'];
  }

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
   data['dni'] = this.dni;
  data['codigo'] = this.codigo;
  data['nombre'] = this.nombre;
  data['apellido_paterno'] = this.apellidoPaterno;
  data['apellido_materno'] = this.apellidoMaterno;
  data['telefono'] = this.telefono;
  data['genero'] = this.genero;
  data['correo'] = this.correo;
  data['estado'] = this.estado;
  data['escuela_id'] = this.escuelaId;
  
  return data;
}
}
class RespPersonaModelo {
  late bool success;
  late List<PersonaModelo> data;
  late String message;

  RespPersonaModelo({required this.success, required this.data, required this.message});

  RespPersonaModelo.unlaunched();

  RespPersonaModelo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] as List).map((e) => PersonaModelo.fromJson(e as Map<String, dynamic>)).toList();
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
