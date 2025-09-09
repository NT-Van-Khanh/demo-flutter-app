
import 'package:b1_first_flutter_app/ui/page/animation/components/tab2.dart';
import 'package:b1_first_flutter_app/ui/page/animation/components/tab3.dart';
import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  final Tab2 tab2 = Tab2();
  final Tab3 tab3 = Tab3();
  @override
  Widget build(BuildContext context) {
  
    return DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.circle_outlined)),
            Tab(icon: Icon(Icons.change_history)),
            Tab(icon: Icon(Icons.square_outlined)),
          ],
        ),
      ),
      body: TabBarView(
            children: [
              Builder(builder: (context) {
                final tabController = DefaultTabController.of(context);
                final selected = tabController.index == 0;
                return Tab(child: AnimatedTabButton(label: "Car", selected: selected));
              }),
              tab2,
              tab3,
            ],
          ),
    ),
    );
  }
}

