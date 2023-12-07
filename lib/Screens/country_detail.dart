import 'package:coronavirus/widgets/reuseableRow.dart';
import 'package:flutter/material.dart';

class CountryDetail extends StatefulWidget {
  const CountryDetail({
    super.key,
    required this.values,
  });
  final Map values;

  @override
  State<CountryDetail> createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.values['country']),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                    child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .06),
                    ReuseableRow(
                        label: 'Total Cases',
                        value: widget.values['cases'].toString()),
                    ReuseableRow(
                        label: 'Recovered',
                        value: widget.values['recovered'].toString()),
                    ReuseableRow(
                        label: 'Active',
                        value: widget.values['active'].toString()),
                    ReuseableRow(
                        label: 'Tests',
                        value: widget.values['tests'].toString()),
                    ReuseableRow(
                        label: 'Deaths',
                        value: widget.values['deaths'].toString()),
                    ReuseableRow(
                        label: 'Critical',
                        value: widget.values['critical'].toString()),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                  ],
                )),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    widget.values['countryInfo']['flag'].toString()),
              )
            ],
          )
        ],
      ),
    );
  }
}
