import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartUi extends StatelessWidget {
    const ChartUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LineChart(
        LineChartData(
          gridData: FlGridData(show: false), // Disable grid
          titlesData: FlTitlesData(show: false), // Disable titles
          borderData: FlBorderData(show: false), // Disable borders
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 3),
                FlSpot(1, 1),
                FlSpot(2, 4),
                FlSpot(3, 1),
                FlSpot(4, 3),
                FlSpot(5, 4),
                FlSpot(6, 2),
              ],
              isCurved: true, // Curved line
              color: Colors.pink, // Line color
              barWidth: 4, // Line width
            ),
            
          ],
          backgroundColor: Color.fromRGBO(8, 25, 83, 1)
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ChartUi(),
  ));
}
