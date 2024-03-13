import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: MainPage(),
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<String, dynamic> weatherData = {};
  String description = "";
  String temperature = "";
  String city = "";
  String country = "";
  String humidity = "";
  String search = "";
  String icon = "";
  TextEditingController searchController = TextEditingController(text: "Arayat");


  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future<void> getWeather() async {
    search = searchController.text;

    try
    {
      final link =
          "https://api.openweathermap.org/data/2.5/weather?q=$search&appid=22001e2c36b023a5543b97049789009f&units=metric";
      final response = await http.get(Uri.parse(link));
      weatherData = Map<String, dynamic>.from(jsonDecode(response.body));
    }
    catch(e) {
      description = "--";
      temperature = "--";
      city = "--";
      country = "--";
      humidity = "--";
      search = "";
      icon = "";
    }


    if (weatherData['cod'] == 200) {
      String img = weatherData['weather'][0]['icon'];
      setState(() {
        description = weatherData['weather'][0]['description'].toString();
        temperature = weatherData['main']['temp'].toString() + "°C";
        city = weatherData['name'].toString();
        country = weatherData['sys']['country'].toString();
        humidity = weatherData['main']['humidity'].toString() + "%";
        icon = "https://openweathermap.org/img/wn/$img@2x.png";
      });
    } else if (weatherData['cod'] == "404") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('City Not Found'),
            content: Text('Please check your input and try again. '),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
    else if (weatherData['cod'] == "400") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('City cannot be blank'),
            content: Text('Please check your input and try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

    }
    else
      {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Something Went Wrong'),
              content: Text('Please Check Your Internet Connection and try again.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat.yMMMMd('en_US').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
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
                        'QuickWeather',
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 4.0),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 300,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      labelText: 'Search',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            getWeather();
                          });
                        },
                        icon: const Icon(Icons.search),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
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
                SizedBox(height: 20,),
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

                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 15),
                            Text(
                              currentDate,
                              style:
                              TextStyle(fontSize: 20, color: Colors.grey),
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              if (icon.isNotEmpty) // Check if icon is not empty
                                Image.network(
                                  icon,
                                  height: 150,
                                ),
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
