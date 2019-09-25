// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Cobrador extends DataClass implements Insertable<Cobrador> {
  final int id;
  final int usuarioid;
  final int cobradorid;
  final String nombre;
  final String telefono;
  final String direccion;
  final bool defecto;
  Cobrador(
      {@required this.id,
      @required this.usuarioid,
      @required this.cobradorid,
      @required this.nombre,
      @required this.telefono,
      @required this.direccion,
      @required this.defecto});
  factory Cobrador.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Cobrador(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      usuarioid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}usuarioid']),
      cobradorid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}cobradorid']),
      nombre:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}nombre']),
      telefono: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}telefono']),
      direccion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}direccion']),
      defecto:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}defecto']),
    );
  }
  factory Cobrador.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Cobrador(
      id: serializer.fromJson<int>(json['id']),
      usuarioid: serializer.fromJson<int>(json['usuarioid']),
      cobradorid: serializer.fromJson<int>(json['cobradorid']),
      nombre: serializer.fromJson<String>(json['nombre']),
      telefono: serializer.fromJson<String>(json['telefono']),
      direccion: serializer.fromJson<String>(json['direccion']),
      defecto: serializer.fromJson<bool>(json['defecto']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'usuarioid': serializer.toJson<int>(usuarioid),
      'cobradorid': serializer.toJson<int>(cobradorid),
      'nombre': serializer.toJson<String>(nombre),
      'telefono': serializer.toJson<String>(telefono),
      'direccion': serializer.toJson<String>(direccion),
      'defecto': serializer.toJson<bool>(defecto),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Cobrador>>(bool nullToAbsent) {
    return CobradorsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      usuarioid: usuarioid == null && nullToAbsent
          ? const Value.absent()
          : Value(usuarioid),
      cobradorid: cobradorid == null && nullToAbsent
          ? const Value.absent()
          : Value(cobradorid),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      direccion: direccion == null && nullToAbsent
          ? const Value.absent()
          : Value(direccion),
      defecto: defecto == null && nullToAbsent
          ? const Value.absent()
          : Value(defecto),
    ) as T;
  }

  Cobrador copyWith(
          {int id,
          int usuarioid,
          int cobradorid,
          String nombre,
          String telefono,
          String direccion,
          bool defecto}) =>
      Cobrador(
        id: id ?? this.id,
        usuarioid: usuarioid ?? this.usuarioid,
        cobradorid: cobradorid ?? this.cobradorid,
        nombre: nombre ?? this.nombre,
        telefono: telefono ?? this.telefono,
        direccion: direccion ?? this.direccion,
        defecto: defecto ?? this.defecto,
      );
  @override
  String toString() {
    return (StringBuffer('Cobrador(')
          ..write('id: $id, ')
          ..write('usuarioid: $usuarioid, ')
          ..write('cobradorid: $cobradorid, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono, ')
          ..write('direccion: $direccion, ')
          ..write('defecto: $defecto')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc(
                  $mrjc($mrjc($mrjc(0, id.hashCode), usuarioid.hashCode),
                      cobradorid.hashCode),
                  nombre.hashCode),
              telefono.hashCode),
          direccion.hashCode),
      defecto.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Cobrador &&
          other.id == id &&
          other.usuarioid == usuarioid &&
          other.cobradorid == cobradorid &&
          other.nombre == nombre &&
          other.telefono == telefono &&
          other.direccion == direccion &&
          other.defecto == defecto);
}

class CobradorsCompanion extends UpdateCompanion<Cobrador> {
  final Value<int> id;
  final Value<int> usuarioid;
  final Value<int> cobradorid;
  final Value<String> nombre;
  final Value<String> telefono;
  final Value<String> direccion;
  final Value<bool> defecto;
  const CobradorsCompanion({
    this.id = const Value.absent(),
    this.usuarioid = const Value.absent(),
    this.cobradorid = const Value.absent(),
    this.nombre = const Value.absent(),
    this.telefono = const Value.absent(),
    this.direccion = const Value.absent(),
    this.defecto = const Value.absent(),
  });
}

class $CobradorsTable extends Cobradors
    with TableInfo<$CobradorsTable, Cobrador> {
  final GeneratedDatabase _db;
  final String _alias;
  $CobradorsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false, hasAutoIncrement: true);
  }

  final VerificationMeta _usuarioidMeta = const VerificationMeta('usuarioid');
  GeneratedIntColumn _usuarioid;
  @override
  GeneratedIntColumn get usuarioid => _usuarioid ??= _constructUsuarioid();
  GeneratedIntColumn _constructUsuarioid() {
    return GeneratedIntColumn('usuarioid', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _cobradoridMeta = const VerificationMeta('cobradorid');
  GeneratedIntColumn _cobradorid;
  @override
  GeneratedIntColumn get cobradorid => _cobradorid ??= _constructCobradorid();
  GeneratedIntColumn _constructCobradorid() {
    return GeneratedIntColumn('cobradorid', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  GeneratedTextColumn _nombre;
  @override
  GeneratedTextColumn get nombre => _nombre ??= _constructNombre();
  GeneratedTextColumn _constructNombre() {
    return GeneratedTextColumn('nombre', $tableName, false, maxTextLength: 100);
  }

  final VerificationMeta _telefonoMeta = const VerificationMeta('telefono');
  GeneratedTextColumn _telefono;
  @override
  GeneratedTextColumn get telefono => _telefono ??= _constructTelefono();
  GeneratedTextColumn _constructTelefono() {
    return GeneratedTextColumn('telefono', $tableName, false,
        maxTextLength: 30);
  }

  final VerificationMeta _direccionMeta = const VerificationMeta('direccion');
  GeneratedTextColumn _direccion;
  @override
  GeneratedTextColumn get direccion => _direccion ??= _constructDireccion();
  GeneratedTextColumn _constructDireccion() {
    return GeneratedTextColumn('direccion', $tableName, false,
        maxTextLength: 200);
  }

  final VerificationMeta _defectoMeta = const VerificationMeta('defecto');
  GeneratedBoolColumn _defecto;
  @override
  GeneratedBoolColumn get defecto => _defecto ??= _constructDefecto();
  GeneratedBoolColumn _constructDefecto() {
    return GeneratedBoolColumn('defecto', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, usuarioid, cobradorid, nombre, telefono, direccion, defecto];
  @override
  $CobradorsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cobradors';
  @override
  final String actualTableName = 'cobradors';
  @override
  VerificationContext validateIntegrity(CobradorsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.usuarioid.present) {
      context.handle(_usuarioidMeta,
          usuarioid.isAcceptableValue(d.usuarioid.value, _usuarioidMeta));
    } else if (usuarioid.isRequired && isInserting) {
      context.missing(_usuarioidMeta);
    }
    if (d.cobradorid.present) {
      context.handle(_cobradoridMeta,
          cobradorid.isAcceptableValue(d.cobradorid.value, _cobradoridMeta));
    } else if (cobradorid.isRequired && isInserting) {
      context.missing(_cobradoridMeta);
    }
    if (d.nombre.present) {
      context.handle(
          _nombreMeta, nombre.isAcceptableValue(d.nombre.value, _nombreMeta));
    } else if (nombre.isRequired && isInserting) {
      context.missing(_nombreMeta);
    }
    if (d.telefono.present) {
      context.handle(_telefonoMeta,
          telefono.isAcceptableValue(d.telefono.value, _telefonoMeta));
    } else if (telefono.isRequired && isInserting) {
      context.missing(_telefonoMeta);
    }
    if (d.direccion.present) {
      context.handle(_direccionMeta,
          direccion.isAcceptableValue(d.direccion.value, _direccionMeta));
    } else if (direccion.isRequired && isInserting) {
      context.missing(_direccionMeta);
    }
    if (d.defecto.present) {
      context.handle(_defectoMeta,
          defecto.isAcceptableValue(d.defecto.value, _defectoMeta));
    } else if (defecto.isRequired && isInserting) {
      context.missing(_defectoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cobrador map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Cobrador.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CobradorsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.usuarioid.present) {
      map['usuarioid'] = Variable<int, IntType>(d.usuarioid.value);
    }
    if (d.cobradorid.present) {
      map['cobradorid'] = Variable<int, IntType>(d.cobradorid.value);
    }
    if (d.nombre.present) {
      map['nombre'] = Variable<String, StringType>(d.nombre.value);
    }
    if (d.telefono.present) {
      map['telefono'] = Variable<String, StringType>(d.telefono.value);
    }
    if (d.direccion.present) {
      map['direccion'] = Variable<String, StringType>(d.direccion.value);
    }
    if (d.defecto.present) {
      map['defecto'] = Variable<bool, BoolType>(d.defecto.value);
    }
    return map;
  }

  @override
  $CobradorsTable createAlias(String alias) {
    return $CobradorsTable(_db, alias);
  }
}

class Empresa extends DataClass implements Insertable<Empresa> {
  final int id;
  final String nombre;
  final String direccion;
  final String rnc;
  final String telefono;
  final String slogan;
  final bool listadocompleto;
  final bool primeromora;
  Empresa(
      {@required this.id,
      @required this.nombre,
      @required this.direccion,
      @required this.rnc,
      @required this.telefono,
      @required this.slogan,
      @required this.listadocompleto,
      @required this.primeromora});
  factory Empresa.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Empresa(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      nombre:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}nombre']),
      direccion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}direccion']),
      rnc: stringType.mapFromDatabaseResponse(data['${effectivePrefix}rnc']),
      telefono: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}telefono']),
      slogan:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}slogan']),
      listadocompleto: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}listadocompleto']),
      primeromora: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}primeromora']),
    );
  }
  factory Empresa.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Empresa(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      direccion: serializer.fromJson<String>(json['direccion']),
      rnc: serializer.fromJson<String>(json['rnc']),
      telefono: serializer.fromJson<String>(json['telefono']),
      slogan: serializer.fromJson<String>(json['slogan']),
      listadocompleto: serializer.fromJson<bool>(json['listadocompleto']),
      primeromora: serializer.fromJson<bool>(json['primeromora']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'direccion': serializer.toJson<String>(direccion),
      'rnc': serializer.toJson<String>(rnc),
      'telefono': serializer.toJson<String>(telefono),
      'slogan': serializer.toJson<String>(slogan),
      'listadocompleto': serializer.toJson<bool>(listadocompleto),
      'primeromora': serializer.toJson<bool>(primeromora),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Empresa>>(bool nullToAbsent) {
    return EmpresaSettingCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      direccion: direccion == null && nullToAbsent
          ? const Value.absent()
          : Value(direccion),
      rnc: rnc == null && nullToAbsent ? const Value.absent() : Value(rnc),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      slogan:
          slogan == null && nullToAbsent ? const Value.absent() : Value(slogan),
      listadocompleto: listadocompleto == null && nullToAbsent
          ? const Value.absent()
          : Value(listadocompleto),
      primeromora: primeromora == null && nullToAbsent
          ? const Value.absent()
          : Value(primeromora),
    ) as T;
  }

  Empresa copyWith(
          {int id,
          String nombre,
          String direccion,
          String rnc,
          String telefono,
          String slogan,
          bool listadocompleto,
          bool primeromora}) =>
      Empresa(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        direccion: direccion ?? this.direccion,
        rnc: rnc ?? this.rnc,
        telefono: telefono ?? this.telefono,
        slogan: slogan ?? this.slogan,
        listadocompleto: listadocompleto ?? this.listadocompleto,
        primeromora: primeromora ?? this.primeromora,
      );
  @override
  String toString() {
    return (StringBuffer('Empresa(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('direccion: $direccion, ')
          ..write('rnc: $rnc, ')
          ..write('telefono: $telefono, ')
          ..write('slogan: $slogan, ')
          ..write('listadocompleto: $listadocompleto, ')
          ..write('primeromora: $primeromora')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc(
                  $mrjc(
                      $mrjc($mrjc($mrjc(0, id.hashCode), nombre.hashCode),
                          direccion.hashCode),
                      rnc.hashCode),
                  telefono.hashCode),
              slogan.hashCode),
          listadocompleto.hashCode),
      primeromora.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Empresa &&
          other.id == id &&
          other.nombre == nombre &&
          other.direccion == direccion &&
          other.rnc == rnc &&
          other.telefono == telefono &&
          other.slogan == slogan &&
          other.listadocompleto == listadocompleto &&
          other.primeromora == primeromora);
}

class EmpresaSettingCompanion extends UpdateCompanion<Empresa> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> direccion;
  final Value<String> rnc;
  final Value<String> telefono;
  final Value<String> slogan;
  final Value<bool> listadocompleto;
  final Value<bool> primeromora;
  const EmpresaSettingCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.direccion = const Value.absent(),
    this.rnc = const Value.absent(),
    this.telefono = const Value.absent(),
    this.slogan = const Value.absent(),
    this.listadocompleto = const Value.absent(),
    this.primeromora = const Value.absent(),
  });
}

class $EmpresaSettingTable extends EmpresaSetting
    with TableInfo<$EmpresaSettingTable, Empresa> {
  final GeneratedDatabase _db;
  final String _alias;
  $EmpresaSettingTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  GeneratedTextColumn _nombre;
  @override
  GeneratedTextColumn get nombre => _nombre ??= _constructNombre();
  GeneratedTextColumn _constructNombre() {
    return GeneratedTextColumn('nombre', $tableName, false, maxTextLength: 50);
  }

  final VerificationMeta _direccionMeta = const VerificationMeta('direccion');
  GeneratedTextColumn _direccion;
  @override
  GeneratedTextColumn get direccion => _direccion ??= _constructDireccion();
  GeneratedTextColumn _constructDireccion() {
    return GeneratedTextColumn('direccion', $tableName, false,
        maxTextLength: 200);
  }

  final VerificationMeta _rncMeta = const VerificationMeta('rnc');
  GeneratedTextColumn _rnc;
  @override
  GeneratedTextColumn get rnc => _rnc ??= _constructRnc();
  GeneratedTextColumn _constructRnc() {
    return GeneratedTextColumn('rnc', $tableName, false, maxTextLength: 20);
  }

  final VerificationMeta _telefonoMeta = const VerificationMeta('telefono');
  GeneratedTextColumn _telefono;
  @override
  GeneratedTextColumn get telefono => _telefono ??= _constructTelefono();
  GeneratedTextColumn _constructTelefono() {
    return GeneratedTextColumn('telefono', $tableName, false,
        maxTextLength: 50);
  }

  final VerificationMeta _sloganMeta = const VerificationMeta('slogan');
  GeneratedTextColumn _slogan;
  @override
  GeneratedTextColumn get slogan => _slogan ??= _constructSlogan();
  GeneratedTextColumn _constructSlogan() {
    return GeneratedTextColumn('slogan', $tableName, false, maxTextLength: 100);
  }

  final VerificationMeta _listadocompletoMeta =
      const VerificationMeta('listadocompleto');
  GeneratedBoolColumn _listadocompleto;
  @override
  GeneratedBoolColumn get listadocompleto =>
      _listadocompleto ??= _constructListadocompleto();
  GeneratedBoolColumn _constructListadocompleto() {
    return GeneratedBoolColumn(
      'listadocompleto',
      $tableName,
      false,
    );
  }

  final VerificationMeta _primeromoraMeta =
      const VerificationMeta('primeromora');
  GeneratedBoolColumn _primeromora;
  @override
  GeneratedBoolColumn get primeromora =>
      _primeromora ??= _constructPrimeromora();
  GeneratedBoolColumn _constructPrimeromora() {
    return GeneratedBoolColumn(
      'primeromora',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        nombre,
        direccion,
        rnc,
        telefono,
        slogan,
        listadocompleto,
        primeromora
      ];
  @override
  $EmpresaSettingTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'empresa_setting';
  @override
  final String actualTableName = 'empresa_setting';
  @override
  VerificationContext validateIntegrity(EmpresaSettingCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.nombre.present) {
      context.handle(
          _nombreMeta, nombre.isAcceptableValue(d.nombre.value, _nombreMeta));
    } else if (nombre.isRequired && isInserting) {
      context.missing(_nombreMeta);
    }
    if (d.direccion.present) {
      context.handle(_direccionMeta,
          direccion.isAcceptableValue(d.direccion.value, _direccionMeta));
    } else if (direccion.isRequired && isInserting) {
      context.missing(_direccionMeta);
    }
    if (d.rnc.present) {
      context.handle(_rncMeta, rnc.isAcceptableValue(d.rnc.value, _rncMeta));
    } else if (rnc.isRequired && isInserting) {
      context.missing(_rncMeta);
    }
    if (d.telefono.present) {
      context.handle(_telefonoMeta,
          telefono.isAcceptableValue(d.telefono.value, _telefonoMeta));
    } else if (telefono.isRequired && isInserting) {
      context.missing(_telefonoMeta);
    }
    if (d.slogan.present) {
      context.handle(
          _sloganMeta, slogan.isAcceptableValue(d.slogan.value, _sloganMeta));
    } else if (slogan.isRequired && isInserting) {
      context.missing(_sloganMeta);
    }
    if (d.listadocompleto.present) {
      context.handle(
          _listadocompletoMeta,
          listadocompleto.isAcceptableValue(
              d.listadocompleto.value, _listadocompletoMeta));
    } else if (listadocompleto.isRequired && isInserting) {
      context.missing(_listadocompletoMeta);
    }
    if (d.primeromora.present) {
      context.handle(_primeromoraMeta,
          primeromora.isAcceptableValue(d.primeromora.value, _primeromoraMeta));
    } else if (primeromora.isRequired && isInserting) {
      context.missing(_primeromoraMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Empresa map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Empresa.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(EmpresaSettingCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.nombre.present) {
      map['nombre'] = Variable<String, StringType>(d.nombre.value);
    }
    if (d.direccion.present) {
      map['direccion'] = Variable<String, StringType>(d.direccion.value);
    }
    if (d.rnc.present) {
      map['rnc'] = Variable<String, StringType>(d.rnc.value);
    }
    if (d.telefono.present) {
      map['telefono'] = Variable<String, StringType>(d.telefono.value);
    }
    if (d.slogan.present) {
      map['slogan'] = Variable<String, StringType>(d.slogan.value);
    }
    if (d.listadocompleto.present) {
      map['listadocompleto'] =
          Variable<bool, BoolType>(d.listadocompleto.value);
    }
    if (d.primeromora.present) {
      map['primeromora'] = Variable<bool, BoolType>(d.primeromora.value);
    }
    return map;
  }

  @override
  $EmpresaSettingTable createAlias(String alias) {
    return $EmpresaSettingTable(_db, alias);
  }
}

class MenuOption extends DataClass implements Insertable<MenuOption> {
  final int menuid;
  final String nombre;
  final int level;
  final String routename;
  final int orden;
  final bool activo;
  MenuOption(
      {@required this.menuid,
      @required this.nombre,
      @required this.level,
      @required this.routename,
      @required this.orden,
      @required this.activo});
  factory MenuOption.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return MenuOption(
      menuid: intType.mapFromDatabaseResponse(data['${effectivePrefix}menuid']),
      nombre:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}nombre']),
      level: intType.mapFromDatabaseResponse(data['${effectivePrefix}level']),
      routename: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}routename']),
      orden: intType.mapFromDatabaseResponse(data['${effectivePrefix}orden']),
      activo:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}activo']),
    );
  }
  factory MenuOption.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return MenuOption(
      menuid: serializer.fromJson<int>(json['menuid']),
      nombre: serializer.fromJson<String>(json['nombre']),
      level: serializer.fromJson<int>(json['level']),
      routename: serializer.fromJson<String>(json['routename']),
      orden: serializer.fromJson<int>(json['orden']),
      activo: serializer.fromJson<bool>(json['activo']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'menuid': serializer.toJson<int>(menuid),
      'nombre': serializer.toJson<String>(nombre),
      'level': serializer.toJson<int>(level),
      'routename': serializer.toJson<String>(routename),
      'orden': serializer.toJson<int>(orden),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<MenuOption>>(bool nullToAbsent) {
    return MenuOptionsCompanion(
      menuid:
          menuid == null && nullToAbsent ? const Value.absent() : Value(menuid),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      level:
          level == null && nullToAbsent ? const Value.absent() : Value(level),
      routename: routename == null && nullToAbsent
          ? const Value.absent()
          : Value(routename),
      orden:
          orden == null && nullToAbsent ? const Value.absent() : Value(orden),
      activo:
          activo == null && nullToAbsent ? const Value.absent() : Value(activo),
    ) as T;
  }

  MenuOption copyWith(
          {int menuid,
          String nombre,
          int level,
          String routename,
          int orden,
          bool activo}) =>
      MenuOption(
        menuid: menuid ?? this.menuid,
        nombre: nombre ?? this.nombre,
        level: level ?? this.level,
        routename: routename ?? this.routename,
        orden: orden ?? this.orden,
        activo: activo ?? this.activo,
      );
  @override
  String toString() {
    return (StringBuffer('MenuOption(')
          ..write('menuid: $menuid, ')
          ..write('nombre: $nombre, ')
          ..write('level: $level, ')
          ..write('routename: $routename, ')
          ..write('orden: $orden, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc($mrjc($mrjc(0, menuid.hashCode), nombre.hashCode),
                  level.hashCode),
              routename.hashCode),
          orden.hashCode),
      activo.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is MenuOption &&
          other.menuid == menuid &&
          other.nombre == nombre &&
          other.level == level &&
          other.routename == routename &&
          other.orden == orden &&
          other.activo == activo);
}

class MenuOptionsCompanion extends UpdateCompanion<MenuOption> {
  final Value<int> menuid;
  final Value<String> nombre;
  final Value<int> level;
  final Value<String> routename;
  final Value<int> orden;
  final Value<bool> activo;
  const MenuOptionsCompanion({
    this.menuid = const Value.absent(),
    this.nombre = const Value.absent(),
    this.level = const Value.absent(),
    this.routename = const Value.absent(),
    this.orden = const Value.absent(),
    this.activo = const Value.absent(),
  });
}

class $MenuOptionsTable extends MenuOptions
    with TableInfo<$MenuOptionsTable, MenuOption> {
  final GeneratedDatabase _db;
  final String _alias;
  $MenuOptionsTable(this._db, [this._alias]);
  final VerificationMeta _menuidMeta = const VerificationMeta('menuid');
  GeneratedIntColumn _menuid;
  @override
  GeneratedIntColumn get menuid => _menuid ??= _constructMenuid();
  GeneratedIntColumn _constructMenuid() {
    return GeneratedIntColumn('menuid', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  GeneratedTextColumn _nombre;
  @override
  GeneratedTextColumn get nombre => _nombre ??= _constructNombre();
  GeneratedTextColumn _constructNombre() {
    return GeneratedTextColumn('nombre', $tableName, false, maxTextLength: 50);
  }

  final VerificationMeta _levelMeta = const VerificationMeta('level');
  GeneratedIntColumn _level;
  @override
  GeneratedIntColumn get level => _level ??= _constructLevel();
  GeneratedIntColumn _constructLevel() {
    return GeneratedIntColumn('level', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _routenameMeta = const VerificationMeta('routename');
  GeneratedTextColumn _routename;
  @override
  GeneratedTextColumn get routename => _routename ??= _constructRoutename();
  GeneratedTextColumn _constructRoutename() {
    return GeneratedTextColumn('routename', $tableName, false,
        maxTextLength: 50);
  }

  final VerificationMeta _ordenMeta = const VerificationMeta('orden');
  GeneratedIntColumn _orden;
  @override
  GeneratedIntColumn get orden => _orden ??= _constructOrden();
  GeneratedIntColumn _constructOrden() {
    return GeneratedIntColumn('orden', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _activoMeta = const VerificationMeta('activo');
  GeneratedBoolColumn _activo;
  @override
  GeneratedBoolColumn get activo => _activo ??= _constructActivo();
  GeneratedBoolColumn _constructActivo() {
    return GeneratedBoolColumn('activo', $tableName, false,
        defaultValue: Constant(true));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [menuid, nombre, level, routename, orden, activo];
  @override
  $MenuOptionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'menu_options';
  @override
  final String actualTableName = 'menu_options';
  @override
  VerificationContext validateIntegrity(MenuOptionsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.menuid.present) {
      context.handle(
          _menuidMeta, menuid.isAcceptableValue(d.menuid.value, _menuidMeta));
    } else if (menuid.isRequired && isInserting) {
      context.missing(_menuidMeta);
    }
    if (d.nombre.present) {
      context.handle(
          _nombreMeta, nombre.isAcceptableValue(d.nombre.value, _nombreMeta));
    } else if (nombre.isRequired && isInserting) {
      context.missing(_nombreMeta);
    }
    if (d.level.present) {
      context.handle(
          _levelMeta, level.isAcceptableValue(d.level.value, _levelMeta));
    } else if (level.isRequired && isInserting) {
      context.missing(_levelMeta);
    }
    if (d.routename.present) {
      context.handle(_routenameMeta,
          routename.isAcceptableValue(d.routename.value, _routenameMeta));
    } else if (routename.isRequired && isInserting) {
      context.missing(_routenameMeta);
    }
    if (d.orden.present) {
      context.handle(
          _ordenMeta, orden.isAcceptableValue(d.orden.value, _ordenMeta));
    } else if (orden.isRequired && isInserting) {
      context.missing(_ordenMeta);
    }
    if (d.activo.present) {
      context.handle(
          _activoMeta, activo.isAcceptableValue(d.activo.value, _activoMeta));
    } else if (activo.isRequired && isInserting) {
      context.missing(_activoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {menuid};
  @override
  MenuOption map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MenuOption.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(MenuOptionsCompanion d) {
    final map = <String, Variable>{};
    if (d.menuid.present) {
      map['menuid'] = Variable<int, IntType>(d.menuid.value);
    }
    if (d.nombre.present) {
      map['nombre'] = Variable<String, StringType>(d.nombre.value);
    }
    if (d.level.present) {
      map['level'] = Variable<int, IntType>(d.level.value);
    }
    if (d.routename.present) {
      map['routename'] = Variable<String, StringType>(d.routename.value);
    }
    if (d.orden.present) {
      map['orden'] = Variable<int, IntType>(d.orden.value);
    }
    if (d.activo.present) {
      map['activo'] = Variable<bool, BoolType>(d.activo.value);
    }
    return map;
  }

  @override
  $MenuOptionsTable createAlias(String alias) {
    return $MenuOptionsTable(_db, alias);
  }
}

class Pagare extends DataClass implements Insertable<Pagare> {
  final String prestamoid;
  final int idpagare;
  final int pagare;
  final DateTime fechavenc;
  final double monto;
  final double capital;
  final double interes;
  final double comision;
  final double mora;
  final double balance;
  Pagare(
      {@required this.prestamoid,
      @required this.idpagare,
      @required this.pagare,
      @required this.fechavenc,
      @required this.monto,
      @required this.capital,
      @required this.interes,
      @required this.comision,
      @required this.mora,
      @required this.balance});
  factory Pagare.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Pagare(
      prestamoid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}prestamoid']),
      idpagare:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}idpagare']),
      pagare: intType.mapFromDatabaseResponse(data['${effectivePrefix}pagare']),
      fechavenc: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}fechavenc']),
      monto:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}monto']),
      capital:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}capital']),
      interes:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}interes']),
      comision: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}comision']),
      mora: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}mora']),
      balance:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}balance']),
    );
  }
  factory Pagare.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Pagare(
      prestamoid: serializer.fromJson<String>(json['prestamoid']),
      idpagare: serializer.fromJson<int>(json['idpagare']),
      pagare: serializer.fromJson<int>(json['pagare']),
      fechavenc: serializer.fromJson<DateTime>(json['fechavenc']),
      monto: serializer.fromJson<double>(json['monto']),
      capital: serializer.fromJson<double>(json['capital']),
      interes: serializer.fromJson<double>(json['interes']),
      comision: serializer.fromJson<double>(json['comision']),
      mora: serializer.fromJson<double>(json['mora']),
      balance: serializer.fromJson<double>(json['balance']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'prestamoid': serializer.toJson<String>(prestamoid),
      'idpagare': serializer.toJson<int>(idpagare),
      'pagare': serializer.toJson<int>(pagare),
      'fechavenc': serializer.toJson<DateTime>(fechavenc),
      'monto': serializer.toJson<double>(monto),
      'capital': serializer.toJson<double>(capital),
      'interes': serializer.toJson<double>(interes),
      'comision': serializer.toJson<double>(comision),
      'mora': serializer.toJson<double>(mora),
      'balance': serializer.toJson<double>(balance),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Pagare>>(bool nullToAbsent) {
    return PagaresCompanion(
      prestamoid: prestamoid == null && nullToAbsent
          ? const Value.absent()
          : Value(prestamoid),
      idpagare: idpagare == null && nullToAbsent
          ? const Value.absent()
          : Value(idpagare),
      pagare:
          pagare == null && nullToAbsent ? const Value.absent() : Value(pagare),
      fechavenc: fechavenc == null && nullToAbsent
          ? const Value.absent()
          : Value(fechavenc),
      monto:
          monto == null && nullToAbsent ? const Value.absent() : Value(monto),
      capital: capital == null && nullToAbsent
          ? const Value.absent()
          : Value(capital),
      interes: interes == null && nullToAbsent
          ? const Value.absent()
          : Value(interes),
      comision: comision == null && nullToAbsent
          ? const Value.absent()
          : Value(comision),
      mora: mora == null && nullToAbsent ? const Value.absent() : Value(mora),
      balance: balance == null && nullToAbsent
          ? const Value.absent()
          : Value(balance),
    ) as T;
  }

  Pagare copyWith(
          {String prestamoid,
          int idpagare,
          int pagare,
          DateTime fechavenc,
          double monto,
          double capital,
          double interes,
          double comision,
          double mora,
          double balance}) =>
      Pagare(
        prestamoid: prestamoid ?? this.prestamoid,
        idpagare: idpagare ?? this.idpagare,
        pagare: pagare ?? this.pagare,
        fechavenc: fechavenc ?? this.fechavenc,
        monto: monto ?? this.monto,
        capital: capital ?? this.capital,
        interes: interes ?? this.interes,
        comision: comision ?? this.comision,
        mora: mora ?? this.mora,
        balance: balance ?? this.balance,
      );
  @override
  String toString() {
    return (StringBuffer('Pagare(')
          ..write('prestamoid: $prestamoid, ')
          ..write('idpagare: $idpagare, ')
          ..write('pagare: $pagare, ')
          ..write('fechavenc: $fechavenc, ')
          ..write('monto: $monto, ')
          ..write('capital: $capital, ')
          ..write('interes: $interes, ')
          ..write('comision: $comision, ')
          ..write('mora: $mora, ')
          ..write('balance: $balance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc(
                  $mrjc(
                      $mrjc(
                          $mrjc(
                              $mrjc(
                                  $mrjc($mrjc(0, prestamoid.hashCode),
                                      idpagare.hashCode),
                                  pagare.hashCode),
                              fechavenc.hashCode),
                          monto.hashCode),
                      capital.hashCode),
                  interes.hashCode),
              comision.hashCode),
          mora.hashCode),
      balance.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Pagare &&
          other.prestamoid == prestamoid &&
          other.idpagare == idpagare &&
          other.pagare == pagare &&
          other.fechavenc == fechavenc &&
          other.monto == monto &&
          other.capital == capital &&
          other.interes == interes &&
          other.comision == comision &&
          other.mora == mora &&
          other.balance == balance);
}

class PagaresCompanion extends UpdateCompanion<Pagare> {
  final Value<String> prestamoid;
  final Value<int> idpagare;
  final Value<int> pagare;
  final Value<DateTime> fechavenc;
  final Value<double> monto;
  final Value<double> capital;
  final Value<double> interes;
  final Value<double> comision;
  final Value<double> mora;
  final Value<double> balance;
  const PagaresCompanion({
    this.prestamoid = const Value.absent(),
    this.idpagare = const Value.absent(),
    this.pagare = const Value.absent(),
    this.fechavenc = const Value.absent(),
    this.monto = const Value.absent(),
    this.capital = const Value.absent(),
    this.interes = const Value.absent(),
    this.comision = const Value.absent(),
    this.mora = const Value.absent(),
    this.balance = const Value.absent(),
  });
}

class $PagaresTable extends Pagares with TableInfo<$PagaresTable, Pagare> {
  final GeneratedDatabase _db;
  final String _alias;
  $PagaresTable(this._db, [this._alias]);
  final VerificationMeta _prestamoidMeta = const VerificationMeta('prestamoid');
  GeneratedTextColumn _prestamoid;
  @override
  GeneratedTextColumn get prestamoid => _prestamoid ??= _constructPrestamoid();
  GeneratedTextColumn _constructPrestamoid() {
    return GeneratedTextColumn('prestamoid', $tableName, false,
        maxTextLength: 15);
  }

  final VerificationMeta _idpagareMeta = const VerificationMeta('idpagare');
  GeneratedIntColumn _idpagare;
  @override
  GeneratedIntColumn get idpagare => _idpagare ??= _constructIdpagare();
  GeneratedIntColumn _constructIdpagare() {
    return GeneratedIntColumn(
      'idpagare',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pagareMeta = const VerificationMeta('pagare');
  GeneratedIntColumn _pagare;
  @override
  GeneratedIntColumn get pagare => _pagare ??= _constructPagare();
  GeneratedIntColumn _constructPagare() {
    return GeneratedIntColumn(
      'pagare',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fechavencMeta = const VerificationMeta('fechavenc');
  GeneratedDateTimeColumn _fechavenc;
  @override
  GeneratedDateTimeColumn get fechavenc => _fechavenc ??= _constructFechavenc();
  GeneratedDateTimeColumn _constructFechavenc() {
    return GeneratedDateTimeColumn(
      'fechavenc',
      $tableName,
      false,
    );
  }

  final VerificationMeta _montoMeta = const VerificationMeta('monto');
  GeneratedRealColumn _monto;
  @override
  GeneratedRealColumn get monto => _monto ??= _constructMonto();
  GeneratedRealColumn _constructMonto() {
    return GeneratedRealColumn(
      'monto',
      $tableName,
      false,
    );
  }

  final VerificationMeta _capitalMeta = const VerificationMeta('capital');
  GeneratedRealColumn _capital;
  @override
  GeneratedRealColumn get capital => _capital ??= _constructCapital();
  GeneratedRealColumn _constructCapital() {
    return GeneratedRealColumn(
      'capital',
      $tableName,
      false,
    );
  }

  final VerificationMeta _interesMeta = const VerificationMeta('interes');
  GeneratedRealColumn _interes;
  @override
  GeneratedRealColumn get interes => _interes ??= _constructInteres();
  GeneratedRealColumn _constructInteres() {
    return GeneratedRealColumn(
      'interes',
      $tableName,
      false,
    );
  }

  final VerificationMeta _comisionMeta = const VerificationMeta('comision');
  GeneratedRealColumn _comision;
  @override
  GeneratedRealColumn get comision => _comision ??= _constructComision();
  GeneratedRealColumn _constructComision() {
    return GeneratedRealColumn(
      'comision',
      $tableName,
      false,
    );
  }

  final VerificationMeta _moraMeta = const VerificationMeta('mora');
  GeneratedRealColumn _mora;
  @override
  GeneratedRealColumn get mora => _mora ??= _constructMora();
  GeneratedRealColumn _constructMora() {
    return GeneratedRealColumn(
      'mora',
      $tableName,
      false,
    );
  }

  final VerificationMeta _balanceMeta = const VerificationMeta('balance');
  GeneratedRealColumn _balance;
  @override
  GeneratedRealColumn get balance => _balance ??= _constructBalance();
  GeneratedRealColumn _constructBalance() {
    return GeneratedRealColumn(
      'balance',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        prestamoid,
        idpagare,
        pagare,
        fechavenc,
        monto,
        capital,
        interes,
        comision,
        mora,
        balance
      ];
  @override
  $PagaresTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'pagares';
  @override
  final String actualTableName = 'pagares';
  @override
  VerificationContext validateIntegrity(PagaresCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.prestamoid.present) {
      context.handle(_prestamoidMeta,
          prestamoid.isAcceptableValue(d.prestamoid.value, _prestamoidMeta));
    } else if (prestamoid.isRequired && isInserting) {
      context.missing(_prestamoidMeta);
    }
    if (d.idpagare.present) {
      context.handle(_idpagareMeta,
          idpagare.isAcceptableValue(d.idpagare.value, _idpagareMeta));
    } else if (idpagare.isRequired && isInserting) {
      context.missing(_idpagareMeta);
    }
    if (d.pagare.present) {
      context.handle(
          _pagareMeta, pagare.isAcceptableValue(d.pagare.value, _pagareMeta));
    } else if (pagare.isRequired && isInserting) {
      context.missing(_pagareMeta);
    }
    if (d.fechavenc.present) {
      context.handle(_fechavencMeta,
          fechavenc.isAcceptableValue(d.fechavenc.value, _fechavencMeta));
    } else if (fechavenc.isRequired && isInserting) {
      context.missing(_fechavencMeta);
    }
    if (d.monto.present) {
      context.handle(
          _montoMeta, monto.isAcceptableValue(d.monto.value, _montoMeta));
    } else if (monto.isRequired && isInserting) {
      context.missing(_montoMeta);
    }
    if (d.capital.present) {
      context.handle(_capitalMeta,
          capital.isAcceptableValue(d.capital.value, _capitalMeta));
    } else if (capital.isRequired && isInserting) {
      context.missing(_capitalMeta);
    }
    if (d.interes.present) {
      context.handle(_interesMeta,
          interes.isAcceptableValue(d.interes.value, _interesMeta));
    } else if (interes.isRequired && isInserting) {
      context.missing(_interesMeta);
    }
    if (d.comision.present) {
      context.handle(_comisionMeta,
          comision.isAcceptableValue(d.comision.value, _comisionMeta));
    } else if (comision.isRequired && isInserting) {
      context.missing(_comisionMeta);
    }
    if (d.mora.present) {
      context.handle(
          _moraMeta, mora.isAcceptableValue(d.mora.value, _moraMeta));
    } else if (mora.isRequired && isInserting) {
      context.missing(_moraMeta);
    }
    if (d.balance.present) {
      context.handle(_balanceMeta,
          balance.isAcceptableValue(d.balance.value, _balanceMeta));
    } else if (balance.isRequired && isInserting) {
      context.missing(_balanceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idpagare};
  @override
  Pagare map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Pagare.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PagaresCompanion d) {
    final map = <String, Variable>{};
    if (d.prestamoid.present) {
      map['prestamoid'] = Variable<String, StringType>(d.prestamoid.value);
    }
    if (d.idpagare.present) {
      map['idpagare'] = Variable<int, IntType>(d.idpagare.value);
    }
    if (d.pagare.present) {
      map['pagare'] = Variable<int, IntType>(d.pagare.value);
    }
    if (d.fechavenc.present) {
      map['fechavenc'] = Variable<DateTime, DateTimeType>(d.fechavenc.value);
    }
    if (d.monto.present) {
      map['monto'] = Variable<double, RealType>(d.monto.value);
    }
    if (d.capital.present) {
      map['capital'] = Variable<double, RealType>(d.capital.value);
    }
    if (d.interes.present) {
      map['interes'] = Variable<double, RealType>(d.interes.value);
    }
    if (d.comision.present) {
      map['comision'] = Variable<double, RealType>(d.comision.value);
    }
    if (d.mora.present) {
      map['mora'] = Variable<double, RealType>(d.mora.value);
    }
    if (d.balance.present) {
      map['balance'] = Variable<double, RealType>(d.balance.value);
    }
    return map;
  }

  @override
  $PagaresTable createAlias(String alias) {
    return $PagaresTable(_db, alias);
  }
}

class Prestamo extends DataClass implements Insertable<Prestamo> {
  final String prestamoid;
  final int idprestamo;
  final int idcliente;
  final DateTime fecha;
  final double monto;
  final double balance;
  final int duracion;
  final double cuota;
  final String formapago;
  final String nombre;
  final String direccion;
  final String cedula;
  final String telefono;
  final String sexo;
  final int cobradorid;
  final int cuotasvenc;
  final double montovencido;
  final int ultimacuota;
  final double balancecuota;
  final double mora;
  final bool ladob;
  final bool cobrado;
  Prestamo(
      {@required this.prestamoid,
      @required this.idprestamo,
      @required this.idcliente,
      @required this.fecha,
      @required this.monto,
      @required this.balance,
      @required this.duracion,
      @required this.cuota,
      @required this.formapago,
      @required this.nombre,
      @required this.direccion,
      @required this.cedula,
      @required this.telefono,
      @required this.sexo,
      @required this.cobradorid,
      @required this.cuotasvenc,
      @required this.montovencido,
      @required this.ultimacuota,
      @required this.balancecuota,
      @required this.mora,
      @required this.ladob,
      @required this.cobrado});
  factory Prestamo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final doubleType = db.typeSystem.forDartType<double>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Prestamo(
      prestamoid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}prestamoid']),
      idprestamo:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}idprestamo']),
      idcliente:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}idcliente']),
      fecha:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}fecha']),
      monto:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}monto']),
      balance:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}balance']),
      duracion:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}duracion']),
      cuota:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}cuota']),
      formapago: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}formapago']),
      nombre:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}nombre']),
      direccion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}direccion']),
      cedula:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}cedula']),
      telefono: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}telefono']),
      sexo: stringType.mapFromDatabaseResponse(data['${effectivePrefix}sexo']),
      cobradorid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}cobradorid']),
      cuotasvenc:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}cuotasvenc']),
      montovencido: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}montovencido']),
      ultimacuota: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}ultimacuota']),
      balancecuota: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}balancecuota']),
      mora: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}mora']),
      ladob: boolType.mapFromDatabaseResponse(data['${effectivePrefix}ladob']),
      cobrado:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}cobrado']),
    );
  }
  factory Prestamo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Prestamo(
      prestamoid: serializer.fromJson<String>(json['prestamoid']),
      idprestamo: serializer.fromJson<int>(json['idprestamo']),
      idcliente: serializer.fromJson<int>(json['idcliente']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      monto: serializer.fromJson<double>(json['monto']),
      balance: serializer.fromJson<double>(json['balance']),
      duracion: serializer.fromJson<int>(json['duracion']),
      cuota: serializer.fromJson<double>(json['cuota']),
      formapago: serializer.fromJson<String>(json['formapago']),
      nombre: serializer.fromJson<String>(json['nombre']),
      direccion: serializer.fromJson<String>(json['direccion']),
      cedula: serializer.fromJson<String>(json['cedula']),
      telefono: serializer.fromJson<String>(json['telefono']),
      sexo: serializer.fromJson<String>(json['sexo']),
      cobradorid: serializer.fromJson<int>(json['cobradorid']),
      cuotasvenc: serializer.fromJson<int>(json['cuotasvenc']),
      montovencido: serializer.fromJson<double>(json['montovencido']),
      ultimacuota: serializer.fromJson<int>(json['ultimacuota']),
      balancecuota: serializer.fromJson<double>(json['balancecuota']),
      mora: serializer.fromJson<double>(json['mora']),
      ladob: serializer.fromJson<bool>(json['ladob']),
      cobrado: serializer.fromJson<bool>(json['cobrado']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'prestamoid': serializer.toJson<String>(prestamoid),
      'idprestamo': serializer.toJson<int>(idprestamo),
      'idcliente': serializer.toJson<int>(idcliente),
      'fecha': serializer.toJson<DateTime>(fecha),
      'monto': serializer.toJson<double>(monto),
      'balance': serializer.toJson<double>(balance),
      'duracion': serializer.toJson<int>(duracion),
      'cuota': serializer.toJson<double>(cuota),
      'formapago': serializer.toJson<String>(formapago),
      'nombre': serializer.toJson<String>(nombre),
      'direccion': serializer.toJson<String>(direccion),
      'cedula': serializer.toJson<String>(cedula),
      'telefono': serializer.toJson<String>(telefono),
      'sexo': serializer.toJson<String>(sexo),
      'cobradorid': serializer.toJson<int>(cobradorid),
      'cuotasvenc': serializer.toJson<int>(cuotasvenc),
      'montovencido': serializer.toJson<double>(montovencido),
      'ultimacuota': serializer.toJson<int>(ultimacuota),
      'balancecuota': serializer.toJson<double>(balancecuota),
      'mora': serializer.toJson<double>(mora),
      'ladob': serializer.toJson<bool>(ladob),
      'cobrado': serializer.toJson<bool>(cobrado),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Prestamo>>(bool nullToAbsent) {
    return PrestamosCompanion(
      prestamoid: prestamoid == null && nullToAbsent
          ? const Value.absent()
          : Value(prestamoid),
      idprestamo: idprestamo == null && nullToAbsent
          ? const Value.absent()
          : Value(idprestamo),
      idcliente: idcliente == null && nullToAbsent
          ? const Value.absent()
          : Value(idcliente),
      fecha:
          fecha == null && nullToAbsent ? const Value.absent() : Value(fecha),
      monto:
          monto == null && nullToAbsent ? const Value.absent() : Value(monto),
      balance: balance == null && nullToAbsent
          ? const Value.absent()
          : Value(balance),
      duracion: duracion == null && nullToAbsent
          ? const Value.absent()
          : Value(duracion),
      cuota:
          cuota == null && nullToAbsent ? const Value.absent() : Value(cuota),
      formapago: formapago == null && nullToAbsent
          ? const Value.absent()
          : Value(formapago),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      direccion: direccion == null && nullToAbsent
          ? const Value.absent()
          : Value(direccion),
      cedula:
          cedula == null && nullToAbsent ? const Value.absent() : Value(cedula),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      sexo: sexo == null && nullToAbsent ? const Value.absent() : Value(sexo),
      cobradorid: cobradorid == null && nullToAbsent
          ? const Value.absent()
          : Value(cobradorid),
      cuotasvenc: cuotasvenc == null && nullToAbsent
          ? const Value.absent()
          : Value(cuotasvenc),
      montovencido: montovencido == null && nullToAbsent
          ? const Value.absent()
          : Value(montovencido),
      ultimacuota: ultimacuota == null && nullToAbsent
          ? const Value.absent()
          : Value(ultimacuota),
      balancecuota: balancecuota == null && nullToAbsent
          ? const Value.absent()
          : Value(balancecuota),
      mora: mora == null && nullToAbsent ? const Value.absent() : Value(mora),
      ladob:
          ladob == null && nullToAbsent ? const Value.absent() : Value(ladob),
      cobrado: cobrado == null && nullToAbsent
          ? const Value.absent()
          : Value(cobrado),
    ) as T;
  }

  Prestamo copyWith(
          {String prestamoid,
          int idprestamo,
          int idcliente,
          DateTime fecha,
          double monto,
          double balance,
          int duracion,
          double cuota,
          String formapago,
          String nombre,
          String direccion,
          String cedula,
          String telefono,
          String sexo,
          int cobradorid,
          int cuotasvenc,
          double montovencido,
          int ultimacuota,
          double balancecuota,
          double mora,
          bool ladob,
          bool cobrado}) =>
      Prestamo(
        prestamoid: prestamoid ?? this.prestamoid,
        idprestamo: idprestamo ?? this.idprestamo,
        idcliente: idcliente ?? this.idcliente,
        fecha: fecha ?? this.fecha,
        monto: monto ?? this.monto,
        balance: balance ?? this.balance,
        duracion: duracion ?? this.duracion,
        cuota: cuota ?? this.cuota,
        formapago: formapago ?? this.formapago,
        nombre: nombre ?? this.nombre,
        direccion: direccion ?? this.direccion,
        cedula: cedula ?? this.cedula,
        telefono: telefono ?? this.telefono,
        sexo: sexo ?? this.sexo,
        cobradorid: cobradorid ?? this.cobradorid,
        cuotasvenc: cuotasvenc ?? this.cuotasvenc,
        montovencido: montovencido ?? this.montovencido,
        ultimacuota: ultimacuota ?? this.ultimacuota,
        balancecuota: balancecuota ?? this.balancecuota,
        mora: mora ?? this.mora,
        ladob: ladob ?? this.ladob,
        cobrado: cobrado ?? this.cobrado,
      );
  @override
  String toString() {
    return (StringBuffer('Prestamo(')
          ..write('prestamoid: $prestamoid, ')
          ..write('idprestamo: $idprestamo, ')
          ..write('idcliente: $idcliente, ')
          ..write('fecha: $fecha, ')
          ..write('monto: $monto, ')
          ..write('balance: $balance, ')
          ..write('duracion: $duracion, ')
          ..write('cuota: $cuota, ')
          ..write('formapago: $formapago, ')
          ..write('nombre: $nombre, ')
          ..write('direccion: $direccion, ')
          ..write('cedula: $cedula, ')
          ..write('telefono: $telefono, ')
          ..write('sexo: $sexo, ')
          ..write('cobradorid: $cobradorid, ')
          ..write('cuotasvenc: $cuotasvenc, ')
          ..write('montovencido: $montovencido, ')
          ..write('ultimacuota: $ultimacuota, ')
          ..write('balancecuota: $balancecuota, ')
          ..write('mora: $mora, ')
          ..write('ladob: $ladob, ')
          ..write('cobrado: $cobrado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc(
                  $mrjc(
                      $mrjc(
                          $mrjc(
                              $mrjc(
                                  $mrjc(
                                      $mrjc(
                                          $mrjc(
                                              $mrjc(
                                                  $mrjc(
                                                      $mrjc(
                                                          $mrjc(
                                                              $mrjc(
                                                                  $mrjc(
                                                                      $mrjc(
                                                                          $mrjc(
                                                                              $mrjc($mrjc($mrjc(0, prestamoid.hashCode), idprestamo.hashCode), idcliente.hashCode),
                                                                              fecha.hashCode),
                                                                          monto.hashCode),
                                                                      balance.hashCode),
                                                                  duracion.hashCode),
                                                              cuota.hashCode),
                                                          formapago.hashCode),
                                                      nombre.hashCode),
                                                  direccion.hashCode),
                                              cedula.hashCode),
                                          telefono.hashCode),
                                      sexo.hashCode),
                                  cobradorid.hashCode),
                              cuotasvenc.hashCode),
                          montovencido.hashCode),
                      ultimacuota.hashCode),
                  balancecuota.hashCode),
              mora.hashCode),
          ladob.hashCode),
      cobrado.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Prestamo &&
          other.prestamoid == prestamoid &&
          other.idprestamo == idprestamo &&
          other.idcliente == idcliente &&
          other.fecha == fecha &&
          other.monto == monto &&
          other.balance == balance &&
          other.duracion == duracion &&
          other.cuota == cuota &&
          other.formapago == formapago &&
          other.nombre == nombre &&
          other.direccion == direccion &&
          other.cedula == cedula &&
          other.telefono == telefono &&
          other.sexo == sexo &&
          other.cobradorid == cobradorid &&
          other.cuotasvenc == cuotasvenc &&
          other.montovencido == montovencido &&
          other.ultimacuota == ultimacuota &&
          other.balancecuota == balancecuota &&
          other.mora == mora &&
          other.ladob == ladob &&
          other.cobrado == cobrado);
}

class PrestamosCompanion extends UpdateCompanion<Prestamo> {
  final Value<String> prestamoid;
  final Value<int> idprestamo;
  final Value<int> idcliente;
  final Value<DateTime> fecha;
  final Value<double> monto;
  final Value<double> balance;
  final Value<int> duracion;
  final Value<double> cuota;
  final Value<String> formapago;
  final Value<String> nombre;
  final Value<String> direccion;
  final Value<String> cedula;
  final Value<String> telefono;
  final Value<String> sexo;
  final Value<int> cobradorid;
  final Value<int> cuotasvenc;
  final Value<double> montovencido;
  final Value<int> ultimacuota;
  final Value<double> balancecuota;
  final Value<double> mora;
  final Value<bool> ladob;
  final Value<bool> cobrado;
  const PrestamosCompanion({
    this.prestamoid = const Value.absent(),
    this.idprestamo = const Value.absent(),
    this.idcliente = const Value.absent(),
    this.fecha = const Value.absent(),
    this.monto = const Value.absent(),
    this.balance = const Value.absent(),
    this.duracion = const Value.absent(),
    this.cuota = const Value.absent(),
    this.formapago = const Value.absent(),
    this.nombre = const Value.absent(),
    this.direccion = const Value.absent(),
    this.cedula = const Value.absent(),
    this.telefono = const Value.absent(),
    this.sexo = const Value.absent(),
    this.cobradorid = const Value.absent(),
    this.cuotasvenc = const Value.absent(),
    this.montovencido = const Value.absent(),
    this.ultimacuota = const Value.absent(),
    this.balancecuota = const Value.absent(),
    this.mora = const Value.absent(),
    this.ladob = const Value.absent(),
    this.cobrado = const Value.absent(),
  });
}

class $PrestamosTable extends Prestamos
    with TableInfo<$PrestamosTable, Prestamo> {
  final GeneratedDatabase _db;
  final String _alias;
  $PrestamosTable(this._db, [this._alias]);
  final VerificationMeta _prestamoidMeta = const VerificationMeta('prestamoid');
  GeneratedTextColumn _prestamoid;
  @override
  GeneratedTextColumn get prestamoid => _prestamoid ??= _constructPrestamoid();
  GeneratedTextColumn _constructPrestamoid() {
    return GeneratedTextColumn('prestamoid', $tableName, false,
        maxTextLength: 15);
  }

  final VerificationMeta _idprestamoMeta = const VerificationMeta('idprestamo');
  GeneratedIntColumn _idprestamo;
  @override
  GeneratedIntColumn get idprestamo => _idprestamo ??= _constructIdprestamo();
  GeneratedIntColumn _constructIdprestamo() {
    return GeneratedIntColumn(
      'idprestamo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idclienteMeta = const VerificationMeta('idcliente');
  GeneratedIntColumn _idcliente;
  @override
  GeneratedIntColumn get idcliente => _idcliente ??= _constructIdcliente();
  GeneratedIntColumn _constructIdcliente() {
    return GeneratedIntColumn(
      'idcliente',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  GeneratedDateTimeColumn _fecha;
  @override
  GeneratedDateTimeColumn get fecha => _fecha ??= _constructFecha();
  GeneratedDateTimeColumn _constructFecha() {
    return GeneratedDateTimeColumn(
      'fecha',
      $tableName,
      false,
    );
  }

  final VerificationMeta _montoMeta = const VerificationMeta('monto');
  GeneratedRealColumn _monto;
  @override
  GeneratedRealColumn get monto => _monto ??= _constructMonto();
  GeneratedRealColumn _constructMonto() {
    return GeneratedRealColumn(
      'monto',
      $tableName,
      false,
    );
  }

  final VerificationMeta _balanceMeta = const VerificationMeta('balance');
  GeneratedRealColumn _balance;
  @override
  GeneratedRealColumn get balance => _balance ??= _constructBalance();
  GeneratedRealColumn _constructBalance() {
    return GeneratedRealColumn(
      'balance',
      $tableName,
      false,
    );
  }

  final VerificationMeta _duracionMeta = const VerificationMeta('duracion');
  GeneratedIntColumn _duracion;
  @override
  GeneratedIntColumn get duracion => _duracion ??= _constructDuracion();
  GeneratedIntColumn _constructDuracion() {
    return GeneratedIntColumn(
      'duracion',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cuotaMeta = const VerificationMeta('cuota');
  GeneratedRealColumn _cuota;
  @override
  GeneratedRealColumn get cuota => _cuota ??= _constructCuota();
  GeneratedRealColumn _constructCuota() {
    return GeneratedRealColumn(
      'cuota',
      $tableName,
      false,
    );
  }

  final VerificationMeta _formapagoMeta = const VerificationMeta('formapago');
  GeneratedTextColumn _formapago;
  @override
  GeneratedTextColumn get formapago => _formapago ??= _constructFormapago();
  GeneratedTextColumn _constructFormapago() {
    return GeneratedTextColumn('formapago', $tableName, false,
        maxTextLength: 30);
  }

  final VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  GeneratedTextColumn _nombre;
  @override
  GeneratedTextColumn get nombre => _nombre ??= _constructNombre();
  GeneratedTextColumn _constructNombre() {
    return GeneratedTextColumn('nombre', $tableName, false, maxTextLength: 300);
  }

  final VerificationMeta _direccionMeta = const VerificationMeta('direccion');
  GeneratedTextColumn _direccion;
  @override
  GeneratedTextColumn get direccion => _direccion ??= _constructDireccion();
  GeneratedTextColumn _constructDireccion() {
    return GeneratedTextColumn('direccion', $tableName, false,
        maxTextLength: 600);
  }

  final VerificationMeta _cedulaMeta = const VerificationMeta('cedula');
  GeneratedTextColumn _cedula;
  @override
  GeneratedTextColumn get cedula => _cedula ??= _constructCedula();
  GeneratedTextColumn _constructCedula() {
    return GeneratedTextColumn('cedula', $tableName, false, maxTextLength: 20);
  }

  final VerificationMeta _telefonoMeta = const VerificationMeta('telefono');
  GeneratedTextColumn _telefono;
  @override
  GeneratedTextColumn get telefono => _telefono ??= _constructTelefono();
  GeneratedTextColumn _constructTelefono() {
    return GeneratedTextColumn('telefono', $tableName, false,
        maxTextLength: 30);
  }

  final VerificationMeta _sexoMeta = const VerificationMeta('sexo');
  GeneratedTextColumn _sexo;
  @override
  GeneratedTextColumn get sexo => _sexo ??= _constructSexo();
  GeneratedTextColumn _constructSexo() {
    return GeneratedTextColumn('sexo', $tableName, false, maxTextLength: 30);
  }

  final VerificationMeta _cobradoridMeta = const VerificationMeta('cobradorid');
  GeneratedIntColumn _cobradorid;
  @override
  GeneratedIntColumn get cobradorid => _cobradorid ??= _constructCobradorid();
  GeneratedIntColumn _constructCobradorid() {
    return GeneratedIntColumn(
      'cobradorid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cuotasvencMeta = const VerificationMeta('cuotasvenc');
  GeneratedIntColumn _cuotasvenc;
  @override
  GeneratedIntColumn get cuotasvenc => _cuotasvenc ??= _constructCuotasvenc();
  GeneratedIntColumn _constructCuotasvenc() {
    return GeneratedIntColumn(
      'cuotasvenc',
      $tableName,
      false,
    );
  }

  final VerificationMeta _montovencidoMeta =
      const VerificationMeta('montovencido');
  GeneratedRealColumn _montovencido;
  @override
  GeneratedRealColumn get montovencido =>
      _montovencido ??= _constructMontovencido();
  GeneratedRealColumn _constructMontovencido() {
    return GeneratedRealColumn(
      'montovencido',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ultimacuotaMeta =
      const VerificationMeta('ultimacuota');
  GeneratedIntColumn _ultimacuota;
  @override
  GeneratedIntColumn get ultimacuota =>
      _ultimacuota ??= _constructUltimacuota();
  GeneratedIntColumn _constructUltimacuota() {
    return GeneratedIntColumn(
      'ultimacuota',
      $tableName,
      false,
    );
  }

  final VerificationMeta _balancecuotaMeta =
      const VerificationMeta('balancecuota');
  GeneratedRealColumn _balancecuota;
  @override
  GeneratedRealColumn get balancecuota =>
      _balancecuota ??= _constructBalancecuota();
  GeneratedRealColumn _constructBalancecuota() {
    return GeneratedRealColumn(
      'balancecuota',
      $tableName,
      false,
    );
  }

  final VerificationMeta _moraMeta = const VerificationMeta('mora');
  GeneratedRealColumn _mora;
  @override
  GeneratedRealColumn get mora => _mora ??= _constructMora();
  GeneratedRealColumn _constructMora() {
    return GeneratedRealColumn(
      'mora',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ladobMeta = const VerificationMeta('ladob');
  GeneratedBoolColumn _ladob;
  @override
  GeneratedBoolColumn get ladob => _ladob ??= _constructLadob();
  GeneratedBoolColumn _constructLadob() {
    return GeneratedBoolColumn(
      'ladob',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cobradoMeta = const VerificationMeta('cobrado');
  GeneratedBoolColumn _cobrado;
  @override
  GeneratedBoolColumn get cobrado => _cobrado ??= _constructCobrado();
  GeneratedBoolColumn _constructCobrado() {
    return GeneratedBoolColumn(
      'cobrado',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        prestamoid,
        idprestamo,
        idcliente,
        fecha,
        monto,
        balance,
        duracion,
        cuota,
        formapago,
        nombre,
        direccion,
        cedula,
        telefono,
        sexo,
        cobradorid,
        cuotasvenc,
        montovencido,
        ultimacuota,
        balancecuota,
        mora,
        ladob,
        cobrado
      ];
  @override
  $PrestamosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'prestamos';
  @override
  final String actualTableName = 'prestamos';
  @override
  VerificationContext validateIntegrity(PrestamosCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.prestamoid.present) {
      context.handle(_prestamoidMeta,
          prestamoid.isAcceptableValue(d.prestamoid.value, _prestamoidMeta));
    } else if (prestamoid.isRequired && isInserting) {
      context.missing(_prestamoidMeta);
    }
    if (d.idprestamo.present) {
      context.handle(_idprestamoMeta,
          idprestamo.isAcceptableValue(d.idprestamo.value, _idprestamoMeta));
    } else if (idprestamo.isRequired && isInserting) {
      context.missing(_idprestamoMeta);
    }
    if (d.idcliente.present) {
      context.handle(_idclienteMeta,
          idcliente.isAcceptableValue(d.idcliente.value, _idclienteMeta));
    } else if (idcliente.isRequired && isInserting) {
      context.missing(_idclienteMeta);
    }
    if (d.fecha.present) {
      context.handle(
          _fechaMeta, fecha.isAcceptableValue(d.fecha.value, _fechaMeta));
    } else if (fecha.isRequired && isInserting) {
      context.missing(_fechaMeta);
    }
    if (d.monto.present) {
      context.handle(
          _montoMeta, monto.isAcceptableValue(d.monto.value, _montoMeta));
    } else if (monto.isRequired && isInserting) {
      context.missing(_montoMeta);
    }
    if (d.balance.present) {
      context.handle(_balanceMeta,
          balance.isAcceptableValue(d.balance.value, _balanceMeta));
    } else if (balance.isRequired && isInserting) {
      context.missing(_balanceMeta);
    }
    if (d.duracion.present) {
      context.handle(_duracionMeta,
          duracion.isAcceptableValue(d.duracion.value, _duracionMeta));
    } else if (duracion.isRequired && isInserting) {
      context.missing(_duracionMeta);
    }
    if (d.cuota.present) {
      context.handle(
          _cuotaMeta, cuota.isAcceptableValue(d.cuota.value, _cuotaMeta));
    } else if (cuota.isRequired && isInserting) {
      context.missing(_cuotaMeta);
    }
    if (d.formapago.present) {
      context.handle(_formapagoMeta,
          formapago.isAcceptableValue(d.formapago.value, _formapagoMeta));
    } else if (formapago.isRequired && isInserting) {
      context.missing(_formapagoMeta);
    }
    if (d.nombre.present) {
      context.handle(
          _nombreMeta, nombre.isAcceptableValue(d.nombre.value, _nombreMeta));
    } else if (nombre.isRequired && isInserting) {
      context.missing(_nombreMeta);
    }
    if (d.direccion.present) {
      context.handle(_direccionMeta,
          direccion.isAcceptableValue(d.direccion.value, _direccionMeta));
    } else if (direccion.isRequired && isInserting) {
      context.missing(_direccionMeta);
    }
    if (d.cedula.present) {
      context.handle(
          _cedulaMeta, cedula.isAcceptableValue(d.cedula.value, _cedulaMeta));
    } else if (cedula.isRequired && isInserting) {
      context.missing(_cedulaMeta);
    }
    if (d.telefono.present) {
      context.handle(_telefonoMeta,
          telefono.isAcceptableValue(d.telefono.value, _telefonoMeta));
    } else if (telefono.isRequired && isInserting) {
      context.missing(_telefonoMeta);
    }
    if (d.sexo.present) {
      context.handle(
          _sexoMeta, sexo.isAcceptableValue(d.sexo.value, _sexoMeta));
    } else if (sexo.isRequired && isInserting) {
      context.missing(_sexoMeta);
    }
    if (d.cobradorid.present) {
      context.handle(_cobradoridMeta,
          cobradorid.isAcceptableValue(d.cobradorid.value, _cobradoridMeta));
    } else if (cobradorid.isRequired && isInserting) {
      context.missing(_cobradoridMeta);
    }
    if (d.cuotasvenc.present) {
      context.handle(_cuotasvencMeta,
          cuotasvenc.isAcceptableValue(d.cuotasvenc.value, _cuotasvencMeta));
    } else if (cuotasvenc.isRequired && isInserting) {
      context.missing(_cuotasvencMeta);
    }
    if (d.montovencido.present) {
      context.handle(
          _montovencidoMeta,
          montovencido.isAcceptableValue(
              d.montovencido.value, _montovencidoMeta));
    } else if (montovencido.isRequired && isInserting) {
      context.missing(_montovencidoMeta);
    }
    if (d.ultimacuota.present) {
      context.handle(_ultimacuotaMeta,
          ultimacuota.isAcceptableValue(d.ultimacuota.value, _ultimacuotaMeta));
    } else if (ultimacuota.isRequired && isInserting) {
      context.missing(_ultimacuotaMeta);
    }
    if (d.balancecuota.present) {
      context.handle(
          _balancecuotaMeta,
          balancecuota.isAcceptableValue(
              d.balancecuota.value, _balancecuotaMeta));
    } else if (balancecuota.isRequired && isInserting) {
      context.missing(_balancecuotaMeta);
    }
    if (d.mora.present) {
      context.handle(
          _moraMeta, mora.isAcceptableValue(d.mora.value, _moraMeta));
    } else if (mora.isRequired && isInserting) {
      context.missing(_moraMeta);
    }
    if (d.ladob.present) {
      context.handle(
          _ladobMeta, ladob.isAcceptableValue(d.ladob.value, _ladobMeta));
    } else if (ladob.isRequired && isInserting) {
      context.missing(_ladobMeta);
    }
    if (d.cobrado.present) {
      context.handle(_cobradoMeta,
          cobrado.isAcceptableValue(d.cobrado.value, _cobradoMeta));
    } else if (cobrado.isRequired && isInserting) {
      context.missing(_cobradoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {prestamoid};
  @override
  Prestamo map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Prestamo.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PrestamosCompanion d) {
    final map = <String, Variable>{};
    if (d.prestamoid.present) {
      map['prestamoid'] = Variable<String, StringType>(d.prestamoid.value);
    }
    if (d.idprestamo.present) {
      map['idprestamo'] = Variable<int, IntType>(d.idprestamo.value);
    }
    if (d.idcliente.present) {
      map['idcliente'] = Variable<int, IntType>(d.idcliente.value);
    }
    if (d.fecha.present) {
      map['fecha'] = Variable<DateTime, DateTimeType>(d.fecha.value);
    }
    if (d.monto.present) {
      map['monto'] = Variable<double, RealType>(d.monto.value);
    }
    if (d.balance.present) {
      map['balance'] = Variable<double, RealType>(d.balance.value);
    }
    if (d.duracion.present) {
      map['duracion'] = Variable<int, IntType>(d.duracion.value);
    }
    if (d.cuota.present) {
      map['cuota'] = Variable<double, RealType>(d.cuota.value);
    }
    if (d.formapago.present) {
      map['formapago'] = Variable<String, StringType>(d.formapago.value);
    }
    if (d.nombre.present) {
      map['nombre'] = Variable<String, StringType>(d.nombre.value);
    }
    if (d.direccion.present) {
      map['direccion'] = Variable<String, StringType>(d.direccion.value);
    }
    if (d.cedula.present) {
      map['cedula'] = Variable<String, StringType>(d.cedula.value);
    }
    if (d.telefono.present) {
      map['telefono'] = Variable<String, StringType>(d.telefono.value);
    }
    if (d.sexo.present) {
      map['sexo'] = Variable<String, StringType>(d.sexo.value);
    }
    if (d.cobradorid.present) {
      map['cobradorid'] = Variable<int, IntType>(d.cobradorid.value);
    }
    if (d.cuotasvenc.present) {
      map['cuotasvenc'] = Variable<int, IntType>(d.cuotasvenc.value);
    }
    if (d.montovencido.present) {
      map['montovencido'] = Variable<double, RealType>(d.montovencido.value);
    }
    if (d.ultimacuota.present) {
      map['ultimacuota'] = Variable<int, IntType>(d.ultimacuota.value);
    }
    if (d.balancecuota.present) {
      map['balancecuota'] = Variable<double, RealType>(d.balancecuota.value);
    }
    if (d.mora.present) {
      map['mora'] = Variable<double, RealType>(d.mora.value);
    }
    if (d.ladob.present) {
      map['ladob'] = Variable<bool, BoolType>(d.ladob.value);
    }
    if (d.cobrado.present) {
      map['cobrado'] = Variable<bool, BoolType>(d.cobrado.value);
    }
    return map;
  }

  @override
  $PrestamosTable createAlias(String alias) {
    return $PrestamosTable(_db, alias);
  }
}

class Recibo extends DataClass implements Insertable<Recibo> {
  final String serial;
  final String documento;
  final String prestamoid;
  final int idcliente;
  final DateTime fecha;
  final int idcobrador;
  final double monto;
  final double capital;
  final double interes;
  final double comision;
  final double mora;
  final int cuotasatrasadas;
  final String concepto;
  final bool efectivo;
  final bool sincronizado;
  final bool ladob;
  Recibo(
      {@required this.serial,
      @required this.documento,
      @required this.prestamoid,
      @required this.idcliente,
      @required this.fecha,
      @required this.idcobrador,
      @required this.monto,
      @required this.capital,
      @required this.interes,
      @required this.comision,
      @required this.mora,
      @required this.cuotasatrasadas,
      @required this.concepto,
      @required this.efectivo,
      @required this.sincronizado,
      @required this.ladob});
  factory Recibo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final doubleType = db.typeSystem.forDartType<double>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Recibo(
      serial:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}serial']),
      documento: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}documento']),
      prestamoid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}prestamoid']),
      idcliente:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}idcliente']),
      fecha:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}fecha']),
      idcobrador:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}idcobrador']),
      monto:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}monto']),
      capital:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}capital']),
      interes:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}interes']),
      comision: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}comision']),
      mora: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}mora']),
      cuotasatrasadas: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}cuotasatrasadas']),
      concepto: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}concepto']),
      efectivo:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}efectivo']),
      sincronizado: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}sincronizado']),
      ladob: boolType.mapFromDatabaseResponse(data['${effectivePrefix}ladob']),
    );
  }
  factory Recibo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Recibo(
      serial: serializer.fromJson<String>(json['serial']),
      documento: serializer.fromJson<String>(json['documento']),
      prestamoid: serializer.fromJson<String>(json['prestamoid']),
      idcliente: serializer.fromJson<int>(json['idcliente']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      idcobrador: serializer.fromJson<int>(json['idcobrador']),
      monto: serializer.fromJson<double>(json['monto']),
      capital: serializer.fromJson<double>(json['capital']),
      interes: serializer.fromJson<double>(json['interes']),
      comision: serializer.fromJson<double>(json['comision']),
      mora: serializer.fromJson<double>(json['mora']),
      cuotasatrasadas: serializer.fromJson<int>(json['cuotasatrasadas']),
      concepto: serializer.fromJson<String>(json['concepto']),
      efectivo: serializer.fromJson<bool>(json['efectivo']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      ladob: serializer.fromJson<bool>(json['ladob']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'serial': serializer.toJson<String>(serial),
      'documento': serializer.toJson<String>(documento),
      'prestamoid': serializer.toJson<String>(prestamoid),
      'idcliente': serializer.toJson<int>(idcliente),
      'fecha': serializer.toJson<DateTime>(fecha),
      'idcobrador': serializer.toJson<int>(idcobrador),
      'monto': serializer.toJson<double>(monto),
      'capital': serializer.toJson<double>(capital),
      'interes': serializer.toJson<double>(interes),
      'comision': serializer.toJson<double>(comision),
      'mora': serializer.toJson<double>(mora),
      'cuotasatrasadas': serializer.toJson<int>(cuotasatrasadas),
      'concepto': serializer.toJson<String>(concepto),
      'efectivo': serializer.toJson<bool>(efectivo),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'ladob': serializer.toJson<bool>(ladob),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Recibo>>(bool nullToAbsent) {
    return RecibosCompanion(
      serial:
          serial == null && nullToAbsent ? const Value.absent() : Value(serial),
      documento: documento == null && nullToAbsent
          ? const Value.absent()
          : Value(documento),
      prestamoid: prestamoid == null && nullToAbsent
          ? const Value.absent()
          : Value(prestamoid),
      idcliente: idcliente == null && nullToAbsent
          ? const Value.absent()
          : Value(idcliente),
      fecha:
          fecha == null && nullToAbsent ? const Value.absent() : Value(fecha),
      idcobrador: idcobrador == null && nullToAbsent
          ? const Value.absent()
          : Value(idcobrador),
      monto:
          monto == null && nullToAbsent ? const Value.absent() : Value(monto),
      capital: capital == null && nullToAbsent
          ? const Value.absent()
          : Value(capital),
      interes: interes == null && nullToAbsent
          ? const Value.absent()
          : Value(interes),
      comision: comision == null && nullToAbsent
          ? const Value.absent()
          : Value(comision),
      mora: mora == null && nullToAbsent ? const Value.absent() : Value(mora),
      cuotasatrasadas: cuotasatrasadas == null && nullToAbsent
          ? const Value.absent()
          : Value(cuotasatrasadas),
      concepto: concepto == null && nullToAbsent
          ? const Value.absent()
          : Value(concepto),
      efectivo: efectivo == null && nullToAbsent
          ? const Value.absent()
          : Value(efectivo),
      sincronizado: sincronizado == null && nullToAbsent
          ? const Value.absent()
          : Value(sincronizado),
      ladob:
          ladob == null && nullToAbsent ? const Value.absent() : Value(ladob),
    ) as T;
  }

  Recibo copyWith(
          {String serial,
          String documento,
          String prestamoid,
          int idcliente,
          DateTime fecha,
          int idcobrador,
          double monto,
          double capital,
          double interes,
          double comision,
          double mora,
          int cuotasatrasadas,
          String concepto,
          bool efectivo,
          bool sincronizado,
          bool ladob}) =>
      Recibo(
        serial: serial ?? this.serial,
        documento: documento ?? this.documento,
        prestamoid: prestamoid ?? this.prestamoid,
        idcliente: idcliente ?? this.idcliente,
        fecha: fecha ?? this.fecha,
        idcobrador: idcobrador ?? this.idcobrador,
        monto: monto ?? this.monto,
        capital: capital ?? this.capital,
        interes: interes ?? this.interes,
        comision: comision ?? this.comision,
        mora: mora ?? this.mora,
        cuotasatrasadas: cuotasatrasadas ?? this.cuotasatrasadas,
        concepto: concepto ?? this.concepto,
        efectivo: efectivo ?? this.efectivo,
        sincronizado: sincronizado ?? this.sincronizado,
        ladob: ladob ?? this.ladob,
      );
  @override
  String toString() {
    return (StringBuffer('Recibo(')
          ..write('serial: $serial, ')
          ..write('documento: $documento, ')
          ..write('prestamoid: $prestamoid, ')
          ..write('idcliente: $idcliente, ')
          ..write('fecha: $fecha, ')
          ..write('idcobrador: $idcobrador, ')
          ..write('monto: $monto, ')
          ..write('capital: $capital, ')
          ..write('interes: $interes, ')
          ..write('comision: $comision, ')
          ..write('mora: $mora, ')
          ..write('cuotasatrasadas: $cuotasatrasadas, ')
          ..write('concepto: $concepto, ')
          ..write('efectivo: $efectivo, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('ladob: $ladob')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc(
                  $mrjc(
                      $mrjc(
                          $mrjc(
                              $mrjc(
                                  $mrjc(
                                      $mrjc(
                                          $mrjc(
                                              $mrjc(
                                                  $mrjc(
                                                      $mrjc(
                                                          $mrjc(
                                                              $mrjc(
                                                                  0,
                                                                  serial
                                                                      .hashCode),
                                                              documento
                                                                  .hashCode),
                                                          prestamoid.hashCode),
                                                      idcliente.hashCode),
                                                  fecha.hashCode),
                                              idcobrador.hashCode),
                                          monto.hashCode),
                                      capital.hashCode),
                                  interes.hashCode),
                              comision.hashCode),
                          mora.hashCode),
                      cuotasatrasadas.hashCode),
                  concepto.hashCode),
              efectivo.hashCode),
          sincronizado.hashCode),
      ladob.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Recibo &&
          other.serial == serial &&
          other.documento == documento &&
          other.prestamoid == prestamoid &&
          other.idcliente == idcliente &&
          other.fecha == fecha &&
          other.idcobrador == idcobrador &&
          other.monto == monto &&
          other.capital == capital &&
          other.interes == interes &&
          other.comision == comision &&
          other.mora == mora &&
          other.cuotasatrasadas == cuotasatrasadas &&
          other.concepto == concepto &&
          other.efectivo == efectivo &&
          other.sincronizado == sincronizado &&
          other.ladob == ladob);
}

class RecibosCompanion extends UpdateCompanion<Recibo> {
  final Value<String> serial;
  final Value<String> documento;
  final Value<String> prestamoid;
  final Value<int> idcliente;
  final Value<DateTime> fecha;
  final Value<int> idcobrador;
  final Value<double> monto;
  final Value<double> capital;
  final Value<double> interes;
  final Value<double> comision;
  final Value<double> mora;
  final Value<int> cuotasatrasadas;
  final Value<String> concepto;
  final Value<bool> efectivo;
  final Value<bool> sincronizado;
  final Value<bool> ladob;
  const RecibosCompanion({
    this.serial = const Value.absent(),
    this.documento = const Value.absent(),
    this.prestamoid = const Value.absent(),
    this.idcliente = const Value.absent(),
    this.fecha = const Value.absent(),
    this.idcobrador = const Value.absent(),
    this.monto = const Value.absent(),
    this.capital = const Value.absent(),
    this.interes = const Value.absent(),
    this.comision = const Value.absent(),
    this.mora = const Value.absent(),
    this.cuotasatrasadas = const Value.absent(),
    this.concepto = const Value.absent(),
    this.efectivo = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.ladob = const Value.absent(),
  });
}

class $RecibosTable extends Recibos with TableInfo<$RecibosTable, Recibo> {
  final GeneratedDatabase _db;
  final String _alias;
  $RecibosTable(this._db, [this._alias]);
  final VerificationMeta _serialMeta = const VerificationMeta('serial');
  GeneratedTextColumn _serial;
  @override
  GeneratedTextColumn get serial => _serial ??= _constructSerial();
  GeneratedTextColumn _constructSerial() {
    return GeneratedTextColumn('serial', $tableName, false, maxTextLength: 100);
  }

  final VerificationMeta _documentoMeta = const VerificationMeta('documento');
  GeneratedTextColumn _documento;
  @override
  GeneratedTextColumn get documento => _documento ??= _constructDocumento();
  GeneratedTextColumn _constructDocumento() {
    return GeneratedTextColumn('documento', $tableName, false,
        maxTextLength: 15);
  }

  final VerificationMeta _prestamoidMeta = const VerificationMeta('prestamoid');
  GeneratedTextColumn _prestamoid;
  @override
  GeneratedTextColumn get prestamoid => _prestamoid ??= _constructPrestamoid();
  GeneratedTextColumn _constructPrestamoid() {
    return GeneratedTextColumn('prestamoid', $tableName, false,
        maxTextLength: 15);
  }

  final VerificationMeta _idclienteMeta = const VerificationMeta('idcliente');
  GeneratedIntColumn _idcliente;
  @override
  GeneratedIntColumn get idcliente => _idcliente ??= _constructIdcliente();
  GeneratedIntColumn _constructIdcliente() {
    return GeneratedIntColumn(
      'idcliente',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  GeneratedDateTimeColumn _fecha;
  @override
  GeneratedDateTimeColumn get fecha => _fecha ??= _constructFecha();
  GeneratedDateTimeColumn _constructFecha() {
    return GeneratedDateTimeColumn(
      'fecha',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idcobradorMeta = const VerificationMeta('idcobrador');
  GeneratedIntColumn _idcobrador;
  @override
  GeneratedIntColumn get idcobrador => _idcobrador ??= _constructIdcobrador();
  GeneratedIntColumn _constructIdcobrador() {
    return GeneratedIntColumn(
      'idcobrador',
      $tableName,
      false,
    );
  }

  final VerificationMeta _montoMeta = const VerificationMeta('monto');
  GeneratedRealColumn _monto;
  @override
  GeneratedRealColumn get monto => _monto ??= _constructMonto();
  GeneratedRealColumn _constructMonto() {
    return GeneratedRealColumn(
      'monto',
      $tableName,
      false,
    );
  }

  final VerificationMeta _capitalMeta = const VerificationMeta('capital');
  GeneratedRealColumn _capital;
  @override
  GeneratedRealColumn get capital => _capital ??= _constructCapital();
  GeneratedRealColumn _constructCapital() {
    return GeneratedRealColumn(
      'capital',
      $tableName,
      false,
    );
  }

  final VerificationMeta _interesMeta = const VerificationMeta('interes');
  GeneratedRealColumn _interes;
  @override
  GeneratedRealColumn get interes => _interes ??= _constructInteres();
  GeneratedRealColumn _constructInteres() {
    return GeneratedRealColumn(
      'interes',
      $tableName,
      false,
    );
  }

  final VerificationMeta _comisionMeta = const VerificationMeta('comision');
  GeneratedRealColumn _comision;
  @override
  GeneratedRealColumn get comision => _comision ??= _constructComision();
  GeneratedRealColumn _constructComision() {
    return GeneratedRealColumn(
      'comision',
      $tableName,
      false,
    );
  }

  final VerificationMeta _moraMeta = const VerificationMeta('mora');
  GeneratedRealColumn _mora;
  @override
  GeneratedRealColumn get mora => _mora ??= _constructMora();
  GeneratedRealColumn _constructMora() {
    return GeneratedRealColumn(
      'mora',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cuotasatrasadasMeta =
      const VerificationMeta('cuotasatrasadas');
  GeneratedIntColumn _cuotasatrasadas;
  @override
  GeneratedIntColumn get cuotasatrasadas =>
      _cuotasatrasadas ??= _constructCuotasatrasadas();
  GeneratedIntColumn _constructCuotasatrasadas() {
    return GeneratedIntColumn(
      'cuotasatrasadas',
      $tableName,
      false,
    );
  }

  final VerificationMeta _conceptoMeta = const VerificationMeta('concepto');
  GeneratedTextColumn _concepto;
  @override
  GeneratedTextColumn get concepto => _concepto ??= _constructConcepto();
  GeneratedTextColumn _constructConcepto() {
    return GeneratedTextColumn('concepto', $tableName, false,
        maxTextLength: 500);
  }

  final VerificationMeta _efectivoMeta = const VerificationMeta('efectivo');
  GeneratedBoolColumn _efectivo;
  @override
  GeneratedBoolColumn get efectivo => _efectivo ??= _constructEfectivo();
  GeneratedBoolColumn _constructEfectivo() {
    return GeneratedBoolColumn(
      'efectivo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  GeneratedBoolColumn _sincronizado;
  @override
  GeneratedBoolColumn get sincronizado =>
      _sincronizado ??= _constructSincronizado();
  GeneratedBoolColumn _constructSincronizado() {
    return GeneratedBoolColumn('sincronizado', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _ladobMeta = const VerificationMeta('ladob');
  GeneratedBoolColumn _ladob;
  @override
  GeneratedBoolColumn get ladob => _ladob ??= _constructLadob();
  GeneratedBoolColumn _constructLadob() {
    return GeneratedBoolColumn('ladob', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [
        serial,
        documento,
        prestamoid,
        idcliente,
        fecha,
        idcobrador,
        monto,
        capital,
        interes,
        comision,
        mora,
        cuotasatrasadas,
        concepto,
        efectivo,
        sincronizado,
        ladob
      ];
  @override
  $RecibosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'recibos';
  @override
  final String actualTableName = 'recibos';
  @override
  VerificationContext validateIntegrity(RecibosCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.serial.present) {
      context.handle(
          _serialMeta, serial.isAcceptableValue(d.serial.value, _serialMeta));
    } else if (serial.isRequired && isInserting) {
      context.missing(_serialMeta);
    }
    if (d.documento.present) {
      context.handle(_documentoMeta,
          documento.isAcceptableValue(d.documento.value, _documentoMeta));
    } else if (documento.isRequired && isInserting) {
      context.missing(_documentoMeta);
    }
    if (d.prestamoid.present) {
      context.handle(_prestamoidMeta,
          prestamoid.isAcceptableValue(d.prestamoid.value, _prestamoidMeta));
    } else if (prestamoid.isRequired && isInserting) {
      context.missing(_prestamoidMeta);
    }
    if (d.idcliente.present) {
      context.handle(_idclienteMeta,
          idcliente.isAcceptableValue(d.idcliente.value, _idclienteMeta));
    } else if (idcliente.isRequired && isInserting) {
      context.missing(_idclienteMeta);
    }
    if (d.fecha.present) {
      context.handle(
          _fechaMeta, fecha.isAcceptableValue(d.fecha.value, _fechaMeta));
    } else if (fecha.isRequired && isInserting) {
      context.missing(_fechaMeta);
    }
    if (d.idcobrador.present) {
      context.handle(_idcobradorMeta,
          idcobrador.isAcceptableValue(d.idcobrador.value, _idcobradorMeta));
    } else if (idcobrador.isRequired && isInserting) {
      context.missing(_idcobradorMeta);
    }
    if (d.monto.present) {
      context.handle(
          _montoMeta, monto.isAcceptableValue(d.monto.value, _montoMeta));
    } else if (monto.isRequired && isInserting) {
      context.missing(_montoMeta);
    }
    if (d.capital.present) {
      context.handle(_capitalMeta,
          capital.isAcceptableValue(d.capital.value, _capitalMeta));
    } else if (capital.isRequired && isInserting) {
      context.missing(_capitalMeta);
    }
    if (d.interes.present) {
      context.handle(_interesMeta,
          interes.isAcceptableValue(d.interes.value, _interesMeta));
    } else if (interes.isRequired && isInserting) {
      context.missing(_interesMeta);
    }
    if (d.comision.present) {
      context.handle(_comisionMeta,
          comision.isAcceptableValue(d.comision.value, _comisionMeta));
    } else if (comision.isRequired && isInserting) {
      context.missing(_comisionMeta);
    }
    if (d.mora.present) {
      context.handle(
          _moraMeta, mora.isAcceptableValue(d.mora.value, _moraMeta));
    } else if (mora.isRequired && isInserting) {
      context.missing(_moraMeta);
    }
    if (d.cuotasatrasadas.present) {
      context.handle(
          _cuotasatrasadasMeta,
          cuotasatrasadas.isAcceptableValue(
              d.cuotasatrasadas.value, _cuotasatrasadasMeta));
    } else if (cuotasatrasadas.isRequired && isInserting) {
      context.missing(_cuotasatrasadasMeta);
    }
    if (d.concepto.present) {
      context.handle(_conceptoMeta,
          concepto.isAcceptableValue(d.concepto.value, _conceptoMeta));
    } else if (concepto.isRequired && isInserting) {
      context.missing(_conceptoMeta);
    }
    if (d.efectivo.present) {
      context.handle(_efectivoMeta,
          efectivo.isAcceptableValue(d.efectivo.value, _efectivoMeta));
    } else if (efectivo.isRequired && isInserting) {
      context.missing(_efectivoMeta);
    }
    if (d.sincronizado.present) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableValue(
              d.sincronizado.value, _sincronizadoMeta));
    } else if (sincronizado.isRequired && isInserting) {
      context.missing(_sincronizadoMeta);
    }
    if (d.ladob.present) {
      context.handle(
          _ladobMeta, ladob.isAcceptableValue(d.ladob.value, _ladobMeta));
    } else if (ladob.isRequired && isInserting) {
      context.missing(_ladobMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serial};
  @override
  Recibo map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Recibo.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(RecibosCompanion d) {
    final map = <String, Variable>{};
    if (d.serial.present) {
      map['serial'] = Variable<String, StringType>(d.serial.value);
    }
    if (d.documento.present) {
      map['documento'] = Variable<String, StringType>(d.documento.value);
    }
    if (d.prestamoid.present) {
      map['prestamoid'] = Variable<String, StringType>(d.prestamoid.value);
    }
    if (d.idcliente.present) {
      map['idcliente'] = Variable<int, IntType>(d.idcliente.value);
    }
    if (d.fecha.present) {
      map['fecha'] = Variable<DateTime, DateTimeType>(d.fecha.value);
    }
    if (d.idcobrador.present) {
      map['idcobrador'] = Variable<int, IntType>(d.idcobrador.value);
    }
    if (d.monto.present) {
      map['monto'] = Variable<double, RealType>(d.monto.value);
    }
    if (d.capital.present) {
      map['capital'] = Variable<double, RealType>(d.capital.value);
    }
    if (d.interes.present) {
      map['interes'] = Variable<double, RealType>(d.interes.value);
    }
    if (d.comision.present) {
      map['comision'] = Variable<double, RealType>(d.comision.value);
    }
    if (d.mora.present) {
      map['mora'] = Variable<double, RealType>(d.mora.value);
    }
    if (d.cuotasatrasadas.present) {
      map['cuotasatrasadas'] = Variable<int, IntType>(d.cuotasatrasadas.value);
    }
    if (d.concepto.present) {
      map['concepto'] = Variable<String, StringType>(d.concepto.value);
    }
    if (d.efectivo.present) {
      map['efectivo'] = Variable<bool, BoolType>(d.efectivo.value);
    }
    if (d.sincronizado.present) {
      map['sincronizado'] = Variable<bool, BoolType>(d.sincronizado.value);
    }
    if (d.ladob.present) {
      map['ladob'] = Variable<bool, BoolType>(d.ladob.value);
    }
    return map;
  }

  @override
  $RecibosTable createAlias(String alias) {
    return $RecibosTable(_db, alias);
  }
}

class Secuencia extends DataClass implements Insertable<Secuencia> {
  final int id;
  final String tipodoc;
  final int secuencia;
  final int intervalo;
  final String descripcion;
  Secuencia(
      {@required this.id,
      @required this.tipodoc,
      @required this.secuencia,
      @required this.intervalo,
      @required this.descripcion});
  factory Secuencia.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Secuencia(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      tipodoc:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}tipodoc']),
      secuencia:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}secuencia']),
      intervalo:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}intervalo']),
      descripcion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}descripcion']),
    );
  }
  factory Secuencia.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Secuencia(
      id: serializer.fromJson<int>(json['id']),
      tipodoc: serializer.fromJson<String>(json['tipodoc']),
      secuencia: serializer.fromJson<int>(json['secuencia']),
      intervalo: serializer.fromJson<int>(json['intervalo']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'tipodoc': serializer.toJson<String>(tipodoc),
      'secuencia': serializer.toJson<int>(secuencia),
      'intervalo': serializer.toJson<int>(intervalo),
      'descripcion': serializer.toJson<String>(descripcion),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Secuencia>>(bool nullToAbsent) {
    return SecuenciasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      tipodoc: tipodoc == null && nullToAbsent
          ? const Value.absent()
          : Value(tipodoc),
      secuencia: secuencia == null && nullToAbsent
          ? const Value.absent()
          : Value(secuencia),
      intervalo: intervalo == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalo),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
    ) as T;
  }

  Secuencia copyWith(
          {int id,
          String tipodoc,
          int secuencia,
          int intervalo,
          String descripcion}) =>
      Secuencia(
        id: id ?? this.id,
        tipodoc: tipodoc ?? this.tipodoc,
        secuencia: secuencia ?? this.secuencia,
        intervalo: intervalo ?? this.intervalo,
        descripcion: descripcion ?? this.descripcion,
      );
  @override
  String toString() {
    return (StringBuffer('Secuencia(')
          ..write('id: $id, ')
          ..write('tipodoc: $tipodoc, ')
          ..write('secuencia: $secuencia, ')
          ..write('intervalo: $intervalo, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc($mrjc($mrjc(0, id.hashCode), tipodoc.hashCode),
              secuencia.hashCode),
          intervalo.hashCode),
      descripcion.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Secuencia &&
          other.id == id &&
          other.tipodoc == tipodoc &&
          other.secuencia == secuencia &&
          other.intervalo == intervalo &&
          other.descripcion == descripcion);
}

class SecuenciasCompanion extends UpdateCompanion<Secuencia> {
  final Value<int> id;
  final Value<String> tipodoc;
  final Value<int> secuencia;
  final Value<int> intervalo;
  final Value<String> descripcion;
  const SecuenciasCompanion({
    this.id = const Value.absent(),
    this.tipodoc = const Value.absent(),
    this.secuencia = const Value.absent(),
    this.intervalo = const Value.absent(),
    this.descripcion = const Value.absent(),
  });
}

class $SecuenciasTable extends Secuencias
    with TableInfo<$SecuenciasTable, Secuencia> {
  final GeneratedDatabase _db;
  final String _alias;
  $SecuenciasTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _tipodocMeta = const VerificationMeta('tipodoc');
  GeneratedTextColumn _tipodoc;
  @override
  GeneratedTextColumn get tipodoc => _tipodoc ??= _constructTipodoc();
  GeneratedTextColumn _constructTipodoc() {
    return GeneratedTextColumn('tipodoc', $tableName, false, maxTextLength: 30);
  }

  final VerificationMeta _secuenciaMeta = const VerificationMeta('secuencia');
  GeneratedIntColumn _secuencia;
  @override
  GeneratedIntColumn get secuencia => _secuencia ??= _constructSecuencia();
  GeneratedIntColumn _constructSecuencia() {
    return GeneratedIntColumn('secuencia', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _intervaloMeta = const VerificationMeta('intervalo');
  GeneratedIntColumn _intervalo;
  @override
  GeneratedIntColumn get intervalo => _intervalo ??= _constructIntervalo();
  GeneratedIntColumn _constructIntervalo() {
    return GeneratedIntColumn('intervalo', $tableName, false,
        defaultValue: Constant(1));
  }

  final VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  GeneratedTextColumn _descripcion;
  @override
  GeneratedTextColumn get descripcion =>
      _descripcion ??= _constructDescripcion();
  GeneratedTextColumn _constructDescripcion() {
    return GeneratedTextColumn('descripcion', $tableName, false,
        maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, tipodoc, secuencia, intervalo, descripcion];
  @override
  $SecuenciasTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'secuencias';
  @override
  final String actualTableName = 'secuencias';
  @override
  VerificationContext validateIntegrity(SecuenciasCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.tipodoc.present) {
      context.handle(_tipodocMeta,
          tipodoc.isAcceptableValue(d.tipodoc.value, _tipodocMeta));
    } else if (tipodoc.isRequired && isInserting) {
      context.missing(_tipodocMeta);
    }
    if (d.secuencia.present) {
      context.handle(_secuenciaMeta,
          secuencia.isAcceptableValue(d.secuencia.value, _secuenciaMeta));
    } else if (secuencia.isRequired && isInserting) {
      context.missing(_secuenciaMeta);
    }
    if (d.intervalo.present) {
      context.handle(_intervaloMeta,
          intervalo.isAcceptableValue(d.intervalo.value, _intervaloMeta));
    } else if (intervalo.isRequired && isInserting) {
      context.missing(_intervaloMeta);
    }
    if (d.descripcion.present) {
      context.handle(_descripcionMeta,
          descripcion.isAcceptableValue(d.descripcion.value, _descripcionMeta));
    } else if (descripcion.isRequired && isInserting) {
      context.missing(_descripcionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Secuencia map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Secuencia.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SecuenciasCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.tipodoc.present) {
      map['tipodoc'] = Variable<String, StringType>(d.tipodoc.value);
    }
    if (d.secuencia.present) {
      map['secuencia'] = Variable<int, IntType>(d.secuencia.value);
    }
    if (d.intervalo.present) {
      map['intervalo'] = Variable<int, IntType>(d.intervalo.value);
    }
    if (d.descripcion.present) {
      map['descripcion'] = Variable<String, StringType>(d.descripcion.value);
    }
    return map;
  }

  @override
  $SecuenciasTable createAlias(String alias) {
    return $SecuenciasTable(_db, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final int id;
  final String remoteurl;
  final String localurl;
  final String apiclient;
  final String apikey;
  final bool online;
  final bool internet;
  final int npopias;
  final int delaycopias;
  final String printername;
  final String printeraddres;
  Setting(
      {@required this.id,
      @required this.remoteurl,
      @required this.localurl,
      @required this.apiclient,
      @required this.apikey,
      @required this.online,
      @required this.internet,
      @required this.npopias,
      @required this.delaycopias,
      @required this.printername,
      @required this.printeraddres});
  factory Setting.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Setting(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      remoteurl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}remoteurl']),
      localurl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}localurl']),
      apiclient: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}apiclient']),
      apikey:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}apikey']),
      online:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}online']),
      internet:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}internet']),
      npopias:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}npopias']),
      delaycopias: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}delaycopias']),
      printername: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}printername']),
      printeraddres: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}printeraddres']),
    );
  }
  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Setting(
      id: serializer.fromJson<int>(json['id']),
      remoteurl: serializer.fromJson<String>(json['remoteurl']),
      localurl: serializer.fromJson<String>(json['localurl']),
      apiclient: serializer.fromJson<String>(json['apiclient']),
      apikey: serializer.fromJson<String>(json['apikey']),
      online: serializer.fromJson<bool>(json['online']),
      internet: serializer.fromJson<bool>(json['internet']),
      npopias: serializer.fromJson<int>(json['npopias']),
      delaycopias: serializer.fromJson<int>(json['delaycopias']),
      printername: serializer.fromJson<String>(json['printername']),
      printeraddres: serializer.fromJson<String>(json['printeraddres']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'remoteurl': serializer.toJson<String>(remoteurl),
      'localurl': serializer.toJson<String>(localurl),
      'apiclient': serializer.toJson<String>(apiclient),
      'apikey': serializer.toJson<String>(apikey),
      'online': serializer.toJson<bool>(online),
      'internet': serializer.toJson<bool>(internet),
      'npopias': serializer.toJson<int>(npopias),
      'delaycopias': serializer.toJson<int>(delaycopias),
      'printername': serializer.toJson<String>(printername),
      'printeraddres': serializer.toJson<String>(printeraddres),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Setting>>(bool nullToAbsent) {
    return SettingsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      remoteurl: remoteurl == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteurl),
      localurl: localurl == null && nullToAbsent
          ? const Value.absent()
          : Value(localurl),
      apiclient: apiclient == null && nullToAbsent
          ? const Value.absent()
          : Value(apiclient),
      apikey:
          apikey == null && nullToAbsent ? const Value.absent() : Value(apikey),
      online:
          online == null && nullToAbsent ? const Value.absent() : Value(online),
      internet: internet == null && nullToAbsent
          ? const Value.absent()
          : Value(internet),
      npopias: npopias == null && nullToAbsent
          ? const Value.absent()
          : Value(npopias),
      delaycopias: delaycopias == null && nullToAbsent
          ? const Value.absent()
          : Value(delaycopias),
      printername: printername == null && nullToAbsent
          ? const Value.absent()
          : Value(printername),
      printeraddres: printeraddres == null && nullToAbsent
          ? const Value.absent()
          : Value(printeraddres),
    ) as T;
  }

  Setting copyWith(
          {int id,
          String remoteurl,
          String localurl,
          String apiclient,
          String apikey,
          bool online,
          bool internet,
          int npopias,
          int delaycopias,
          String printername,
          String printeraddres}) =>
      Setting(
        id: id ?? this.id,
        remoteurl: remoteurl ?? this.remoteurl,
        localurl: localurl ?? this.localurl,
        apiclient: apiclient ?? this.apiclient,
        apikey: apikey ?? this.apikey,
        online: online ?? this.online,
        internet: internet ?? this.internet,
        npopias: npopias ?? this.npopias,
        delaycopias: delaycopias ?? this.delaycopias,
        printername: printername ?? this.printername,
        printeraddres: printeraddres ?? this.printeraddres,
      );
  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('remoteurl: $remoteurl, ')
          ..write('localurl: $localurl, ')
          ..write('apiclient: $apiclient, ')
          ..write('apikey: $apikey, ')
          ..write('online: $online, ')
          ..write('internet: $internet, ')
          ..write('npopias: $npopias, ')
          ..write('delaycopias: $delaycopias, ')
          ..write('printername: $printername, ')
          ..write('printeraddres: $printeraddres')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc(
                  $mrjc(
                      $mrjc(
                          $mrjc(
                              $mrjc(
                                  $mrjc(
                                      $mrjc($mrjc(0, id.hashCode),
                                          remoteurl.hashCode),
                                      localurl.hashCode),
                                  apiclient.hashCode),
                              apikey.hashCode),
                          online.hashCode),
                      internet.hashCode),
                  npopias.hashCode),
              delaycopias.hashCode),
          printername.hashCode),
      printeraddres.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == id &&
          other.remoteurl == remoteurl &&
          other.localurl == localurl &&
          other.apiclient == apiclient &&
          other.apikey == apikey &&
          other.online == online &&
          other.internet == internet &&
          other.npopias == npopias &&
          other.delaycopias == delaycopias &&
          other.printername == printername &&
          other.printeraddres == printeraddres);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<int> id;
  final Value<String> remoteurl;
  final Value<String> localurl;
  final Value<String> apiclient;
  final Value<String> apikey;
  final Value<bool> online;
  final Value<bool> internet;
  final Value<int> npopias;
  final Value<int> delaycopias;
  final Value<String> printername;
  final Value<String> printeraddres;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.remoteurl = const Value.absent(),
    this.localurl = const Value.absent(),
    this.apiclient = const Value.absent(),
    this.apikey = const Value.absent(),
    this.online = const Value.absent(),
    this.internet = const Value.absent(),
    this.npopias = const Value.absent(),
    this.delaycopias = const Value.absent(),
    this.printername = const Value.absent(),
    this.printeraddres = const Value.absent(),
  });
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  final GeneratedDatabase _db;
  final String _alias;
  $SettingsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        defaultValue: Constant(1));
  }

  final VerificationMeta _remoteurlMeta = const VerificationMeta('remoteurl');
  GeneratedTextColumn _remoteurl;
  @override
  GeneratedTextColumn get remoteurl => _remoteurl ??= _constructRemoteurl();
  GeneratedTextColumn _constructRemoteurl() {
    return GeneratedTextColumn('remoteurl', $tableName, false,
        maxTextLength: 50);
  }

  final VerificationMeta _localurlMeta = const VerificationMeta('localurl');
  GeneratedTextColumn _localurl;
  @override
  GeneratedTextColumn get localurl => _localurl ??= _constructLocalurl();
  GeneratedTextColumn _constructLocalurl() {
    return GeneratedTextColumn('localurl', $tableName, false,
        maxTextLength: 50);
  }

  final VerificationMeta _apiclientMeta = const VerificationMeta('apiclient');
  GeneratedTextColumn _apiclient;
  @override
  GeneratedTextColumn get apiclient => _apiclient ??= _constructApiclient();
  GeneratedTextColumn _constructApiclient() {
    return GeneratedTextColumn('apiclient', $tableName, false,
        maxTextLength: 10);
  }

  final VerificationMeta _apikeyMeta = const VerificationMeta('apikey');
  GeneratedTextColumn _apikey;
  @override
  GeneratedTextColumn get apikey => _apikey ??= _constructApikey();
  GeneratedTextColumn _constructApikey() {
    return GeneratedTextColumn('apikey', $tableName, false, maxTextLength: 10);
  }

  final VerificationMeta _onlineMeta = const VerificationMeta('online');
  GeneratedBoolColumn _online;
  @override
  GeneratedBoolColumn get online => _online ??= _constructOnline();
  GeneratedBoolColumn _constructOnline() {
    return GeneratedBoolColumn('online', $tableName, false,
        defaultValue: Constant(true));
  }

  final VerificationMeta _internetMeta = const VerificationMeta('internet');
  GeneratedBoolColumn _internet;
  @override
  GeneratedBoolColumn get internet => _internet ??= _constructInternet();
  GeneratedBoolColumn _constructInternet() {
    return GeneratedBoolColumn('internet', $tableName, false,
        defaultValue: Constant(true));
  }

  final VerificationMeta _npopiasMeta = const VerificationMeta('npopias');
  GeneratedIntColumn _npopias;
  @override
  GeneratedIntColumn get npopias => _npopias ??= _constructNpopias();
  GeneratedIntColumn _constructNpopias() {
    return GeneratedIntColumn('npopias', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _delaycopiasMeta =
      const VerificationMeta('delaycopias');
  GeneratedIntColumn _delaycopias;
  @override
  GeneratedIntColumn get delaycopias =>
      _delaycopias ??= _constructDelaycopias();
  GeneratedIntColumn _constructDelaycopias() {
    return GeneratedIntColumn('delaycopias', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _printernameMeta =
      const VerificationMeta('printername');
  GeneratedTextColumn _printername;
  @override
  GeneratedTextColumn get printername =>
      _printername ??= _constructPrintername();
  GeneratedTextColumn _constructPrintername() {
    return GeneratedTextColumn('printername', $tableName, false,
        maxTextLength: 50);
  }

  final VerificationMeta _printeraddresMeta =
      const VerificationMeta('printeraddres');
  GeneratedTextColumn _printeraddres;
  @override
  GeneratedTextColumn get printeraddres =>
      _printeraddres ??= _constructPrinteraddres();
  GeneratedTextColumn _constructPrinteraddres() {
    return GeneratedTextColumn('printeraddres', $tableName, false,
        maxTextLength: 50);
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        remoteurl,
        localurl,
        apiclient,
        apikey,
        online,
        internet,
        npopias,
        delaycopias,
        printername,
        printeraddres
      ];
  @override
  $SettingsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'settings';
  @override
  final String actualTableName = 'settings';
  @override
  VerificationContext validateIntegrity(SettingsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.remoteurl.present) {
      context.handle(_remoteurlMeta,
          remoteurl.isAcceptableValue(d.remoteurl.value, _remoteurlMeta));
    } else if (remoteurl.isRequired && isInserting) {
      context.missing(_remoteurlMeta);
    }
    if (d.localurl.present) {
      context.handle(_localurlMeta,
          localurl.isAcceptableValue(d.localurl.value, _localurlMeta));
    } else if (localurl.isRequired && isInserting) {
      context.missing(_localurlMeta);
    }
    if (d.apiclient.present) {
      context.handle(_apiclientMeta,
          apiclient.isAcceptableValue(d.apiclient.value, _apiclientMeta));
    } else if (apiclient.isRequired && isInserting) {
      context.missing(_apiclientMeta);
    }
    if (d.apikey.present) {
      context.handle(
          _apikeyMeta, apikey.isAcceptableValue(d.apikey.value, _apikeyMeta));
    } else if (apikey.isRequired && isInserting) {
      context.missing(_apikeyMeta);
    }
    if (d.online.present) {
      context.handle(
          _onlineMeta, online.isAcceptableValue(d.online.value, _onlineMeta));
    } else if (online.isRequired && isInserting) {
      context.missing(_onlineMeta);
    }
    if (d.internet.present) {
      context.handle(_internetMeta,
          internet.isAcceptableValue(d.internet.value, _internetMeta));
    } else if (internet.isRequired && isInserting) {
      context.missing(_internetMeta);
    }
    if (d.npopias.present) {
      context.handle(_npopiasMeta,
          npopias.isAcceptableValue(d.npopias.value, _npopiasMeta));
    } else if (npopias.isRequired && isInserting) {
      context.missing(_npopiasMeta);
    }
    if (d.delaycopias.present) {
      context.handle(_delaycopiasMeta,
          delaycopias.isAcceptableValue(d.delaycopias.value, _delaycopiasMeta));
    } else if (delaycopias.isRequired && isInserting) {
      context.missing(_delaycopiasMeta);
    }
    if (d.printername.present) {
      context.handle(_printernameMeta,
          printername.isAcceptableValue(d.printername.value, _printernameMeta));
    } else if (printername.isRequired && isInserting) {
      context.missing(_printernameMeta);
    }
    if (d.printeraddres.present) {
      context.handle(
          _printeraddresMeta,
          printeraddres.isAcceptableValue(
              d.printeraddres.value, _printeraddresMeta));
    } else if (printeraddres.isRequired && isInserting) {
      context.missing(_printeraddresMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setting map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Setting.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SettingsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.remoteurl.present) {
      map['remoteurl'] = Variable<String, StringType>(d.remoteurl.value);
    }
    if (d.localurl.present) {
      map['localurl'] = Variable<String, StringType>(d.localurl.value);
    }
    if (d.apiclient.present) {
      map['apiclient'] = Variable<String, StringType>(d.apiclient.value);
    }
    if (d.apikey.present) {
      map['apikey'] = Variable<String, StringType>(d.apikey.value);
    }
    if (d.online.present) {
      map['online'] = Variable<bool, BoolType>(d.online.value);
    }
    if (d.internet.present) {
      map['internet'] = Variable<bool, BoolType>(d.internet.value);
    }
    if (d.npopias.present) {
      map['npopias'] = Variable<int, IntType>(d.npopias.value);
    }
    if (d.delaycopias.present) {
      map['delaycopias'] = Variable<int, IntType>(d.delaycopias.value);
    }
    if (d.printername.present) {
      map['printername'] = Variable<String, StringType>(d.printername.value);
    }
    if (d.printeraddres.present) {
      map['printeraddres'] =
          Variable<String, StringType>(d.printeraddres.value);
    }
    return map;
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(_db, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final int usuarioid;
  final String usuario;
  final String clave;
  final String nombre;
  final String direccion;
  final String telefono;
  final int level;
  final bool activo;
  Usuario(
      {@required this.usuarioid,
      @required this.usuario,
      @required this.clave,
      @required this.nombre,
      @required this.direccion,
      @required this.telefono,
      @required this.level,
      @required this.activo});
  factory Usuario.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Usuario(
      usuarioid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}usuarioid']),
      usuario:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}usuario']),
      clave:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}clave']),
      nombre:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}nombre']),
      direccion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}direccion']),
      telefono: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}telefono']),
      level: intType.mapFromDatabaseResponse(data['${effectivePrefix}level']),
      activo:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}activo']),
    );
  }
  factory Usuario.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Usuario(
      usuarioid: serializer.fromJson<int>(json['usuarioid']),
      usuario: serializer.fromJson<String>(json['usuario']),
      clave: serializer.fromJson<String>(json['clave']),
      nombre: serializer.fromJson<String>(json['nombre']),
      direccion: serializer.fromJson<String>(json['direccion']),
      telefono: serializer.fromJson<String>(json['telefono']),
      level: serializer.fromJson<int>(json['level']),
      activo: serializer.fromJson<bool>(json['activo']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'usuarioid': serializer.toJson<int>(usuarioid),
      'usuario': serializer.toJson<String>(usuario),
      'clave': serializer.toJson<String>(clave),
      'nombre': serializer.toJson<String>(nombre),
      'direccion': serializer.toJson<String>(direccion),
      'telefono': serializer.toJson<String>(telefono),
      'level': serializer.toJson<int>(level),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Usuario>>(bool nullToAbsent) {
    return UsuariosCompanion(
      usuarioid: usuarioid == null && nullToAbsent
          ? const Value.absent()
          : Value(usuarioid),
      usuario: usuario == null && nullToAbsent
          ? const Value.absent()
          : Value(usuario),
      clave:
          clave == null && nullToAbsent ? const Value.absent() : Value(clave),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      direccion: direccion == null && nullToAbsent
          ? const Value.absent()
          : Value(direccion),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      level:
          level == null && nullToAbsent ? const Value.absent() : Value(level),
      activo:
          activo == null && nullToAbsent ? const Value.absent() : Value(activo),
    ) as T;
  }

  Usuario copyWith(
          {int usuarioid,
          String usuario,
          String clave,
          String nombre,
          String direccion,
          String telefono,
          int level,
          bool activo}) =>
      Usuario(
        usuarioid: usuarioid ?? this.usuarioid,
        usuario: usuario ?? this.usuario,
        clave: clave ?? this.clave,
        nombre: nombre ?? this.nombre,
        direccion: direccion ?? this.direccion,
        telefono: telefono ?? this.telefono,
        level: level ?? this.level,
        activo: activo ?? this.activo,
      );
  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('usuarioid: $usuarioid, ')
          ..write('usuario: $usuario, ')
          ..write('clave: $clave, ')
          ..write('nombre: $nombre, ')
          ..write('direccion: $direccion, ')
          ..write('telefono: $telefono, ')
          ..write('level: $level, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc(
                  $mrjc(
                      $mrjc(
                          $mrjc($mrjc(0, usuarioid.hashCode), usuario.hashCode),
                          clave.hashCode),
                      nombre.hashCode),
                  direccion.hashCode),
              telefono.hashCode),
          level.hashCode),
      activo.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.usuarioid == usuarioid &&
          other.usuario == usuario &&
          other.clave == clave &&
          other.nombre == nombre &&
          other.direccion == direccion &&
          other.telefono == telefono &&
          other.level == level &&
          other.activo == activo);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<int> usuarioid;
  final Value<String> usuario;
  final Value<String> clave;
  final Value<String> nombre;
  final Value<String> direccion;
  final Value<String> telefono;
  final Value<int> level;
  final Value<bool> activo;
  const UsuariosCompanion({
    this.usuarioid = const Value.absent(),
    this.usuario = const Value.absent(),
    this.clave = const Value.absent(),
    this.nombre = const Value.absent(),
    this.direccion = const Value.absent(),
    this.telefono = const Value.absent(),
    this.level = const Value.absent(),
    this.activo = const Value.absent(),
  });
}

class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsuariosTable(this._db, [this._alias]);
  final VerificationMeta _usuarioidMeta = const VerificationMeta('usuarioid');
  GeneratedIntColumn _usuarioid;
  @override
  GeneratedIntColumn get usuarioid => _usuarioid ??= _constructUsuarioid();
  GeneratedIntColumn _constructUsuarioid() {
    return GeneratedIntColumn('usuarioid', $tableName, false,
        hasAutoIncrement: true);
  }

  final VerificationMeta _usuarioMeta = const VerificationMeta('usuario');
  GeneratedTextColumn _usuario;
  @override
  GeneratedTextColumn get usuario => _usuario ??= _constructUsuario();
  GeneratedTextColumn _constructUsuario() {
    return GeneratedTextColumn('usuario', $tableName, false, maxTextLength: 15);
  }

  final VerificationMeta _claveMeta = const VerificationMeta('clave');
  GeneratedTextColumn _clave;
  @override
  GeneratedTextColumn get clave => _clave ??= _constructClave();
  GeneratedTextColumn _constructClave() {
    return GeneratedTextColumn('clave', $tableName, false, maxTextLength: 20);
  }

  final VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  GeneratedTextColumn _nombre;
  @override
  GeneratedTextColumn get nombre => _nombre ??= _constructNombre();
  GeneratedTextColumn _constructNombre() {
    return GeneratedTextColumn('nombre', $tableName, false, maxTextLength: 100);
  }

  final VerificationMeta _direccionMeta = const VerificationMeta('direccion');
  GeneratedTextColumn _direccion;
  @override
  GeneratedTextColumn get direccion => _direccion ??= _constructDireccion();
  GeneratedTextColumn _constructDireccion() {
    return GeneratedTextColumn('direccion', $tableName, false,
        maxTextLength: 300);
  }

  final VerificationMeta _telefonoMeta = const VerificationMeta('telefono');
  GeneratedTextColumn _telefono;
  @override
  GeneratedTextColumn get telefono => _telefono ??= _constructTelefono();
  GeneratedTextColumn _constructTelefono() {
    return GeneratedTextColumn('telefono', $tableName, false,
        maxTextLength: 20);
  }

  final VerificationMeta _levelMeta = const VerificationMeta('level');
  GeneratedIntColumn _level;
  @override
  GeneratedIntColumn get level => _level ??= _constructLevel();
  GeneratedIntColumn _constructLevel() {
    return GeneratedIntColumn('level', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _activoMeta = const VerificationMeta('activo');
  GeneratedBoolColumn _activo;
  @override
  GeneratedBoolColumn get activo => _activo ??= _constructActivo();
  GeneratedBoolColumn _constructActivo() {
    return GeneratedBoolColumn('activo', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [usuarioid, usuario, clave, nombre, direccion, telefono, level, activo];
  @override
  $UsuariosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'usuarios';
  @override
  final String actualTableName = 'usuarios';
  @override
  VerificationContext validateIntegrity(UsuariosCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.usuarioid.present) {
      context.handle(_usuarioidMeta,
          usuarioid.isAcceptableValue(d.usuarioid.value, _usuarioidMeta));
    } else if (usuarioid.isRequired && isInserting) {
      context.missing(_usuarioidMeta);
    }
    if (d.usuario.present) {
      context.handle(_usuarioMeta,
          usuario.isAcceptableValue(d.usuario.value, _usuarioMeta));
    } else if (usuario.isRequired && isInserting) {
      context.missing(_usuarioMeta);
    }
    if (d.clave.present) {
      context.handle(
          _claveMeta, clave.isAcceptableValue(d.clave.value, _claveMeta));
    } else if (clave.isRequired && isInserting) {
      context.missing(_claveMeta);
    }
    if (d.nombre.present) {
      context.handle(
          _nombreMeta, nombre.isAcceptableValue(d.nombre.value, _nombreMeta));
    } else if (nombre.isRequired && isInserting) {
      context.missing(_nombreMeta);
    }
    if (d.direccion.present) {
      context.handle(_direccionMeta,
          direccion.isAcceptableValue(d.direccion.value, _direccionMeta));
    } else if (direccion.isRequired && isInserting) {
      context.missing(_direccionMeta);
    }
    if (d.telefono.present) {
      context.handle(_telefonoMeta,
          telefono.isAcceptableValue(d.telefono.value, _telefonoMeta));
    } else if (telefono.isRequired && isInserting) {
      context.missing(_telefonoMeta);
    }
    if (d.level.present) {
      context.handle(
          _levelMeta, level.isAcceptableValue(d.level.value, _levelMeta));
    } else if (level.isRequired && isInserting) {
      context.missing(_levelMeta);
    }
    if (d.activo.present) {
      context.handle(
          _activoMeta, activo.isAcceptableValue(d.activo.value, _activoMeta));
    } else if (activo.isRequired && isInserting) {
      context.missing(_activoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {usuarioid};
  @override
  Usuario map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Usuario.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(UsuariosCompanion d) {
    final map = <String, Variable>{};
    if (d.usuarioid.present) {
      map['usuarioid'] = Variable<int, IntType>(d.usuarioid.value);
    }
    if (d.usuario.present) {
      map['usuario'] = Variable<String, StringType>(d.usuario.value);
    }
    if (d.clave.present) {
      map['clave'] = Variable<String, StringType>(d.clave.value);
    }
    if (d.nombre.present) {
      map['nombre'] = Variable<String, StringType>(d.nombre.value);
    }
    if (d.direccion.present) {
      map['direccion'] = Variable<String, StringType>(d.direccion.value);
    }
    if (d.telefono.present) {
      map['telefono'] = Variable<String, StringType>(d.telefono.value);
    }
    if (d.level.present) {
      map['level'] = Variable<int, IntType>(d.level.value);
    }
    if (d.activo.present) {
      map['activo'] = Variable<bool, BoolType>(d.activo.value);
    }
    return map;
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(_db, alias);
  }
}

class UsuarioLevel extends DataClass implements Insertable<UsuarioLevel> {
  final int level;
  final String nombre;
  UsuarioLevel({@required this.level, @required this.nombre});
  factory UsuarioLevel.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return UsuarioLevel(
      level: intType.mapFromDatabaseResponse(data['${effectivePrefix}level']),
      nombre:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}nombre']),
    );
  }
  factory UsuarioLevel.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return UsuarioLevel(
      level: serializer.fromJson<int>(json['level']),
      nombre: serializer.fromJson<String>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'level': serializer.toJson<int>(level),
      'nombre': serializer.toJson<String>(nombre),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<UsuarioLevel>>(
      bool nullToAbsent) {
    return UsuarioLevelsCompanion(
      level:
          level == null && nullToAbsent ? const Value.absent() : Value(level),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
    ) as T;
  }

  UsuarioLevel copyWith({int level, String nombre}) => UsuarioLevel(
        level: level ?? this.level,
        nombre: nombre ?? this.nombre,
      );
  @override
  String toString() {
    return (StringBuffer('UsuarioLevel(')
          ..write('level: $level, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc($mrjc(0, level.hashCode), nombre.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is UsuarioLevel && other.level == level && other.nombre == nombre);
}

class UsuarioLevelsCompanion extends UpdateCompanion<UsuarioLevel> {
  final Value<int> level;
  final Value<String> nombre;
  const UsuarioLevelsCompanion({
    this.level = const Value.absent(),
    this.nombre = const Value.absent(),
  });
}

class $UsuarioLevelsTable extends UsuarioLevels
    with TableInfo<$UsuarioLevelsTable, UsuarioLevel> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsuarioLevelsTable(this._db, [this._alias]);
  final VerificationMeta _levelMeta = const VerificationMeta('level');
  GeneratedIntColumn _level;
  @override
  GeneratedIntColumn get level => _level ??= _constructLevel();
  GeneratedIntColumn _constructLevel() {
    return GeneratedIntColumn('level', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  GeneratedTextColumn _nombre;
  @override
  GeneratedTextColumn get nombre => _nombre ??= _constructNombre();
  GeneratedTextColumn _constructNombre() {
    return GeneratedTextColumn('nombre', $tableName, false, maxTextLength: 50);
  }

  @override
  List<GeneratedColumn> get $columns => [level, nombre];
  @override
  $UsuarioLevelsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'usuario_levels';
  @override
  final String actualTableName = 'usuario_levels';
  @override
  VerificationContext validateIntegrity(UsuarioLevelsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.level.present) {
      context.handle(
          _levelMeta, level.isAcceptableValue(d.level.value, _levelMeta));
    } else if (level.isRequired && isInserting) {
      context.missing(_levelMeta);
    }
    if (d.nombre.present) {
      context.handle(
          _nombreMeta, nombre.isAcceptableValue(d.nombre.value, _nombreMeta));
    } else if (nombre.isRequired && isInserting) {
      context.missing(_nombreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {level};
  @override
  UsuarioLevel map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return UsuarioLevel.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(UsuarioLevelsCompanion d) {
    final map = <String, Variable>{};
    if (d.level.present) {
      map['level'] = Variable<int, IntType>(d.level.value);
    }
    if (d.nombre.present) {
      map['nombre'] = Variable<String, StringType>(d.nombre.value);
    }
    return map;
  }

  @override
  $UsuarioLevelsTable createAlias(String alias) {
    return $UsuarioLevelsTable(_db, alias);
  }
}

class SystemSetting extends DataClass implements Insertable<SystemSetting> {
  final int id;
  final DateTime fechaop;
  final DateTime fechasinc;
  SystemSetting(
      {@required this.id, @required this.fechaop, @required this.fechasinc});
  factory SystemSetting.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return SystemSetting(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      fechaop: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}fechaop']),
      fechasinc: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}fechasinc']),
    );
  }
  factory SystemSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return SystemSetting(
      id: serializer.fromJson<int>(json['id']),
      fechaop: serializer.fromJson<DateTime>(json['fechaop']),
      fechasinc: serializer.fromJson<DateTime>(json['fechasinc']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'fechaop': serializer.toJson<DateTime>(fechaop),
      'fechasinc': serializer.toJson<DateTime>(fechasinc),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<SystemSetting>>(
      bool nullToAbsent) {
    return SystemSettingsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      fechaop: fechaop == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaop),
      fechasinc: fechasinc == null && nullToAbsent
          ? const Value.absent()
          : Value(fechasinc),
    ) as T;
  }

  SystemSetting copyWith({int id, DateTime fechaop, DateTime fechasinc}) =>
      SystemSetting(
        id: id ?? this.id,
        fechaop: fechaop ?? this.fechaop,
        fechasinc: fechasinc ?? this.fechasinc,
      );
  @override
  String toString() {
    return (StringBuffer('SystemSetting(')
          ..write('id: $id, ')
          ..write('fechaop: $fechaop, ')
          ..write('fechasinc: $fechasinc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc($mrjc(0, id.hashCode), fechaop.hashCode), fechasinc.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is SystemSetting &&
          other.id == id &&
          other.fechaop == fechaop &&
          other.fechasinc == fechasinc);
}

class SystemSettingsCompanion extends UpdateCompanion<SystemSetting> {
  final Value<int> id;
  final Value<DateTime> fechaop;
  final Value<DateTime> fechasinc;
  const SystemSettingsCompanion({
    this.id = const Value.absent(),
    this.fechaop = const Value.absent(),
    this.fechasinc = const Value.absent(),
  });
}

class $SystemSettingsTable extends SystemSettings
    with TableInfo<$SystemSettingsTable, SystemSetting> {
  final GeneratedDatabase _db;
  final String _alias;
  $SystemSettingsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        defaultValue: Constant(1));
  }

  final VerificationMeta _fechaopMeta = const VerificationMeta('fechaop');
  GeneratedDateTimeColumn _fechaop;
  @override
  GeneratedDateTimeColumn get fechaop => _fechaop ??= _constructFechaop();
  GeneratedDateTimeColumn _constructFechaop() {
    return GeneratedDateTimeColumn(
      'fechaop',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fechasincMeta = const VerificationMeta('fechasinc');
  GeneratedDateTimeColumn _fechasinc;
  @override
  GeneratedDateTimeColumn get fechasinc => _fechasinc ??= _constructFechasinc();
  GeneratedDateTimeColumn _constructFechasinc() {
    return GeneratedDateTimeColumn(
      'fechasinc',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, fechaop, fechasinc];
  @override
  $SystemSettingsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'system_settings';
  @override
  final String actualTableName = 'system_settings';
  @override
  VerificationContext validateIntegrity(SystemSettingsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.fechaop.present) {
      context.handle(_fechaopMeta,
          fechaop.isAcceptableValue(d.fechaop.value, _fechaopMeta));
    } else if (fechaop.isRequired && isInserting) {
      context.missing(_fechaopMeta);
    }
    if (d.fechasinc.present) {
      context.handle(_fechasincMeta,
          fechasinc.isAcceptableValue(d.fechasinc.value, _fechasincMeta));
    } else if (fechasinc.isRequired && isInserting) {
      context.missing(_fechasincMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SystemSetting map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SystemSetting.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SystemSettingsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.fechaop.present) {
      map['fechaop'] = Variable<DateTime, DateTimeType>(d.fechaop.value);
    }
    if (d.fechasinc.present) {
      map['fechasinc'] = Variable<DateTime, DateTimeType>(d.fechasinc.value);
    }
    return map;
  }

  @override
  $SystemSettingsTable createAlias(String alias) {
    return $SystemSettingsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $CobradorsTable _cobradors;
  $CobradorsTable get cobradors => _cobradors ??= $CobradorsTable(this);
  $EmpresaSettingTable _empresaSetting;
  $EmpresaSettingTable get empresaSetting =>
      _empresaSetting ??= $EmpresaSettingTable(this);
  $MenuOptionsTable _menuOptions;
  $MenuOptionsTable get menuOptions => _menuOptions ??= $MenuOptionsTable(this);
  $PagaresTable _pagares;
  $PagaresTable get pagares => _pagares ??= $PagaresTable(this);
  $PrestamosTable _prestamos;
  $PrestamosTable get prestamos => _prestamos ??= $PrestamosTable(this);
  $RecibosTable _recibos;
  $RecibosTable get recibos => _recibos ??= $RecibosTable(this);
  $SecuenciasTable _secuencias;
  $SecuenciasTable get secuencias => _secuencias ??= $SecuenciasTable(this);
  $SettingsTable _settings;
  $SettingsTable get settings => _settings ??= $SettingsTable(this);
  $UsuariosTable _usuarios;
  $UsuariosTable get usuarios => _usuarios ??= $UsuariosTable(this);
  $UsuarioLevelsTable _usuarioLevels;
  $UsuarioLevelsTable get usuarioLevels =>
      _usuarioLevels ??= $UsuarioLevelsTable(this);
  $SystemSettingsTable _systemSettings;
  $SystemSettingsTable get systemSettings =>
      _systemSettings ??= $SystemSettingsTable(this);
  UsuarioDao _usuarioDao;
  UsuarioDao get usuarioDao => _usuarioDao ??= UsuarioDao(this as AppDatabase);
  MenuOptionDao _menuOptionDao;
  MenuOptionDao get menuOptionDao =>
      _menuOptionDao ??= MenuOptionDao(this as AppDatabase);
  SettingDao _settingDao;
  SettingDao get settingDao => _settingDao ??= SettingDao(this as AppDatabase);
  UsuarioLevelDao _usuarioLevelDao;
  UsuarioLevelDao get usuarioLevelDao =>
      _usuarioLevelDao ??= UsuarioLevelDao(this as AppDatabase);
  EmpresaDao _empresaDao;
  EmpresaDao get empresaDao => _empresaDao ??= EmpresaDao(this as AppDatabase);
  SystemSettingDao _systemSettingDao;
  SystemSettingDao get systemSettingDao =>
      _systemSettingDao ??= SystemSettingDao(this as AppDatabase);
  PrestamosDao _prestamosDao;
  PrestamosDao get prestamosDao =>
      _prestamosDao ??= PrestamosDao(this as AppDatabase);
  CobradorDao _cobradorDao;
  CobradorDao get cobradorDao =>
      _cobradorDao ??= CobradorDao(this as AppDatabase);
  SecuenciasDao _secuenciasDao;
  SecuenciasDao get secuenciasDao =>
      _secuenciasDao ??= SecuenciasDao(this as AppDatabase);
  RecibosDao _recibosDao;
  RecibosDao get recibosDao => _recibosDao ??= RecibosDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables => [
        cobradors,
        empresaSetting,
        menuOptions,
        pagares,
        prestamos,
        recibos,
        secuencias,
        settings,
        usuarios,
        usuarioLevels,
        systemSettings
      ];
}
