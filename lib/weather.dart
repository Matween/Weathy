class Weather {
  double temperature;
  String description;
  String city;

  Weather({this.temperature, this.description, this.city});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'],
      description: json['weather'][0]['main'],
      city: json['name'],
    );
  }
  static Map<String, String> icons = {
    'Clouds': 'assets/icons8-windy-weather-100.png',
    'Rain': 'assets/icons8-rain-100.png',
    'Thunderstorm': 'assets/icons8-storm-100.png',
    'Drizzle': 'assets/icons8-wind-100.png',
    'Snow': 'assets/icons8-snow-100.png',
    'Clear': 'assets/icons8-sun-100.png',
    'Mist': 'assets/icons8-rain-100.png',
    'Smoke': 'assets/icons8-wind-100.png',
    'Haze': 'assets/icons8-wind-100.png',
    'Dust': 'assets/icons8-wind-100.png',
    'Fog': 'assets/icons8-fog-machine-100.png',
    'Ash': 'assets/icons8-wind-100.png',
    'Squall': 'assets/icons8-wind-100.png',
    'Tornado': 'assets/icons8-wind-100.png',
  };
}
