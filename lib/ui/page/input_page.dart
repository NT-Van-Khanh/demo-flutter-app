import 'package:flutter/material.dart';

enum SingingCharacter { lafayette, jefferson }

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String textField = "";
  String checkBox="";
  bool isChecked = false;
  String dropdownValue="";
  SingingCharacter _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Page"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10.0,),
            TextField(
                  style: TextStyle(
                    fontSize: 18
                  ),
                  decoration: InputDecoration(
                    labelText: "TextField",
                    hintText: "Enter the message",
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
                    onSubmitted: (value) => setState(() => textField = value), 
                ),
                SizedBox(height: 10.0,),
                TextCard(textField: textField),
                SizedBox(height: 10.0,),
                const Divider(),
                 Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (val) {
                        setState(() {
                          isChecked = val!;
                        });
                      },
                    ),
                    const Text("Tôi đồng ý"),
                  ],
                ),
                TextCard(textField: isChecked ? "Bạn đã chọn" : "Bạn chưa chọn"),
                SizedBox(height: 10.0,),
                const Divider(),
                 Column(
                  children: [
                    RadioGroup<SingingCharacter>(
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value!;
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('Lafayette'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.lafayette,
                          ),
                        ),
                        ListTile(
                          title: const Text('Thomas Jefferson'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.jefferson,
                          ),
                        ),
                      ],
                    ),
                  ),

                    ],
                ),
                TextCard(textField:  "Bạn đã chọn: $_character"),
                SizedBox(height: 10.0,),
                const Divider(),
          ],
        ),
      ),
    );
  }
}

class TextCard extends StatelessWidget {
  const TextCard({
    super.key,
    required this.textField,
  });

  final String textField;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: Card(
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(textField,
                  
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onPrimary),),
            )
        ),
      ),
    );
  }
}