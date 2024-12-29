import 'package:cc_essentials/ui/carousels.dart';
import 'package:cc_essentials/ui/line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Widget Testing: LineChartComponent and BannerCarousel', () {
    testWidgets('renders LineChartComponent', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: ModernLineChart(
            title: 'Sample Line Chart',
            subTitle: 'Testing Subtitle',
            xAxisLabels: const ['Jan', 'Feb', 'Mar'],
            yAxisLabels: const ['10', '20', '30'],
            dataPoints: const [
              FlSpot(0, 15),
              FlSpot(1, 25),
              FlSpot(2, 20),
            ],
            lineColor: Colors.blue,
            gridColor: Colors.grey[300]!,
            dotColor: Colors.red,
          )),
        ),
      );
      expect(find.text('Sample Line Chart'), findsOneWidget);
      expect(find.text('Testing Subtitle'), findsOneWidget);
    });

    testWidgets('renders BannerCarousel and taps on images',
        (WidgetTester tester) async {
      const testImages = [
        'https://via.placeholder.com/400x200.png?text=Banner+1',
        'https://via.placeholder.com/400x200.png?text=Banner+2',
      ];

      const testUrls = [
        'https://www.google.com',
        'https://www.github.com',
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BannerCarousel(
              height: 200.0,
              width: double.infinity,
              imageUrls: testImages,
              urlsToNavigate: testUrls,
              autoScroll: false,
              dotColor: Colors.grey,
              activeDotColor: Colors.blue,
              dotsVisible: true,
              borderRadius: 16.0,
            ),
          ),
        ),
      );
      expect(find.byType(Image), findsNWidgets(testImages.length));
      await tester.tap(find.byType(Image).first);
      await tester.pump();
    });
  });
}
