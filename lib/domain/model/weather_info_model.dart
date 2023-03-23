import 'package:json_annotation/json_annotation.dart';

part 'weather_info_model.g.dart';

@JsonSerializable()
class WeatherInfoModel {
  WeatherInfoModel({
    this.coord,
    this.weather,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
    this.unit,
  });

  Coord? coord;
  List<Weather>? weather;
  Main? main;
  int? visibility;
  Wind? wind;
  Rain? rain;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;
  String? unit;

  /// Connect the generated [_$WeatherInfoModelFromJson] function to the
  /// 'fromJson' factory.
  factory WeatherInfoModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoModelFromJson(json);

  /// Connect the generated [_$WeatherInfoModelToJson] function to the `toJson`
  ///  method.
  Map<String, dynamic> toJson() => _$WeatherInfoModelToJson(this);
}

@JsonSerializable()
class Clouds {
  Clouds({
    this.all,
  });

  int? all;

  /// Connect the generated [_$CloudsFromJson] function to the
  /// 'fromJson' factory.
  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  /// Connect the generated [_$CloudsToJson] function to the `toJson`
  ///  method.
  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable()
class Coord {
  Coord({
    this.lon,
    this.lat,
  });

  double? lon;
  double? lat;

  /// Connect the generated [_$CoordFromJson] function to the
  /// 'fromJson' factory.
  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  /// Connect the generated [_$CoordToJson] function to the `toJson`
  ///  method.
  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable()
class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  /// Connect the generated [_$MainFromJson] function to the
  /// 'fromJson' factory.
  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  /// Connect the generated [_$CloudsToJson] function to the `toJson`
  ///  method.
  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Rain {
  Rain({
    this.the1H,
  });

  double? the1H;

  /// Connect the generated [_$RainFromJson] function to the
  /// 'fromJson' factory.
  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);

  /// Connect the generated [_$RainToJson] function to the `toJson`
  ///  method.
  Map<String, dynamic> toJson() => _$RainToJson(this);
}

@JsonSerializable()
class Sys {
  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  /// Connect the generated [_$SysFromJson] function to the
  /// 'fromJson' factory.
  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  /// Connect the generated [_$SysToJson] function to the `toJson`
  ///  method.
  Map<String, dynamic> toJson() => _$SysToJson(this);
}

@JsonSerializable()
class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int? id;
  String? main;
  String? description;
  String? icon;

  /// Connect the generated [_$WeatherFromJson] function to the
  /// 'fromJson' factory.
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  /// Connect the generated [_$WeatherToJson] function to the `toJson`
  ///  method.
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Wind {
  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  double? speed;
  int? deg;
  double? gust;

  /// Connect the generated [_$WindFromJson] function to the
  /// 'fromJson' factory.
  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  /// Connect the generated [_$WindToJson] function to the `toJson`
  ///  method.
  Map<String, dynamic> toJson() => _$WindToJson(this);
}
