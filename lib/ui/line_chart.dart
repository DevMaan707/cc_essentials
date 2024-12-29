import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ModernLineChart extends StatelessWidget {
  final List<double> dataPoints;
  final List<String> xAxisLabels;
  final String title;
  final String subTitle;
  final Color lineColor;
  final double lineThickness;
  final Color gridColor;
  final Color titleColor;
  final Color subTitleColor;
  final Color dotColor;
  final double dotRadius;
  final double chartHeight;
  final Color backgroundColor;
  final Color borderColor;
  final Color labelColor;
  final double borderRadius;
  final bool addShadows;
  final bool showPoints;

  const ModernLineChart({
    super.key,
    required this.dataPoints,
    required this.xAxisLabels,
    required this.title,
    required this.subTitle,
    this.lineColor = Colors.blue,
    this.lineThickness = 2.0,
    this.gridColor = Colors.grey,
    this.titleColor = Colors.white,
    this.subTitleColor = Colors.grey,
    this.dotColor = Colors.red,
    this.dotRadius = 3.0,
    this.chartHeight = 300,
    this.backgroundColor = Colors.black,
    this.borderColor = Colors.transparent,
    this.labelColor = Colors.grey,
    this.borderRadius = 16.0,
    this.addShadows = true,
    this.showPoints = true,
  });

  List<FlSpot> _convertDataPoints() {
    return List.generate(
      dataPoints.length,
      (index) => FlSpot(index.toDouble(), dataPoints[index]),
    );
  }

  double get maxY =>
      (dataPoints.isNotEmpty
          ? dataPoints.reduce((a, b) => a > b ? a : b)
          : 0.0) *
      1.2;

  double get minY =>
      (dataPoints.isNotEmpty
          ? dataPoints.reduce((a, b) => a < b ? a : b)
          : 0.0) *
      0.8;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: addShadows
            ? [
                BoxShadow(
                  color: lineColor.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : [],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
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
          SizedBox(
            height: chartHeight,
            child: LineChart(
              LineChartData(
                minY: minY,
                maxY: maxY,
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            index >= 0 && index < xAxisLabels.length
                                ? xAxisLabels[index]
                                : '',
                            style: TextStyle(
                              fontSize: 10,
                              color: labelColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12,
                            color: labelColor,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: borderColor, width: 1),
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: true,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: gridColor.withOpacity(0.2),
                    strokeWidth: 0.6,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: gridColor.withOpacity(0.2),
                    strokeWidth: 0.6,
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: lineColor,
                    barWidth: lineThickness,
                    belowBarData: BarAreaData(
                      show: true,
                      color: lineColor.withOpacity(0.4),
                      gradient: LinearGradient(
                        colors: [
                          lineColor.withOpacity(0.1),
                          lineColor.withOpacity(0.4),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    dotData: FlDotData(
                      show: showPoints,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: dotRadius,
                          color: dotColor,
                          strokeWidth: 2,
                          strokeColor: backgroundColor,
                        );
                      },
                    ),
                    spots: _convertDataPoints(),
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
