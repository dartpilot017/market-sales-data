// import 'package:flutter/material.dart';
// import 'package:charts_flutter_new/flutter.dart' as charts;
// import 'package:skyhigh_app/service/helper.dart';
// import '../sales_model.dart';
// import 'time_series_model.dart'; // Import your TimeSeriesSales model here
// import 'dart:math' as math;

// import 'package:intl/intl.dart';

// class TimeSeriesChartApi extends StatefulWidget {
//   const TimeSeriesChartApi({Key? key}) : super(key: key);

//   @override
//   _TimeSeriesChartApiState createState() => _TimeSeriesChartApiState();
// }

// class _TimeSeriesChartApiState extends State<TimeSeriesChartApi> {
//   List<SalesModel> sales = [];
//   bool loading = true;
//   NetworkHelper _networkHelper = NetworkHelper();
//   List<TimeSeriesSales> _chartData = [];

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   void getData() async {
//     var response = await _networkHelper.post(
//       'https://g54qw205uk.execute-api.eu-west-1.amazonaws.com/DEV/stub',
//       {"angular_test": "angular-developer"},
//     );
//     List<SalesModel> tempdata = salesModelFromJson(response.body);
//     setState(() {
//       sales = tempdata;
//       loading = false;
//       _updateChartData();
//     });
//   }

//   void _updateChartData() {
//     // Update _chartData based on sales
//     List<TimeSeriesSales> updatedData = [];

//     for (var salesModel in sales) {
//       DateTime time;
//       double profit;

//       try {
//         final originalFormat = DateFormat('dd/MM/yyyy');
//         final date = originalFormat.parse(salesModel.orderDate);
//         final newFormat = DateFormat('yyyy-MM-dd');
//         final formattedDate = newFormat.format(date);

//         time = DateTime.parse(formattedDate);
//         profit = double.tryParse(salesModel.profit) ?? 0.0;

//         updatedData.add(TimeSeriesSales(time, profit));
//       } catch (e) {
//         // Handle parsing errors here, if necessary
//         print('Error parsing data: $e');
//       }
//     }

//     // Set _chartData with the updated data
//     setState(() {
//       _chartData = updatedData;
//     });
//   }

//   List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
//     return [
//       charts.Series<TimeSeriesSales, DateTime>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.ColorUtil.fromDartColor(
//           Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
//               .withOpacity(1.0),
//         ),
//         domainFn: (TimeSeriesSales sales, _) => sales.time,
//         measureFn: (TimeSeriesSales sales, _) => sales.sales,
//         data: _chartData,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Time Series Chart'),
//       ),
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             loading
//                 ? CircularProgressIndicator()
//                 : Container(
//                     height: 200,
//                     width: 400,
//                     child: charts.TimeSeriesChart(
//                       _createSampleData()
//                           .cast<charts.Series<dynamic, DateTime>>(),
//                       animate: true,
//                       defaultInteractions: true,
//                     ),
//                   ),
//             SizedBox(
//               height: 30,
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(
//                 horizontal: 5,
//               ),
//               child: Text.rich(
//                 TextSpan(children: [
//                   TextSpan(
//                     text: 'Time series data view to show the profit over time.',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ]),
//                 textAlign: TextAlign.start,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
