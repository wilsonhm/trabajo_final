// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ActividadDao? _actividadDaoInstance;

  AsisteciapaDao? _asisteciapaDaoInstance;

  AsistenciaDao? _asistenciaDaoInstance;

  EscuelaDao? _escuelaDaoInstance;

  EventoDao? _eventoDaoInstance;

  FacultadDao? _facultadDaoInstance;

  MatriculaDao? _matriculaDaoInstance;

  PeriodoDao? _periodoDaoInstance;

  PersonaDao? _personaDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `actividad` (`id` INTEGER NOT NULL, `periodo_id` INTEGER NOT NULL, `nombre_actividad` TEXT NOT NULL, `fecha` TEXT NOT NULL, `horai` TEXT NOT NULL, `min_toler` TEXT NOT NULL, `latitud` TEXT NOT NULL, `longitud` TEXT NOT NULL, `estado` TEXT NOT NULL, `evaluar` TEXT NOT NULL, `user_create` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `asisteciapa` (`id` INTEGER NOT NULL, `fecha` TEXT NOT NULL, `hora_reg` TEXT NOT NULL, `latituda` REAL NOT NULL, `longituda` REAL NOT NULL, `tipo` TEXT NOT NULL, `calificacion` INTEGER NOT NULL, `cui` TEXT NOT NULL, `tipo_cui` TEXT NOT NULL, `actividad_id` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `asistencia` (`id` INTEGER NOT NULL, `fecha` TEXT NOT NULL, `hora` TEXT NOT NULL, `latituda` REAL NOT NULL, `longituda` REAL NOT NULL, `tipo` TEXT NOT NULL, `tipo_reg` TEXT NOT NULL, `id_matricula` INTEGER NOT NULL, `id_evento` INTEGER NOT NULL, `id_persona` INTEGER NOT NULL, `calificacion` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `escuela` (`id` INTEGER NOT NULL, `nombreeap` TEXT NOT NULL, `estado` TEXT NOT NULL, `inicaleseap` TEXT NOT NULL, `facultad_id` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `periodo` (`id` INTEGER NOT NULL, `nom_evento` TEXT NOT NULL, `fecha` TEXT NOT NULL, `horai` TEXT NOT NULL, `min_toler` INTEGER NOT NULL, `latitud` REAL NOT NULL, `longitud` REAL NOT NULL, `estado` TEXT NOT NULL, `evaluar` TEXT NOT NULL, `perfil_evento` TEXT NOT NULL, `periodo_id` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `facultad` (`id` INTEGER NOT NULL, `nombrefac` TEXT NOT NULL, `estado` TEXT NOT NULL, `inicales` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `matricula` (`id` INTEGER NOT NULL, `estado` TEXT NOT NULL, `periodoId` INTEGER NOT NULL, `personaId` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `periodo` (`id` INTEGER NOT NULL, `nombre` TEXT NOT NULL, `estado` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `persona` (`id` INTEGER NOT NULL, `dni` INTEGER NOT NULL, `codigo` TEXT NOT NULL, `nombre` TEXT NOT NULL, `apellido_paterno` TEXT NOT NULL, `apellido_materno` TEXT NOT NULL, `telefono` TEXT NOT NULL, `genero` TEXT NOT NULL, `correo` TEXT NOT NULL, `estado` TEXT NOT NULL, `escuela_id` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ActividadDao get actividadDao {
    return _actividadDaoInstance ??= _$ActividadDao(database, changeListener);
  }

  @override
  AsisteciapaDao get asisteciapaDao {
    return _asisteciapaDaoInstance ??=
        _$AsisteciapaDao(database, changeListener);
  }

  @override
  AsistenciaDao get asistenciaDao {
    return _asistenciaDaoInstance ??= _$AsistenciaDao(database, changeListener);
  }

  @override
  EscuelaDao get escuelaDao {
    return _escuelaDaoInstance ??= _$EscuelaDao(database, changeListener);
  }

  @override
  EventoDao get eventoDao {
    return _eventoDaoInstance ??= _$EventoDao(database, changeListener);
  }

  @override
  FacultadDao get facultadDao {
    return _facultadDaoInstance ??= _$FacultadDao(database, changeListener);
  }

  @override
  MatriculaDao get matriculaDao {
    return _matriculaDaoInstance ??= _$MatriculaDao(database, changeListener);
  }

  @override
  PeriodoDao get periodoDao {
    return _periodoDaoInstance ??= _$PeriodoDao(database, changeListener);
  }

  @override
  PersonaDao get personaDao {
    return _personaDaoInstance ??= _$PersonaDao(database, changeListener);
  }
}

class _$ActividadDao extends ActividadDao {
  _$ActividadDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _actividadModeloInsertionAdapter = InsertionAdapter(
            database,
            'actividad',
            (ActividadModelo item) => <String, Object?>{
                  'id': item.id,
                  'periodo_id': item.periodoId,
                  'nombre_actividad': item.nombreActividad,
                  'fecha': item.fecha,
                  'horai': item.horai,
                  'min_toler': item.minToler,
                  'latitud': item.latitud,
                  'longitud': item.longitud,
                  'estado': item.estado,
                  'evaluar': item.evaluar,
                  'user_create': item.userCreate
                },
            changeListener),
        _actividadModeloUpdateAdapter = UpdateAdapter(
            database,
            'actividad',
            ['id'],
            (ActividadModelo item) => <String, Object?>{
                  'id': item.id,
                  'periodo_id': item.periodoId,
                  'nombre_actividad': item.nombreActividad,
                  'fecha': item.fecha,
                  'horai': item.horai,
                  'min_toler': item.minToler,
                  'latitud': item.latitud,
                  'longitud': item.longitud,
                  'estado': item.estado,
                  'evaluar': item.evaluar,
                  'user_create': item.userCreate
                },
            changeListener),
        _actividadModeloDeletionAdapter = DeletionAdapter(
            database,
            'actividad',
            ['id'],
            (ActividadModelo item) => <String, Object?>{
                  'id': item.id,
                  'periodo_id': item.periodoId,
                  'nombre_actividad': item.nombreActividad,
                  'fecha': item.fecha,
                  'horai': item.horai,
                  'min_toler': item.minToler,
                  'latitud': item.latitud,
                  'longitud': item.longitud,
                  'estado': item.estado,
                  'evaluar': item.evaluar,
                  'user_create': item.userCreate
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ActividadModelo> _actividadModeloInsertionAdapter;

  final UpdateAdapter<ActividadModelo> _actividadModeloUpdateAdapter;

  final DeletionAdapter<ActividadModelo> _actividadModeloDeletionAdapter;

  @override
  Future<List<ActividadModelo>> listarActividad() async {
    return _queryAdapter.queryList('SELECT * FROM actividad',
        mapper: (Map<String, Object?> row) => ActividadModelo(
            id: row['id'] as int,
            periodoId: row['periodo_id'] as int,
            nombreActividad: row['nombre_actividad'] as String,
            fecha: row['fecha'] as String,
            horai: row['horai'] as String,
            minToler: row['min_toler'] as String,
            latitud: row['latitud'] as String,
            longitud: row['longitud'] as String,
            estado: row['estado'] as String,
            evaluar: row['evaluar'] as String,
            userCreate: row['user_create'] as String));
  }

  @override
  Stream<ActividadModelo?> buscarActividadId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM actividad where id=?1',
        mapper: (Map<String, Object?> row) => ActividadModelo(
            id: row['id'] as int,
            periodoId: row['periodo_id'] as int,
            nombreActividad: row['nombre_actividad'] as String,
            fecha: row['fecha'] as String,
            horai: row['horai'] as String,
            minToler: row['min_toler'] as String,
            latitud: row['latitud'] as String,
            longitud: row['longitud'] as String,
            estado: row['estado'] as String,
            evaluar: row['evaluar'] as String,
            userCreate: row['user_create'] as String),
        arguments: [id],
        queryableName: 'actividad',
        isView: false);
  }

  @override
  Future<void> insertarActividad(ActividadModelo actividad) async {
    await _actividadModeloInsertionAdapter.insert(
        actividad, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateActividad(ActividadModelo actividad) async {
    await _actividadModeloUpdateAdapter.update(
        actividad, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteActividad(ActividadModelo actividad) async {
    await _actividadModeloDeletionAdapter.delete(actividad);
  }
}

class _$AsisteciapaDao extends AsisteciapaDao {
  _$AsisteciapaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _asisteciapaModeloInsertionAdapter = InsertionAdapter(
            database,
            'asisteciapa',
            (AsisteciapaModelo item) => <String, Object?>{
                  'id': item.id,
                  'fecha': item.fecha,
                  'hora_reg': item.horaReg,
                  'latituda': item.latituda,
                  'longituda': item.longituda,
                  'tipo': item.tipo,
                  'calificacion': item.calificacion,
                  'cui': item.cui,
                  'tipo_cui': item.tipoCui,
                  'actividad_id': item.actividadId
                },
            changeListener),
        _asisteciapaModeloUpdateAdapter = UpdateAdapter(
            database,
            'asisteciapa',
            ['id'],
            (AsisteciapaModelo item) => <String, Object?>{
                  'id': item.id,
                  'fecha': item.fecha,
                  'hora_reg': item.horaReg,
                  'latituda': item.latituda,
                  'longituda': item.longituda,
                  'tipo': item.tipo,
                  'calificacion': item.calificacion,
                  'cui': item.cui,
                  'tipo_cui': item.tipoCui,
                  'actividad_id': item.actividadId
                },
            changeListener),
        _asisteciapaModeloDeletionAdapter = DeletionAdapter(
            database,
            'asisteciapa',
            ['id'],
            (AsisteciapaModelo item) => <String, Object?>{
                  'id': item.id,
                  'fecha': item.fecha,
                  'hora_reg': item.horaReg,
                  'latituda': item.latituda,
                  'longituda': item.longituda,
                  'tipo': item.tipo,
                  'calificacion': item.calificacion,
                  'cui': item.cui,
                  'tipo_cui': item.tipoCui,
                  'actividad_id': item.actividadId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AsisteciapaModelo> _asisteciapaModeloInsertionAdapter;

  final UpdateAdapter<AsisteciapaModelo> _asisteciapaModeloUpdateAdapter;

  final DeletionAdapter<AsisteciapaModelo> _asisteciapaModeloDeletionAdapter;

  @override
  Future<List<AsisteciapaModelo>> listarAsisteciapa() async {
    return _queryAdapter.queryList('SELECT * FROM asisteciapa',
        mapper: (Map<String, Object?> row) => AsisteciapaModelo(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            horaReg: row['hora_reg'] as String,
            latituda: row['latituda'] as double,
            longituda: row['longituda'] as double,
            tipo: row['tipo'] as String,
            calificacion: row['calificacion'] as int,
            cui: row['cui'] as String,
            tipoCui: row['tipo_cui'] as String,
            actividadId: row['actividad_id'] as int));
  }

  @override
  Stream<AsisteciapaModelo?> buscarAsisteciapaPorId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM asisteciapa WHERE id = ?1',
        mapper: (Map<String, Object?> row) => AsisteciapaModelo(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            horaReg: row['hora_reg'] as String,
            latituda: row['latituda'] as double,
            longituda: row['longituda'] as double,
            tipo: row['tipo'] as String,
            calificacion: row['calificacion'] as int,
            cui: row['cui'] as String,
            tipoCui: row['tipo_cui'] as String,
            actividadId: row['actividad_id'] as int),
        arguments: [id],
        queryableName: 'asisteciapa',
        isView: false);
  }

  @override
  Future<void> insertarAsisteciapa(AsisteciapaModelo asisteciapa) async {
    await _asisteciapaModeloInsertionAdapter.insert(
        asisteciapa, OnConflictStrategy.replace);
  }

  @override
  Future<void> actualizarAsisteciapa(AsisteciapaModelo asisteciapa) async {
    await _asisteciapaModeloUpdateAdapter.update(
        asisteciapa, OnConflictStrategy.abort);
  }

  @override
  Future<void> eliminarAsisteciapa(AsisteciapaModelo asisteciapa) async {
    await _asisteciapaModeloDeletionAdapter.delete(asisteciapa);
  }
}

class _$AsistenciaDao extends AsistenciaDao {
  _$AsistenciaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _asistenciaModeloInsertionAdapter = InsertionAdapter(
            database,
            'asistencia',
            (AsistenciaModelo item) => <String, Object?>{
                  'id': item.id,
                  'fecha': item.fecha,
                  'hora': item.hora,
                  'latituda': item.latituda,
                  'longituda': item.longituda,
                  'tipo': item.tipo,
                  'tipo_reg': item.tipoReg,
                  'id_matricula': item.idMatricula,
                  'id_evento': item.idEvento,
                  'id_persona': item.idPersona,
                  'calificacion': item.calificacion
                },
            changeListener),
        _asistenciaModeloUpdateAdapter = UpdateAdapter(
            database,
            'asistencia',
            ['id'],
            (AsistenciaModelo item) => <String, Object?>{
                  'id': item.id,
                  'fecha': item.fecha,
                  'hora': item.hora,
                  'latituda': item.latituda,
                  'longituda': item.longituda,
                  'tipo': item.tipo,
                  'tipo_reg': item.tipoReg,
                  'id_matricula': item.idMatricula,
                  'id_evento': item.idEvento,
                  'id_persona': item.idPersona,
                  'calificacion': item.calificacion
                },
            changeListener),
        _asistenciaModeloDeletionAdapter = DeletionAdapter(
            database,
            'asistencia',
            ['id'],
            (AsistenciaModelo item) => <String, Object?>{
                  'id': item.id,
                  'fecha': item.fecha,
                  'hora': item.hora,
                  'latituda': item.latituda,
                  'longituda': item.longituda,
                  'tipo': item.tipo,
                  'tipo_reg': item.tipoReg,
                  'id_matricula': item.idMatricula,
                  'id_evento': item.idEvento,
                  'id_persona': item.idPersona,
                  'calificacion': item.calificacion
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AsistenciaModelo> _asistenciaModeloInsertionAdapter;

  final UpdateAdapter<AsistenciaModelo> _asistenciaModeloUpdateAdapter;

  final DeletionAdapter<AsistenciaModelo> _asistenciaModeloDeletionAdapter;

  @override
  Future<List<AsistenciaModelo>> listarAsistencia() async {
    return _queryAdapter.queryList('SELECT * FROM asistencia',
        mapper: (Map<String, Object?> row) => AsistenciaModelo(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            hora: row['hora'] as String,
            latituda: row['latituda'] as double,
            longituda: row['longituda'] as double,
            tipo: row['tipo'] as String,
            tipoReg: row['tipo_reg'] as String,
            idMatricula: row['id_matricula'] as int,
            idEvento: row['id_evento'] as int,
            idPersona: row['id_persona'] as int,
            calificacion: row['calificacion'] as int));
  }

  @override
  Stream<AsistenciaModelo?> buscarAsistenciaPorId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM asistencia WHERE id = ?1',
        mapper: (Map<String, Object?> row) => AsistenciaModelo(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            hora: row['hora'] as String,
            latituda: row['latituda'] as double,
            longituda: row['longituda'] as double,
            tipo: row['tipo'] as String,
            tipoReg: row['tipo_reg'] as String,
            idMatricula: row['id_matricula'] as int,
            idEvento: row['id_evento'] as int,
            idPersona: row['id_persona'] as int,
            calificacion: row['calificacion'] as int),
        arguments: [id],
        queryableName: 'asistencia',
        isView: false);
  }

  @override
  Future<void> insertarAsistencia(AsistenciaModelo asistencia) async {
    await _asistenciaModeloInsertionAdapter.insert(
        asistencia, OnConflictStrategy.replace);
  }

  @override
  Future<void> actualizarAsistencia(AsistenciaModelo asistencia) async {
    await _asistenciaModeloUpdateAdapter.update(
        asistencia, OnConflictStrategy.abort);
  }

  @override
  Future<void> eliminarAsistencia(AsistenciaModelo asistencia) async {
    await _asistenciaModeloDeletionAdapter.delete(asistencia);
  }
}

class _$EscuelaDao extends EscuelaDao {
  _$EscuelaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _escuelaModeloInsertionAdapter = InsertionAdapter(
            database,
            'escuela',
            (EscuelaModelo item) => <String, Object?>{
                  'id': item.id,
                  'nombreeap': item.nombreeap,
                  'estado': item.estado,
                  'inicaleseap': item.inicialesEap,
                  'facultad_id': item.facultadId
                },
            changeListener),
        _escuelaModeloUpdateAdapter = UpdateAdapter(
            database,
            'escuela',
            ['id'],
            (EscuelaModelo item) => <String, Object?>{
                  'id': item.id,
                  'nombreeap': item.nombreeap,
                  'estado': item.estado,
                  'inicaleseap': item.inicialesEap,
                  'facultad_id': item.facultadId
                },
            changeListener),
        _escuelaModeloDeletionAdapter = DeletionAdapter(
            database,
            'escuela',
            ['id'],
            (EscuelaModelo item) => <String, Object?>{
                  'id': item.id,
                  'nombreeap': item.nombreeap,
                  'estado': item.estado,
                  'inicaleseap': item.inicialesEap,
                  'facultad_id': item.facultadId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EscuelaModelo> _escuelaModeloInsertionAdapter;

  final UpdateAdapter<EscuelaModelo> _escuelaModeloUpdateAdapter;

  final DeletionAdapter<EscuelaModelo> _escuelaModeloDeletionAdapter;

  @override
  Future<List<EscuelaModelo>> listarEscuela() async {
    return _queryAdapter.queryList('SELECT * FROM escuela',
        mapper: (Map<String, Object?> row) => EscuelaModelo(
            id: row['id'] as int,
            nombreeap: row['nombreeap'] as String,
            estado: row['estado'] as String,
            inicialesEap: row['inicaleseap'] as String,
            facultadId: row['facultad_id'] as int));
  }

  @override
  Stream<EscuelaModelo?> buscarEscuelaPorId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM escuela WHERE id = ?1',
        mapper: (Map<String, Object?> row) => EscuelaModelo(
            id: row['id'] as int,
            nombreeap: row['nombreeap'] as String,
            estado: row['estado'] as String,
            inicialesEap: row['inicaleseap'] as String,
            facultadId: row['facultad_id'] as int),
        arguments: [id],
        queryableName: 'escuela',
        isView: false);
  }

  @override
  Future<void> insertarEscuela(EscuelaModelo escuela) async {
    await _escuelaModeloInsertionAdapter.insert(
        escuela, OnConflictStrategy.replace);
  }

  @override
  Future<void> actualizarEscuela(EscuelaModelo escuela) async {
    await _escuelaModeloUpdateAdapter.update(escuela, OnConflictStrategy.abort);
  }

  @override
  Future<void> eliminarEscuela(EscuelaModelo escuela) async {
    await _escuelaModeloDeletionAdapter.delete(escuela);
  }
}

class _$EventoDao extends EventoDao {
  _$EventoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _eventoModeloInsertionAdapter = InsertionAdapter(
            database,
            'periodo',
            (EventoModelo item) => <String, Object?>{
                  'id': item.id,
                  'nom_evento': item.nom_evento,
                  'fecha': item.fecha,
                  'horai': item.horai,
                  'min_toler': item.min_toler,
                  'latitud': item.latitud,
                  'longitud': item.longitud,
                  'estado': item.estado,
                  'evaluar': item.evaluar,
                  'perfil_evento': item.perfil_evento,
                  'periodo_id': item.periodoId
                },
            changeListener),
        _eventoModeloUpdateAdapter = UpdateAdapter(
            database,
            'periodo',
            ['id'],
            (EventoModelo item) => <String, Object?>{
                  'id': item.id,
                  'nom_evento': item.nom_evento,
                  'fecha': item.fecha,
                  'horai': item.horai,
                  'min_toler': item.min_toler,
                  'latitud': item.latitud,
                  'longitud': item.longitud,
                  'estado': item.estado,
                  'evaluar': item.evaluar,
                  'perfil_evento': item.perfil_evento,
                  'periodo_id': item.periodoId
                },
            changeListener),
        _eventoModeloDeletionAdapter = DeletionAdapter(
            database,
            'periodo',
            ['id'],
            (EventoModelo item) => <String, Object?>{
                  'id': item.id,
                  'nom_evento': item.nom_evento,
                  'fecha': item.fecha,
                  'horai': item.horai,
                  'min_toler': item.min_toler,
                  'latitud': item.latitud,
                  'longitud': item.longitud,
                  'estado': item.estado,
                  'evaluar': item.evaluar,
                  'perfil_evento': item.perfil_evento,
                  'periodo_id': item.periodoId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EventoModelo> _eventoModeloInsertionAdapter;

  final UpdateAdapter<EventoModelo> _eventoModeloUpdateAdapter;

  final DeletionAdapter<EventoModelo> _eventoModeloDeletionAdapter;

  @override
  Future<List<EventoModelo>> listarEvento() async {
    return _queryAdapter.queryList('SELECT * FROM evento',
        mapper: (Map<String, Object?> row) => EventoModelo(
            id: row['id'] as int,
            nom_evento: row['nom_evento'] as String,
            fecha: row['fecha'] as String,
            horai: row['horai'] as String,
            min_toler: row['min_toler'] as int,
            latitud: row['latitud'] as double,
            longitud: row['longitud'] as double,
            estado: row['estado'] as String,
            evaluar: row['evaluar'] as String,
            perfil_evento: row['perfil_evento'] as String,
            periodoId: row['periodo_id'] as int));
  }

  @override
  Stream<EventoModelo?> buscarEventoPorId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM evento WHERE id = ?1',
        mapper: (Map<String, Object?> row) => EventoModelo(
            id: row['id'] as int,
            nom_evento: row['nom_evento'] as String,
            fecha: row['fecha'] as String,
            horai: row['horai'] as String,
            min_toler: row['min_toler'] as int,
            latitud: row['latitud'] as double,
            longitud: row['longitud'] as double,
            estado: row['estado'] as String,
            evaluar: row['evaluar'] as String,
            perfil_evento: row['perfil_evento'] as String,
            periodoId: row['periodo_id'] as int),
        arguments: [id],
        queryableName: 'evento',
        isView: false);
  }

  @override
  Future<void> insertarEvento(EventoModelo evento) async {
    await _eventoModeloInsertionAdapter.insert(
        evento, OnConflictStrategy.replace);
  }

  @override
  Future<void> actualizarEvento(EventoModelo evento) async {
    await _eventoModeloUpdateAdapter.update(evento, OnConflictStrategy.abort);
  }

  @override
  Future<void> eliminarEvento(EventoModelo evento) async {
    await _eventoModeloDeletionAdapter.delete(evento);
  }
}

class _$FacultadDao extends FacultadDao {
  _$FacultadDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _facultadModeloInsertionAdapter = InsertionAdapter(
            database,
            'facultad',
            (FacultadModelo item) => <String, Object?>{
                  'id': item.id,
                  'nombrefac': item.nombrefac,
                  'estado': item.estado,
                  'inicales': item.inicales
                },
            changeListener),
        _facultadModeloUpdateAdapter = UpdateAdapter(
            database,
            'facultad',
            ['id'],
            (FacultadModelo item) => <String, Object?>{
                  'id': item.id,
                  'nombrefac': item.nombrefac,
                  'estado': item.estado,
                  'inicales': item.inicales
                },
            changeListener),
        _facultadModeloDeletionAdapter = DeletionAdapter(
            database,
            'facultad',
            ['id'],
            (FacultadModelo item) => <String, Object?>{
                  'id': item.id,
                  'nombrefac': item.nombrefac,
                  'estado': item.estado,
                  'inicales': item.inicales
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FacultadModelo> _facultadModeloInsertionAdapter;

  final UpdateAdapter<FacultadModelo> _facultadModeloUpdateAdapter;

  final DeletionAdapter<FacultadModelo> _facultadModeloDeletionAdapter;

  @override
  Future<List<FacultadModelo>> listarFacultad() async {
    return _queryAdapter.queryList('SELECT * FROM facultad',
        mapper: (Map<String, Object?> row) => FacultadModelo(
            id: row['id'] as int,
            nombrefac: row['nombrefac'] as String,
            estado: row['estado'] as String,
            inicales: row['inicales'] as String));
  }

  @override
  Stream<FacultadModelo?> buscarFacultadPorId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM facultad WHERE id = ?1',
        mapper: (Map<String, Object?> row) => FacultadModelo(
            id: row['id'] as int,
            nombrefac: row['nombrefac'] as String,
            estado: row['estado'] as String,
            inicales: row['inicales'] as String),
        arguments: [id],
        queryableName: 'facultad',
        isView: false);
  }

  @override
  Future<void> insertarFacultad(FacultadModelo facultad) async {
    await _facultadModeloInsertionAdapter.insert(
        facultad, OnConflictStrategy.replace);
  }

  @override
  Future<void> actualizarFacultad(FacultadModelo facultad) async {
    await _facultadModeloUpdateAdapter.update(
        facultad, OnConflictStrategy.abort);
  }

  @override
  Future<void> eliminarFacultad(FacultadModelo facultad) async {
    await _facultadModeloDeletionAdapter.delete(facultad);
  }
}

class _$MatriculaDao extends MatriculaDao {
  _$MatriculaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _matriculaModeloInsertionAdapter = InsertionAdapter(
            database,
            'matricula',
            (MatriculaModelo item) => <String, Object?>{
                  'id': item.id,
                  'estado': item.estado,
                  'periodoId': item.periodoId,
                  'personaId': item.personaId
                },
            changeListener),
        _matriculaModeloUpdateAdapter = UpdateAdapter(
            database,
            'matricula',
            ['id'],
            (MatriculaModelo item) => <String, Object?>{
                  'id': item.id,
                  'estado': item.estado,
                  'periodoId': item.periodoId,
                  'personaId': item.personaId
                },
            changeListener),
        _matriculaModeloDeletionAdapter = DeletionAdapter(
            database,
            'matricula',
            ['id'],
            (MatriculaModelo item) => <String, Object?>{
                  'id': item.id,
                  'estado': item.estado,
                  'periodoId': item.periodoId,
                  'personaId': item.personaId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MatriculaModelo> _matriculaModeloInsertionAdapter;

  final UpdateAdapter<MatriculaModelo> _matriculaModeloUpdateAdapter;

  final DeletionAdapter<MatriculaModelo> _matriculaModeloDeletionAdapter;

  @override
  Future<List<MatriculaModelo>> listarMatricula() async {
    return _queryAdapter.queryList('SELECT * FROM matricula',
        mapper: (Map<String, Object?> row) => MatriculaModelo(
            id: row['id'] as int,
            estado: row['estado'] as String,
            periodoId: row['periodoId'] as int,
            personaId: row['personaId'] as int));
  }

  @override
  Stream<MatriculaModelo?> buscarMatriculaPorId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM matricula WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MatriculaModelo(
            id: row['id'] as int,
            estado: row['estado'] as String,
            periodoId: row['periodoId'] as int,
            personaId: row['personaId'] as int),
        arguments: [id],
        queryableName: 'matricula',
        isView: false);
  }

  @override
  Future<void> insertarMatricula(MatriculaModelo matricula) async {
    await _matriculaModeloInsertionAdapter.insert(
        matricula, OnConflictStrategy.replace);
  }

  @override
  Future<void> actualizarMatricula(MatriculaModelo matricula) async {
    await _matriculaModeloUpdateAdapter.update(
        matricula, OnConflictStrategy.abort);
  }

  @override
  Future<void> eliminarMatricula(MatriculaModelo matricula) async {
    await _matriculaModeloDeletionAdapter.delete(matricula);
  }
}

class _$PeriodoDao extends PeriodoDao {
  _$PeriodoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _periodoModeloInsertionAdapter = InsertionAdapter(
            database,
            'periodo',
            (PeriodoModelo item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'estado': item.estado
                },
            changeListener),
        _periodoModeloUpdateAdapter = UpdateAdapter(
            database,
            'periodo',
            ['id'],
            (PeriodoModelo item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'estado': item.estado
                },
            changeListener),
        _periodoModeloDeletionAdapter = DeletionAdapter(
            database,
            'periodo',
            ['id'],
            (PeriodoModelo item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'estado': item.estado
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PeriodoModelo> _periodoModeloInsertionAdapter;

  final UpdateAdapter<PeriodoModelo> _periodoModeloUpdateAdapter;

  final DeletionAdapter<PeriodoModelo> _periodoModeloDeletionAdapter;

  @override
  Future<List<PeriodoModelo>> listarPeriodo() async {
    return _queryAdapter.queryList('SELECT * FROM periodo',
        mapper: (Map<String, Object?> row) => PeriodoModelo(
            id: row['id'] as int,
            nombre: row['nombre'] as String,
            estado: row['estado'] as String));
  }

  @override
  Stream<PeriodoModelo?> buscarPeriodoPorId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM periodo WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PeriodoModelo(
            id: row['id'] as int,
            nombre: row['nombre'] as String,
            estado: row['estado'] as String),
        arguments: [id],
        queryableName: 'periodo',
        isView: false);
  }

  @override
  Future<void> insertarPeriodo(PeriodoModelo periodo) async {
    await _periodoModeloInsertionAdapter.insert(
        periodo, OnConflictStrategy.replace);
  }

  @override
  Future<void> actualizarPeriodo(PeriodoModelo periodo) async {
    await _periodoModeloUpdateAdapter.update(periodo, OnConflictStrategy.abort);
  }

  @override
  Future<void> eliminarPeriodo(PeriodoModelo periodo) async {
    await _periodoModeloDeletionAdapter.delete(periodo);
  }
}

class _$PersonaDao extends PersonaDao {
  _$PersonaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _personaModeloInsertionAdapter = InsertionAdapter(
            database,
            'persona',
            (PersonaModelo item) => <String, Object?>{
                  'id': item.id,
                  'dni': item.dni,
                  'codigo': item.codigo,
                  'nombre': item.nombre,
                  'apellido_paterno': item.apellidoPaterno,
                  'apellido_materno': item.apellidoMaterno,
                  'telefono': item.telefono,
                  'genero': item.genero,
                  'correo': item.correo,
                  'estado': item.estado,
                  'escuela_id': item.escuelaId
                },
            changeListener),
        _personaModeloUpdateAdapter = UpdateAdapter(
            database,
            'persona',
            ['id'],
            (PersonaModelo item) => <String, Object?>{
                  'id': item.id,
                  'dni': item.dni,
                  'codigo': item.codigo,
                  'nombre': item.nombre,
                  'apellido_paterno': item.apellidoPaterno,
                  'apellido_materno': item.apellidoMaterno,
                  'telefono': item.telefono,
                  'genero': item.genero,
                  'correo': item.correo,
                  'estado': item.estado,
                  'escuela_id': item.escuelaId
                },
            changeListener),
        _personaModeloDeletionAdapter = DeletionAdapter(
            database,
            'persona',
            ['id'],
            (PersonaModelo item) => <String, Object?>{
                  'id': item.id,
                  'dni': item.dni,
                  'codigo': item.codigo,
                  'nombre': item.nombre,
                  'apellido_paterno': item.apellidoPaterno,
                  'apellido_materno': item.apellidoMaterno,
                  'telefono': item.telefono,
                  'genero': item.genero,
                  'correo': item.correo,
                  'estado': item.estado,
                  'escuela_id': item.escuelaId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PersonaModelo> _personaModeloInsertionAdapter;

  final UpdateAdapter<PersonaModelo> _personaModeloUpdateAdapter;

  final DeletionAdapter<PersonaModelo> _personaModeloDeletionAdapter;

  @override
  Future<List<PersonaModelo>> listarPersona() async {
    return _queryAdapter.queryList('SELECT * FROM persona',
        mapper: (Map<String, Object?> row) => PersonaModelo(
            id: row['id'] as int,
            dni: row['dni'] as String,
            codigo: row['codigo'] as String,
            nombre: row['nombre'] as String,
            apellidoPaterno: row['apellido_paterno'] as String,
            apellidoMaterno: row['apellido_materno'] as String,
            telefono: row['telefono'] as String,
            genero: row['genero'] as String,
            correo: row['correo'] as String,
            estado: row['estado'] as String,
            escuelaId: row['escuela_id'] as int));
  }

  @override
  Stream<PersonaModelo?> buscarPersonaPorId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM persona WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PersonaModelo(
            id: row['id'] as int,
            dni: row['dni'] as String,
            codigo: row['codigo'] as String,
            nombre: row['nombre'] as String,
            apellidoPaterno: row['apellido_paterno'] as String,
            apellidoMaterno: row['apellido_materno'] as String,
            telefono: row['telefono'] as String,
            genero: row['genero'] as String,
            correo: row['correo'] as String,
            estado: row['estado'] as String,
            escuelaId: row['escuela_id'] as int),
        arguments: [id],
        queryableName: 'persona',
        isView: false);
  }

  @override
  Future<void> insertarPersona(PersonaModelo persona) async {
    await _personaModeloInsertionAdapter.insert(
        persona, OnConflictStrategy.replace);
  }

  @override
  Future<void> actualizarPersona(PersonaModelo persona) async {
    await _personaModeloUpdateAdapter.update(persona, OnConflictStrategy.abort);
  }

  @override
  Future<void> eliminarPersona(PersonaModelo persona) async {
    await _personaModeloDeletionAdapter.delete(persona);
  }
}
