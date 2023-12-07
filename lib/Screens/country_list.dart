// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:coronavirus/Screens/country_detail.dart';
import 'package:shimmer/shimmer.dart';
import 'package:coronavirus/widgets/colorList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController searchController = TextEditingController();
  Future<List<dynamic>> countryListApi() async {
    var data;
    Response response =
        await get(Uri.parse('https://disease.sh/v3/covid-19/countries'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      return throw Exception('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Search Country',
                  hintStyle: TextStyle(color: whitecolor)),
            ),
          ),
          FutureBuilder(
              future: countryListApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Container(
                                height: 150,
                                width: 80,
                                color: whitecolor,
                              ),
                              title: Container(
                                height: 10,
                                width: 100,
                                color: whitecolor,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 100,
                                color: whitecolor,
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CountryDetail(
                                                values: snapshot.data![index],
                                              )));
                                },
                                child: ListTile(
                                  leading: SizedBox(
                                    height: 50,
                                    width: 60,
                                    child: Image.network(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                    'Active cases: ${snapshot.data![index]['active']}',
                                    style: TextStyle(color: whitecolor),
                                  ),
                                ),
                              ),
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CountryDetail(
                                                values: snapshot.data![index],
                                              )));
                                },
                                child: ListTile(
                                  leading: SizedBox(
                                    height: 50,
                                    width: 60,
                                    child: Image.network(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                    'Active cases: ${snapshot.data![index]['active']}',
                                    style: TextStyle(color: whitecolor),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                  );
                }
              })
        ],
      ),
    );
  }
}
