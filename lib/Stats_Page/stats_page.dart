import 'package:cantin/country.dart';
import 'package:flutter/material.dart';

class StatPage extends StatefulWidget {
  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  List<String> keys;
  List<Widget> countries;
  void lister() {
    List<Widget> list = [];
    for (int index = 0; index < keys.length; index++) {
      String flag = "🚩";
      if (keys[index] != null) {
        if (keys[index].length > 2) {
          flag = (keys[index][0] + keys[index][1])
              .toUpperCase()
              .replaceAllMapped(
                  RegExp(r'[A-Z]'),
                  (match) => String.fromCharCode(
                      match.group(0).codeUnitAt(0) + 127397));
        } else {
          flag = (keys[index]).toUpperCase().replaceAllMapped(
              RegExp(r'[A-Z]'),
              (match) =>
                  String.fromCharCode(match.group(0).codeUnitAt(0) + 127397));
        }
      }
      list.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    alignment: Alignment.center,
                    child: (data[keys[index]].location != null)
                        ? Text(
                            data[keys[index]].location.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          )
                        : Text("India"),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 100,
                    alignment: Alignment.center,
                    child: Text(flag, style: TextStyle(fontSize: 16)),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 150,
                    alignment: Alignment.center,
                    child: (data[keys[index]].totalCases == null)
                        ? Text("0")
                        : Text(data[keys[index]]
                            .totalCases
                            ?.toInt()
                            .toString()
                            .replaceAllMapped(
                                new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => '${m[1]},')),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 150,
                    alignment: Alignment.center,
                    child: (data[keys[index]].totalDeaths == null)
                        ? Text("0")
                        : Text(data[keys[index]]
                            .totalDeaths
                            ?.toInt()
                            .toString()
                            .replaceAllMapped(
                                new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => '${m[1]},')),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 150,
                    alignment: Alignment.center,
                    child: (data[keys[index]].totalVaccinations == null)
                        ? Text("0")
                        : Text(data[keys[index]]
                            .totalVaccinations
                            ?.toInt()
                            .toString()
                            .replaceAllMapped(
                                new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => '${m[1]},')),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ),
      );
    }
    countries = list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Today's Statistics",
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: FutureBuilder(
          future: Future.wait([
            getDeets().then((value) {
              data = value;
              keys = value.keys.toList();
              lister();
              setState(() {});
              return 5;
            }),
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Row(
                                children: [
                                  Container(
                                      child: Text("Country"),
                                      width: 150,
                                      alignment: Alignment.center),
                                  SizedBox(width: 10),
                                  Container(
                                      child: Text("Flag"),
                                      width: 100,
                                      alignment: Alignment.center),
                                  SizedBox(width: 10),
                                  Container(
                                      child: Text("Total Cases"),
                                      width: 150,
                                      alignment: Alignment.center),
                                  SizedBox(width: 10),
                                  Container(
                                      child: Text("Total Deaths"),
                                      width: 150,
                                      alignment: Alignment.center),
                                  SizedBox(width: 10),
                                  Container(
                                      child: Text("Total Vaccinated"),
                                      width: 150,
                                      alignment: Alignment.center),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: countries,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
