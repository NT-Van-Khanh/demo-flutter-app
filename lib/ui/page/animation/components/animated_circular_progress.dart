import 'package:flutter/material.dart';

class AnimatedCircularProgress extends StatelessWidget {
  const AnimatedCircularProgress({
    super.key,
    required this.size,
    required this.percent,
    required this.strokeWidth,
    this.onChanged,
  });

  final double size;
  final double percent;
  final double strokeWidth;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxSize = constraints.maxWidth < constraints.maxHeight ? constraints.maxWidth : constraints.maxHeight;
        double finalSize = size < maxSize ? (size > 60 ? size : 60) : (maxSize -6);
        return Stack(
          alignment: Alignment.center,
          children:[ 
            SizedBox(
              width: finalSize,
              height: finalSize,
              child: CircularProgressIndicator(
                value: percent/100, // 0.0 -> 1.0, 65%
                strokeWidth: strokeWidth,
                
                color: Colors.blue, 
                backgroundColor: Colors.grey.shade300, 
              ),
            ),
            Text( '$percent%',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ]
        );
      }
    );
  }
}
