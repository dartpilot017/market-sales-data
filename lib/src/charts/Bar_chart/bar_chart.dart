import 'package:flutter/material.dart';

import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:skyhigh_app/src/charts/Bar_chart/barchart_model.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({super.key});

  // ignore: non_constant_identifier_names
  static List<charts.Series<BarChartModel, String>> _createSampleData() {
    final data = [
      BarChartModel(sales: '2017', properties: 20),
      BarChartModel(sales: '2016', properties: 13),
      BarChartModel(sales: '2015', properties: 8),
      BarChartModel(sales: '2014', properties: 15),
    ];
    return [
      charts.Series<BarChartModel, String>(
          data: data,
          id: 'sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (BarChartModel barChartModel, _) => barChartModel.sales,
          measureFn: (BarChartModel barChartModel, _) =>
              barChartModel.properties)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 400,
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                    text:
                        'A sample demo Barchart. \n To get started, click on the filter button to select amongs the options (Barchart, Piechart, and Timeseries chat) what chat to display',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.withOpacity(0.5))),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 300,
                child: charts.BarChart(
                  _createSampleData(),
                  animate: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
