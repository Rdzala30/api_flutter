import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API App',
      home: MyHomePage(),
    );
  }
}

var stringResponse = "";

var mapResponse = <dynamic, dynamic>{};

var dataResponse = <dynamic, dynamic>{};

var listResponse = <dynamic>[];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=1"));
    // Link for page 2
    //"https://reqres.in/api/users?page=2"

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API DATA' ,
          style: TextStyle(
            color: Colors.white38,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ) ,
        backgroundColor: const Color.fromARGB(200, 20, 45, 215),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                child: Card(
                  margin: const EdgeInsets.all(10.0),
                  color: const Color.fromARGB(255, 187, 192, 251),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Image.network(listResponse[index]['avatar']),
                      ),
                      ListTile(
                        title: Text(
                          '${listResponse[index]['id']}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: CupertinoColors.extraLightBackgroundGray,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              ' ${listResponse[index]['first_name']} ${listResponse[index]['last_name']}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 10, 0, 77),
                                fontSize: 36,
                              ),
                            ),
                            Text(
                              ' ${listResponse[index]['email']}',
                              style: const TextStyle(
                                color: Colors.black26,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
       itemCount: listResponse == Exception ? 0 : listResponse.length,
      ),
    );
  }
}
