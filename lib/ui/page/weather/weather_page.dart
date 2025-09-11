import 'package:b1_first_flutter_app/data/model/weather/weather.dart';
import 'package:b1_first_flutter_app/data/service/weather_api.dart';
import 'package:b1_first_flutter_app/provider/weather_state.dart';
import 'package:b1_first_flutter_app/ui/page/weather/components/simple_weather_card.dart';
import 'package:b1_first_flutter_app/ui/page/weather/components/weather_card.dart';
import 'package:b1_first_flutter_app/ui/widget/search_field.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    final appState = context.read<WeatherState>();
    if(appState.currentWeather == null){
      futureWeather = WeatherApi.fetchWeather(appState.weatherQuery);
      futureWeather.then((value){
        setState(() {
          appState.setCurrentWeather(value);
        });
      });
    }else{
      futureWeather=Future.value(appState.currentWeather);
    }

  }

    @override
  Widget build(BuildContext context) {
    final colorScheme =Theme.of(context).colorScheme;
    final weatherState = context.watch<WeatherState>();

    var weathers = weatherState.weathers;

    Widget searchContent = weatherState.currentWeather !=null ?
      WeatherCard(iconUrl: "https:${weatherState.currentWeather!.current.condition.icon}",weather: weatherState.currentWeather!)
      :FutureBuilder(future: futureWeather, 
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Lỗi: ${snapshot.error}", style: const TextStyle(color: Colors.blueGrey),);
          } else if (snapshot.hasData) {
            final weather = snapshot.data!;
            final iconUrl = "https:${weather.current.condition.icon}";
            return WeatherCard(iconUrl: iconUrl, weather: weather);
          } else {
            return const Text("Không có dữ liệu");
          }
        }
      );

    void onSearchSubmitted(String value) {
      final weatherState = context.read<WeatherState>();
      fetchWeather(weatherState, value);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather",
        style: TextStyle(
          fontWeight: FontWeight.w500
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 2),
                SearchField(onSearchSubmitted: onSearchSubmitted),
                SizedBox(height: 10.0,),
                Card(
                  elevation: 0.5,
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  shadowColor: Colors.lightBlue[100],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    child: Center(
                      child:searchContent,
                      ),
                    ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: weathers.length,
                  itemBuilder: (context, index) {                    
                    final weather = weathers[index];
                    final iconUrl = "https:${weather.current.condition.icon}";
                    return SimpleWeatherCard(color: colorScheme.surfaceContainerLow, iconUrl: iconUrl, weather: weather);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void fetchWeather(WeatherState weatherState, String query) async{
    final weather = await WeatherApi.fetchWeather(query);
    weatherState.setWeatherQuery(query);
    if (!mounted) return;
    setState(() {
      futureWeather = Future.value(weather);
      weatherState.addSearchHistory();
      weatherState.setCurrentWeather(weather);
    });
  }

}
