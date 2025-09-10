import 'package:flutter/material.dart';

class SimpleWeatherCard extends StatelessWidget {
  const SimpleWeatherCard({
    super.key,
    this.color,
    required this.iconUrl,
    required this.weather,
  });

  final Color? color;
  final String iconUrl;
  final dynamic weather;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      color: color,
      child: ListTile(
        leading: Image.network(
          iconUrl,
          width: 64,
          height: 64,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const CircularProgressIndicator();
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, color: Colors.red,);
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
  }
}
