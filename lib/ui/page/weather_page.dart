import 'package:b1_first_flutter_app/data/model/weather/weather.dart';
import 'package:b1_first_flutter_app/data/service/weather_api.dart';
import 'package:b1_first_flutter_app/l10n/app_localizations.dart';
import 'package:b1_first_flutter_app/provider/weather_state.dart';

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
    futureWeather = WeatherApi.featchWeather(appState.weatherQuery);
    
    futureWeather.then((weather) {
      if (!mounted) return;
      setState(() {
        appState.setCurrentWeather(weather);
      });
    });
  }

    @override
  Widget build(BuildContext context) {
    final weatherState = context.watch<WeatherState>();
    var weathers = weatherState.weathers;
    
    void featchWeather(query) async{
      final weather = await WeatherApi.featchWeather(query);
      if (!mounted) return;
      setState(() {
        weatherState.setWeatherQuery(query);
        weatherState.addSearchHistory();
        weatherState.setCurrentWeather(weather);
        futureWeather = Future.value(weather);
      });
    }

    Widget searchContent = weatherState.currentWeather !=null ?
      SearchWeatherResult(iconUrl: "https:${weatherState.currentWeather!.current.condition.icon}",
        weather: weatherState.currentWeather!)
      :FutureBuilder(future: futureWeather, 
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Lỗi: ${snapshot.error}", style: const TextStyle(color: Colors.blueGrey),);
          } else if (snapshot.hasData) {
            final weather = snapshot.data!;
            final iconUrl = "https:${weather.current.condition.icon}";
            return SearchWeatherResult(iconUrl: iconUrl, weather: weather);
          } else {
            return const Text("Không có dữ liệu");
          }
        }
      );

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
                TextField(
                  style: TextStyle(
                    fontSize: 18
                  ),
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.weather_searchLocationLabel,
                    hintText: AppLocalizations.of(context)!.weather_searchLocationHint,
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600
                    ),
                    // prefixIcon: Icon(Icons.email),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                    suffixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none)
                    ),
                    onSubmitted: (value) => featchWeather(value),
                ),
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
                    return Card(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      child: ListTile(
                        leading: Image.network(
                          iconUrl,
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const CircularProgressIndicator(); // hiển thị khi đang tải ảnh
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error, color: Colors.red,); // hiển thị khi tải ảnh lỗi
                          },
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("Temp: ${weather.current.tempC}°C",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).colorScheme.onSurfaceVariant
                                  ),
                            ),
                            Text(weather.current.condition.text),
                            Text('${weather.location.name}, ${weather.location.country}'),
                          ],
                        ),
                        textColor: Theme.of(context).colorScheme.onSurface,
                        titleTextStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchWeatherResult extends StatelessWidget {
  const SearchWeatherResult({
    super.key,
    required this.iconUrl,
    required this.weather,
  });

  final String iconUrl;
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          iconUrl,
          width: 128,
          height: 128,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const CircularProgressIndicator(); // hiển thị khi đang tải ảnh
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, color: Colors.red,); // hiển thị khi tải ảnh lỗi
          },
        ),
        SizedBox(width: 10.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("Temp: ${weather.current.tempC}°C",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurfaceVariant
                  ),
            ),
            Text(weather.current.condition.text),
            Text('Hum: ${weather.current.humidity}'),
            Text('${weather.location.name}, ${weather.location.country}'),
          ],
        ),                    
      ],
    );
  }
}
