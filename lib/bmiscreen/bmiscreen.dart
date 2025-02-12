import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double height = 170; // Default height in cm
  double weight = 70; // Default weight in kg
  double bmi = 0;

  void calculateBMI() {
    double heightInMeters = height / 100;
    setState(() {
      bmi = weight / (heightInMeters * heightInMeters);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator"),backgroundColor: Colors.lightGreenAccent,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 10,
                  maximum: 40,
                  ranges: [
                    GaugeRange(startValue: 10, endValue: 18.5, color: Colors.blue, label: "Underweight"),
                    GaugeRange(startValue: 18.5, endValue: 24.9, color: Colors.green, label: "Normal"),
                    GaugeRange(startValue: 25, endValue: 29.9, color: Colors.orange, label: "Overweight"),
                    GaugeRange(startValue: 30, endValue: 40, color: Colors.red, label: "Obese"),
                  ],
                  pointers: [NeedlePointer(value: bmi, enableAnimation: true)],
                  annotations: [
                    GaugeAnnotation(
                      widget: Text(
                        "BMI: ${bmi.toStringAsFixed(1)}",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,backgroundColor: Colors.greenAccent),
                      ),
                      angle: 90,
                      positionFactor: 0.8,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Height: ${height.toInt()} cm"),
            Slider(
              value: height,
              min: 100,
              max: 220,
              onChanged: (newValue) {
                setState(() => height = newValue);
              },
            ),
            Text("Weight: ${weight.toInt()} kg"),
            Slider(
              value: weight,
              min: 30,
              max: 150,
              onChanged: (newValue) {
                setState(() => weight = newValue);
              },
            ),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text("Calculate BMI"),
            ),
          ],
        ),
     ),
);
}
}
