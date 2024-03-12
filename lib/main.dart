import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: mainpage(),
  ));
}

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {

  Map<String, dynamic> weatherdata ={};
  String description = "";
  String temperature = "";
  String city = "";
  String country = "";
  String humidity = "";

  void initState() {
    // TODO: implement initState
    setState(() {
      getweather();
    });
    super.initState();

  }

  Future <void> getweather() async
  {
    final link = "https://api.openweathermap.org/data/2.5/weather?q=Arayats&appid=22001e2c36b023a5543b97049789009f&units=metric";
    final response = await http.get(Uri.parse(link));
    weatherdata = Map<String, dynamic>.from(jsonDecode(response.body));

    if (weatherdata['cod'] == 200)
    {
      setState(() {
        description = weatherdata['weather'][0]['description'].toString();
        temperature = weatherdata['main']['temp'].toString() + "°C";
        city = weatherdata['name'].toString();
        country = weatherdata['sys']['country'].toString();
        humidity = weatherdata['main']['humidity'].toString() + "%";
      });
      print(weatherdata['weather'][0]['description']);
    }
    else if(weatherdata['cod'] == "404")
    {
      setState(() {
        description = "--";
        temperature = "--";
        city = "--";
        country = "--";
        humidity = "--";
      });
      print(weatherdata['cod']);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        'Weather App',
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 4.0),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                SizedBox(
                  width: 5,
                ),
              ],
            )
          ],
        ),
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          double maxWidth = MediaQuery.of(context).size.width;
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: maxWidth,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.deepPurpleAccent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.deepPurpleAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 15),
                              Text(
                                'City: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                city + ", " + country,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 20),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.swap_horiz_sharp),
                                label: Text('change'),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 15),
                            Text(
                              'Wednesday, 13 May',
                              style: TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ],
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                temperature,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 70,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                description,
                                style:
                                TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              Image.asset('assets/cloud-sunny.png',height: 250,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: maxWidth,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.deepPurpleAccent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.deepPurpleAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Temperature :',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              SizedBox(width: 20),
                              Text(
                                temperature,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Humidity  :',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              SizedBox(width: 20),
                              Text(
                                humidity,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Country  :',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              SizedBox(width: 20),
                              Text(
                                country,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
