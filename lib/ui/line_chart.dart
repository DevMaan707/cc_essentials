import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ModernLineChart extends StatelessWidget {
  final List<FlSpot> dataPoints;
  final List<String> xAxisLabels;
  final List<String> yAxisLabels;
  final String title;
  final String subTitle;
  final Color lineColor;
  final Color gridColor;
  final Color titleColor;
  final Color subTitleColor;
  final Color dotColor;

  const ModernLineChart({
    super.key,
    required this.dataPoints,
    required this.xAxisLabels,
    required this.yAxisLabels,
    required this.title,
    required this.subTitle,
    this.lineColor = Colors.blue,
    this.gridColor = Colors.grey,
    this.titleColor = Colors.black,
    this.subTitleColor = Colors.grey,
    this.dotColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Subtitle
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 14,
              color: subTitleColor,
            ),
          ),
          const SizedBox(height: 16),
          // Chart
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                backgroundColor: Colors.white,
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return Text(
                          index >= 0 && index < xAxisLabels.length
                              ? xAxisLabels[index]
                              : '',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return Text(
                          index >= 0 && index < yAxisLabels.length
                              ? yAxisLabels[index]
                              : '',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        );
                      },
                    ),
                  ),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: gridColor, width: 1),
                ),
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (value) => FlLine(
                      color: gridColor.withOpacity(0.2), strokeWidth: 0.8),
                  getDrawingVerticalLine: (value) => FlLine(
                      color: gridColor.withOpacity(0.2), strokeWidth: 0.8),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: lineColor,
                    barWidth: 3,
                    belowBarData: BarAreaData(
                      show: true,
                      color: lineColor.withOpacity(0.2),
                    ),
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: dotColor,
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    spots: dataPoints,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
