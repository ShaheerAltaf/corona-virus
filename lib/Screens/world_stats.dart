// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:coronavirus/Screens/country_list.dart';
import 'package:coronavirus/Utils/utils.dart';
import 'package:coronavirus/model.dart';
import 'package:coronavirus/widgets/colorList.dart';
import 'package:coronavirus/widgets/reuseableRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> {
  @override
  void initState() {
    data();
    super.initState();
  }

  Future data() async {
    try {
      Response response =
          await get(Uri.parse('https://disease.sh/v3/covid-19/all'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          Utils.covidDataModel = CovidDataModel.fromJson(data);
        });
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Utils.covidDataModel == null
            ? Center(
                child: SizedBox(
                  child: SpinKitFadingCircle(
                    size: 50,
                    color: whitecolor,
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                        future: data(),
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05),
                              PieChart(
                                dataMap: {
                                  'Total':
                                      Utils.covidDataModel?.cases?.toDouble() ??
                                          0.0,
                                  'Recovered': Utils.covidDataModel?.recovered!
                                          .toDouble() ??
                                      0.0,
                                  'Death': Utils.covidDataModel?.deaths!
                                          .toDouble() ??
                                      0.0
                                },
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValuesInPercentage: true),
                                colorList: colorList,
                                animationDuration:
                                    const Duration(milliseconds: 1200),
                                chartType: ChartType.ring,
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3,
                                legendOptions: const LegendOptions(
                                    legendPosition: LegendPosition.left),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Card(
                                  child: Column(
                                    children: [
                                      ReuseableRow(
                                        label: 'Total Cases',
                                        value: Utils.covidDataModel?.cases
                                                ?.toString() ??
                                            "",
                                      ),
                                      ReuseableRow(
                                        label: 'Deaths',
                                        value: Utils.covidDataModel?.deaths
                                                ?.toString() ??
                                            "",
                                      ),
                                      ReuseableRow(
                                        label: 'Recovered',
                                        value: Utils.covidDataModel?.recovered
                                                ?.toString() ??
                                            "",
                                      ),
                                      ReuseableRow(
                                        label: 'Active',
                                        value: Utils.covidDataModel?.active
                                                ?.toString() ??
                                            "",
                                      ),
                                      ReuseableRow(
                                        label: 'Critical',
                                        value: Utils.covidDataModel?.critical
                                                ?.toString() ??
                                            "",
                                      ),
                                      ReuseableRow(
                                        label: 'Today Deaths',
                                        value: Utils.covidDataModel?.todayDeaths
                                                ?.toString() ??
                                            "",
                                      ),
                                      ReuseableRow(
                                        label: 'Today Recovered',
                                        value: Utils
                                                .covidDataModel?.todayRecovered
                                                ?.toString() ??
                                            "",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.05),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CountryList()));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: greenColor),
                                    child: const Center(
                                        child: Text(
                                      'Track Countries',
                                      style: TextStyle(fontSize: 18),
                                    )),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  ],
                ),
              ),
      ),
    );
  }
}
