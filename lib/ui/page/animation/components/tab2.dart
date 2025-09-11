import 'dart:math';

import 'package:flutter/material.dart';

class Tab2 extends StatefulWidget {
  const Tab2({
    super.key,
  });

  @override
  State<Tab2> createState() => _Tab2State();
}
class _Tab2State extends State<Tab2> with AutomaticKeepAliveClientMixin{
  double size = 300;
  final random = Random();
  void changeImageSize(){
    setState(() {
       size = 50 + random.nextInt(300).toDouble();
    });
  }
 
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
          child: Center(
            child: AnimatedContainer(
              width: size,
              duration: Duration(seconds: 1),
              child: Image.asset(  'assets/images/images.jpg',  fit: BoxFit.fitWidth,),
            ),
          ),
        ),
        ElevatedButton(onPressed: changeImageSize, child: Text("Change wight")),
        const SizedBox(height: 20,)
      ],
    );
  }
}
