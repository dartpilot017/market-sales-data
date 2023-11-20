// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:skyhigh_app/service/helper.dart';
import '../sales_model.dart';
import 'barchart_model.dart';
import 'dart:math' as math;

class CompositeBarChartApi extends StatefulWidget {
  const CompositeBarChartApi({Key? key}) : super(key: key);

  @override
  _CompositeBarChartApiState createState() => _CompositeBarChartApiState();
}

class _CompositeBarChartApiState extends State<CompositeBarChartApi> {
  List<SalesModel> sales = [];
  bool loading = true;
  final NetworkHelper _networkHelper = NetworkHelper();
  late double maxMeasureValue;

  String selectedXProperty = 'category'; // Default X-axis property
  String selectedYProperty = 'sales'; // Default Y-axis property

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var response = await _networkHelper.post(
        'https://g54qw205uk.execute-api.eu-west-1.amazonaws.com/DEV/stub',
        {"angular_test": "angular-developer"});
    List<SalesModel> tempdata = salesModelFromJson(response.body);
    setState(() {
      sales = tempdata;
      loading = false;
    });
  }

  List<charts.Series<BarChartModel, String>> _createSampleData() {
    Map<String, double> xSales = {};
    Map<String, double> xProfit = {};

    for (SalesModel salesModel in sales) {
      String xValue = _getPropertyValue(salesModel, selectedXProperty);
      double ySales =
          double.tryParse(_getPropertyValue(salesModel, 'sales')) ?? 0.0;
      double yProfit =
          double.tryParse(_getPropertyValue(salesModel, 'profit')) ?? 0.0;

      xSales[xValue] = (xSales[xValue] ?? 0.0) + ySales;
      xProfit[xValue] = (xProfit[xValue] ?? 0.0) + yProfit;
    }

    // Calculate the maximum Y-axis value for custom axis bounds
    maxMeasureValue = xSales.values.isNotEmpty
        ? xSales.values.reduce((max, value) => value > max ? value : max)
        : 0.0;

    return [
      charts.Series<BarChartModel, String>(
        id: 'Sales',
        data: xSales.entries.map((entry) {
          return BarChartModel(
            sales: entry.key,
            properties: entry.value,
          );
        }).toList(),
        domainFn: (BarChartModel model, _) => model.sales,
        measureFn: (BarChartModel model, _) => model.properties,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
              .withOpacity(1.0),
        ),
      ),
      charts.Series<BarChartModel, String>(
        id: 'Profit',
        data: xProfit.entries.map((entry) {
          return BarChartModel(
            sales: entry.key,
            properties: entry.value,
          );
        }).toList(),
        domainFn: (BarChartModel model, _) => model.sales,
        measureFn: (BarChartModel model, _) => model.properties,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
              .withOpacity(1.0),
        ),
      ),
    ];
  }

  String _getPropertyValue(SalesModel salesModel, String propertyName) {
    switch (propertyName) {
      case 'category':
        return salesModel.category;
      case 'city':
        return salesModel.city;
      case 'country':
        return salesModel.country;
      case 'customerName':
        return salesModel.customerName;
      case 'discount':
        return salesModel.discount;
      case 'orderDate':
        return salesModel.orderDate;
      case 'productName':
        return salesModel.productName;
      case 'profit':
        return salesModel.profit;
      case 'quantity':
        return salesModel.quantity;
      case 'region':
        return salesModel.region;
      case 'sales':
        return salesModel.sales;
      case 'segment':
        return salesModel.segment;
      case 'shipDate':
        return salesModel.shipDate;
      case 'shipMode':
        return salesModel.shipMode;
      case 'state':
        return salesModel.state;
      case 'subCategory':
        return salesModel.subCategory;
      default:
        return '';
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select X and Y Axes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedXProperty,
                onChanged: (newValue) {
                  setState(() {
                    selectedXProperty = newValue!;
                  });
                  Navigator.of(context).pop();
                },
                items: [
                  'category',
                  'city',
                  'country',
                  'customerName',
                  'discount',
                  'orderDate',
                  'productName',
                  'profit',
                  'quantity',
                  'region',
                  'sales',
                  'segment',
                  'shipDate',
                  'shipMode',
                  'state',
                  'subCategory'
                ].map<DropdownMenuItem<String>>((String property) {
                  return DropdownMenuItem<String>(
                    value: property,
                    child: Text(property),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Composite Bar Chart'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            loading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: charts.BarChart(
                      _createSampleData(),
                      animate: true,
                      domainAxis: const charts.OrdinalAxisSpec(
                        renderSpec: charts.SmallTickRendererSpec(
                          labelOffsetFromAxisPx: 12,
                        ),
                      ),
                      primaryMeasureAxis: charts.NumericAxisSpec(
                        viewport: charts.NumericExtents(0, maxMeasureValue),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: const Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text:
                        'Composite Barchart data view of the market sales against selected model and profits against selected model over the last 4 years.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFilterDialog();
        },
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
