import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../charts/SimpleScatterPlotChart.dart';

class timeRangeScatterGraph extends StatefulWidget {
  const timeRangeScatterGraph({Key? key}) : super(key: key);

  @override
  State<timeRangeScatterGraph> createState() => _timeRangeScatterGraphState();
}

class _timeRangeScatterGraphState extends State<timeRangeScatterGraph> {

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 11, 5),
    end: DateTime(2022, 12, 24),
  );


  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

    return CustomScrollView(

      // height: MediaQuery
      //   .of(context)
      //   .viewInsets
      //   .bottom,
      slivers:<Widget>  [
        SliverList(

        delegate: SliverChildListDelegate([
            Center(
              child: Text('Date Range', style: TextStyle(fontSize: 17),),
            ) ,
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text(DateFormat('yyyy/MM/dd').format(start)),
                    onPressed: pickDateRange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    child: Text(DateFormat('yyyy/MM/dd').format(end)),
                    onPressed: pickDateRange,
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
            Container(
              height: 300,
              child:SimpleScatterPlotChartDB(dateRange.start, dateRange.end), ),


          ]
      ),
      ),
    ]
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (newDateRange == null) return; // pressed 'X'

    setState(() => dateRange = newDateRange);
  }
}
