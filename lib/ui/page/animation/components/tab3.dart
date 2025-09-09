import 'package:b1_first_flutter_app/ui/page/animation/components/animated_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Tab3 extends StatefulWidget {

  Tab3({ super.key,});

  @override
  State<Tab3> createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
  double percent = 65;
  double size = 100;
  double strokeWidth =5;

  final percentController = TextEditingController();
  final sizeController = TextEditingController();
  final strokeWidthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 10,),
        Expanded(
          child: Center(
              child: AnimatedCircularProgress(size: size, percent: percent, strokeWidth: strokeWidth),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
              return  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (constraints.maxWidth > 450) ? 3 : 2, 
                      //constraints.maxWidth~/180, 
                      crossAxisSpacing: 12, 
                      childAspectRatio: (constraints.maxWidth > 450) ? 
                            (constraints.maxWidth-10)/3/80 :
                            (constraints.maxWidth-10)/2/80,
                    ), 
                    physics: NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Percent (%): "),
                          Input(
                            hint: percent.toString(), 
                            maxLength: 3, 
                            controller:  percentController, 
                            keyboardType: TextInputType.number,),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Size (pixel): "),
                          Input(
                            hint: size.toString(), 
                            maxLength: 5, 
                            controller: sizeController,
                            keyboardType: TextInputType.number,),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("StrokeWight (pixel): "),
                          Input(
                            hint: strokeWidth.toString(), 
                            maxLength: 4, 
                            controller: strokeWidthController,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                     
                    ],
                  ),
              );
            }
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: updateUI, child: Text("Submit")),
        SizedBox(height: 10),
      ],
    );
  }

  void updateUI() {
    setState(() {
      size = double.tryParse(sizeController.text) ?? size;
      strokeWidth = double.tryParse(strokeWidthController.text)?? strokeWidth;
      percent = double.tryParse(percentController.text)?? percent;
    });
   
  }
}
class Input extends StatelessWidget {
  const Input({
    super.key,
    this.label,
    this.maxLength,
    required this.hint, 
    this.controller,
    this.keyboardType,
  });

  final String? label;
  final int? maxLength;
  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      keyboardType: keyboardType,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      decoration: InputDecoration(
      counterText: "",
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500
      ),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none),
      ),
      controller: controller,
    );
  }
}


class AnimatedTabButton extends StatelessWidget {
  final String label;
  final bool selected;

  const AnimatedTabButton({
    super.key,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(horizontal: selected ? 16 : 8, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.amber : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: selected ? 18 : 14,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}