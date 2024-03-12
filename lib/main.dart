import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
                                'Santa Ana',
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
                                '20 °C',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 70,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Rain',
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
                                '20 °C',
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
                                '35 %',
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
                                'Philippines',
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
