import 'package:flutter/material.dart';
import 'package:skyhigh_app/src/charts/Pie_chart/custom_pie_chart.dart';

import 'Bar_chart/bar_chart.dart';

class AllCharts extends StatelessWidget {
  const AllCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          // height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 700,
                width: 400,
                child: Center(child: CustomBarChart()),
              ),
              const SizedBox(
                height: 700,
                width: 400,
                child: Center(child: CustomPieChart()),
              ),
              SizedBox(
                height: 300,
                width: 400,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    color: Colors.amber,
                    height: 300,
                    width: double.maxFinite,
                    child: const Text('data'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement filter pop-up logic here.
          _showFilterPopUp(context);
        },
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}

void _showFilterPopUp(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text('Bar charts'),
            onTap: () {
              Navigator.pushNamed(context, '/barChart');
            },
          ),
          ListTile(
            title: const Text('Composite Bar charts'),
            onTap: () {
              Navigator.pushNamed(context, '/compositeBarChart');
            },
          ),
          ListTile(
            title: const Text('Pie charts'),
            onTap: () {
              Navigator.pushNamed(context, '/pieChart');
            },
          ),
        ],
      );
    },
  );
}
