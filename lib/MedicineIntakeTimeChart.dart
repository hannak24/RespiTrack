import 'package:time_chart/time_chart.dart';
import 'package:flutter/material.dart';

class MedicineIntakeTimeChart extends StatelessWidget {

  // Data must be sorted.
  final data = [
    DateTimeRange(
      start: DateTime(2021,2,24,18,0),
      end: DateTime(2021,2,24,23,59),
    ),
    DateTimeRange(
      start: DateTime(2021,2,24,10,0),
      end: DateTime(2021,2,24,10,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,23,18,0),
      end: DateTime(2021,2,23,18,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,23,10,0),
      end: DateTime(2021,2,23,10,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,22,18,00),
      end: DateTime(2021,2,22,18,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,22,10,0),
      end: DateTime(2021,2,22,18,0),
    ),
    DateTimeRange(
      start: DateTime(2021,2,21,18,0),
      end: DateTime(2021,2,21,18,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,21,10,0),
      end: DateTime(2021,2,21,16,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,20,18,0),
      end: DateTime(2021,2,20,18,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,20,10,0),
      end: DateTime(2021,2,20,10,30),
    ),
    DateTimeRange(
      start: DateTime(2021,2,19,18,0),
      end: DateTime(2021,2,19,19,0),
    ),
    DateTimeRange(
      start: DateTime(2021,2,19,10,0),
      end: DateTime(2021,2,19,10,10),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final sizedBox = const SizedBox(height: 16);

    return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Weekly routine inhaler use time'),
              SizedBox(height: 10),
              TimeChart(
                data: data,
                viewMode: ViewMode.weekly,
              ),]
    ));
      // Scaffold(
      //   body: SingleChildScrollView(
      //     child: Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Column(
      //         children: [
      //           const Text('Weekly time chart'),
      //           TimeChart(
      //             data: data,
      //             viewMode: ViewMode.weekly,
      //           ),
      //           // sizedBox,
      //           // const Text('Monthly time chart'),
      //           // TimeChart(
      //           //   data: data,
      //           //   viewMode: ViewMode.monthly,
      //           //),
      //         ],
      //       ),
      //     ),
      //   ),
      // );
  }
}
