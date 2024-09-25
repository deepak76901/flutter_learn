import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  int x = 0, y = 0;
  num z = 0;

  final displayOneController = TextEditingController();
  final displayTwoController = TextEditingController();

  late final AppLifecycleListener _listener ;

  @override
  void initState() {
    super.initState();
    displayOneController.text;
    displayTwoController.text;

    _listener = AppLifecycleListener(
      onShow: _onShow,
      onResume: _onResume,
      onHide: _onHide,
      onPause: _onPause,
      onDetach: _onDetach,
      onRestart: _onRestart,
      onInactive: _onInactive,
      onStateChange: _onStateChange,
    // onExitRequested: _onExitRequested
    );
  }

  @override
  void dispose() {
    super.dispose();

    displayOneController.dispose();
    displayTwoController.dispose();
    _listener.dispose();
  }

  void _onShow() => print("OnShow called");
  void _onHide() => print("OnHide called");
  void _onPause() => print("OnPause called");
  void _onResume() => print("OnResume called");
  void _onRestart() => print("OnRestart called");
  void _onDetach() => print("OnDetach called");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          // Calculator Display
          CalculatorDisplay(
              hint: "Enter first Number", controller: displayOneController),
          const SizedBox(height: 10),
          CalculatorDisplay(
              hint: "Enter second Number", controller: displayTwoController),
          const SizedBox(height: 10),
          Text(
            z.toString(),
            style: const TextStyle(fontSize: 36.0, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    z = num.tryParse(displayOneController.text)! +
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: const Icon(CupertinoIcons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    z = num.tryParse(displayOneController.text)! -
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: const Icon(CupertinoIcons.minus),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    z = num.tryParse(displayOneController.text)! *
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: const Icon(CupertinoIcons.multiply),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    z = num.tryParse(displayOneController.text)! /
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: const Icon(CupertinoIcons.divide),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                x = 0;
                y = 0;
                z = 0;
                displayOneController.clear();
                displayTwoController.clear();
              });
            },
            label: const Text("Clear"),
          )
          // Expand
          // Calculator Button
        ],
      ),
    );
  }
}

class CalculatorDisplay extends StatelessWidget {
  const CalculatorDisplay(
      {super.key, this.hint = "Enter a number", required this.controller});

  final String? hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      autofocus: true,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 3.0)),
          hintText: hint,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(6.0)))),
    );
  }
}
