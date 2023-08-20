import 'package:flutter/material.dart';

class BMIChart extends StatefulWidget {
  const BMIChart({super.key});

  @override
  State<BMIChart> createState() => _BMIChartState();
}

class _BMIChartState extends State<BMIChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 8, 0,
          MediaQuery.of(context).size.width / 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Categories for different Body Mass Index",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          DataTable(
            columns: const [
              DataColumn(label: Text("BMI Categories")),
              DataColumn(label: Text("BMI"))
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text("Underweight")),
                DataCell(Text("<18.5"))
              ]),
              DataRow(cells: [
                DataCell(Text("Normal weight")),
                DataCell(Text("18.5–24.9"))
              ]),
              DataRow(cells: [
                DataCell(Text("Overweight")),
                DataCell(Text("25-29.9"))
              ]),
              DataRow(
                  cells: [DataCell(Text("Obesity")), DataCell(Text(">30"))]),
            ],
            border: TableBorder.all(color: Colors.black, width: 1),
          ),
        ],
      ),
    );
  }
}
