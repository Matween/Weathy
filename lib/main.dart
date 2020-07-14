import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weathy/weather.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weathy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Weathy'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position position;
  Weather weather;
  final defaultImage = 'assets/icons8-rainbow-100.png';

  Future<Null> fetchWeather() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?units=metric&lat=' +
            position.latitude.toString() +
            '&lon=' +
            position.longitude.toString() +
            '&appid=' +
            DotEnv().env['API_KEY']);
    setState(() {
      weather = Weather.fromJson(json.decode(response.body.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: RefreshIndicator(
          onRefresh: fetchWeather,
          child: Stack(
            children: <Widget>[
              ListView(
                padding: const EdgeInsets.all(8),
              ),
              Container(
                height: 200,
                child: Center(
                  child: Text(
                    weather == null
                        ? 'No data avaialable'
                        : weather.temperature.toStringAsFixed(0) + '°C',
                    style: defaultStyle(size: 26),
                  ),
                ),
              ),
              Container(
                height: 250,
                child: Center(
                  child: Text(
                    weather == null ? '' : weather.city,
                    style: defaultStyle(),
                  ),
                ),
              ),
              Container(
                height: 400,
                child: Center(
                  child: FadeInImage(
                    placeholder: AssetImage(defaultImage),
                    image: weather == null
                        ? AssetImage(defaultImage)
                        : AssetImage(Weather.icons[weather.description]),
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.,
    );
  }

  TextStyle defaultStyle({double size = 18, Color color = Colors.white}) {
    return new TextStyle(color: color, fontSize: size);
  }
}
