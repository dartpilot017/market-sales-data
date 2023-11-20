// chart_utils.dart

import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:skyhigh_app/src/utils/charts_model.dart';
import 'dart:math' as math;

import '../charts/sales_model.dart';

List<charts.Series<ChartsModel, String>> createSampleData(
  List<SalesModel> sales,
  String selectedXProperty,
  String selectedYProperty,
) {
  Map<String, double> xSales = {};

  for (SalesModel salesModel in sales) {
    String xValue = getPropertyValue(salesModel, selectedXProperty);
    double yValue =
        double.tryParse(getPropertyValue(salesModel, selectedYProperty)) ?? 0.0;

    xSales[xValue] = (xSales[xValue] ?? 0.0) + yValue;
  }

  return [
    charts.Series<ChartsModel, String>(
      id: 'Sales',
      data: xSales.entries.map((entry) {
        return ChartsModel(
          xAxis: entry.key,
          yAxis: entry.value,
        );
      }).toList(),
      domainFn: (ChartsModel model, _) => model.xAxis,
      measureFn: (ChartsModel model, _) => model.yAxis,
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(1.0),
      ),
    ),
  ];
}

String getPropertyValue(SalesModel salesModel, String propertyName) {
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
      return ''; // Handle the case when columnName doesn't match any of the options.
  }
}

void showFilterDialog(BuildContext context, String selectedXProperty) {
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
                Navigator.of(context)
                    .pop(newValue); // Pass the selected value back
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
