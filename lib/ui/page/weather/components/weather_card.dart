import 'package:b1_first_flutter_app/data/model/weather/weather.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
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
            return const CircularProgressIndicator();
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, color: Colors.red,);
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
