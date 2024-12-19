import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_info.dart';
import 'package:weather_app/hourly_forecast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // late double temp = 0;
  // bool isLoading = false;
  // late Future<Map<String, dynamic>> weather;
  Future<Map<String, dynamic>?> getCurrentWeather() async {
    try {
      // setState(()
      //   isLoading = true;
      // });
      // const String city = "London";
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=Nashik&APPID=861c34a9177896790e1eb1c8c0518cf6"));
      // log(response.body);
      final data = await jsonDecode(response.body);
      // print(data);
      // log('cod = ${data['cod']}');
      if (data['cod'] != '200') {
        log("Failed to load weather data...........");
      }
      // setState(() {
      //   temp = 270;
      //   isLoading = false;
      // });
      log(data['list'][0]['main']['temp'].toString());
      return data;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Weather App"), centerTitle: true, actions: [
        IconButton(
            onPressed: () {
              setState(() {
                // getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh))
      ]),
      body:
          // isLoading
          //     ? const CircularProgressIndicator()
          //     :
          FutureBuilder(
              future: getCurrentWeather(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.data == null) {
                  return const Center(child: Text("Null data"));
                }
                final data = snapshot.data!;
                final currentWeather = data['list'][0];
                final currentWeatherTemp =
                    currentWeather['main']['temp'].toString();
                final currentWeatherMain = currentWeather['weather'][0]['main'];
                final weatherHumidity =
                    currentWeather['main']['humidity'].toString();
                final weatherPressure =
                    currentWeather['main']['pressure'].toString();
                final weatherWind = currentWeather['wind']['speed'].toString();
                if (data['list'] == null || data['list'].isEmpty) {
                  return const Center(child: Text("No weather data available"));
                }
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      // temp.toString(),
                                      currentWeatherTemp,
                                      style: const TextStyle(fontSize: 32),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Icon(
                                      currentWeatherMain == 'Clouds' ||
                                              currentWeatherMain == 'Rain'
                                          ? Icons.cloud
                                          : Icons.sunny,
                                      size: 25,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      currentWeatherMain,
                                      style: const TextStyle(fontSize: 25),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Weather Forecast",
                        style: TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              final forecastHourly = data['list'][index + 1];
                              final forecastHourlyTemp =
                                  forecastHourly['main']['temp'].toString();
                              final forecastHourlyTime =
                                  DateTime.parse(forecastHourly['dt_txt']);
                              final forecastHourlySky =
                                  forecastHourly['weather'][0]['main'];
                              return HourlyForecastWidget(
                                  icon: forecastHourlySky == 'Clouds' ||
                                          forecastHourlySky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  time:
                                      DateFormat.j().format(forecastHourlyTime),
                                  temparature: forecastHourlyTemp);
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Additional Features",
                        style: TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AdditionalInfo(
                            icon: Icons.water_drop,
                            text: "Humidity",
                            value: weatherHumidity,
                          ),
                          AdditionalInfo(
                            icon: Icons.air,
                            text: "Wind Speed",
                            value: weatherWind,
                          ),
                          AdditionalInfo(
                            icon: Icons.beach_access,
                            text: "Pressure",
                            value: weatherPressure,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
    );
  }
}
