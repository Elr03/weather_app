class AppCopies {
  static const String okLabel = 'Aceptar';
  static const String inputACity =
      'Introduce el nombre de la ciudad que deseas agregar.';
  static const String cityLabel = 'Ciudad';
  static const String searchLabel = 'Buscar';
  static const String unityLabel = 'Unidad: ';
  static const String updatingForecasts =
      'Estamos actualizando el pronóstico y cambiando las unidades de medida';
  static const String minLabel = 'Min.:';
  static const String maxLabel = 'Max.:';
  static const String changeToLabel = 'Cambiar de ';
  static const String aPreposition = ' a ';
  static const String cityListEmpty = 'No has agregado ciudades';
  static const String addCity = 'Agregar ciudad';
  static const String inLastHour = 'en la última hora';
  static const String cityListLabel = 'Lista de ciudades';
  static const String retry = 'Reintentar';
  static const String unexpectedError = 'Ocurrió un error inesperado.';
  static const String notFoundLocation =
      'No se encontró información de esta ubicación.';
  static const String gettingLocationPermissions =
      'Estamos solicitando permisos de ubicación.';
  static const String gettingLocation = 'Estamos obteniendo la ubicación.';
  static const String gettingWeatherInfo =
      'Estamos obteniendo la información del clima.';
  static const String successCityAdd = 'Se agregó exitosamente la ciudad.';
  static const String errorCityInfo =
      'No se encontró información para esta ciudad, intente con otra ciudad.';

  static String searchingCityInfo(String city) =>
      'Estamos buscando la información del clima de "$city"';
  static String imageUrl(String icon) =>
      'https://openweathermap.org/img/wn/$icon@2x.png';
}
