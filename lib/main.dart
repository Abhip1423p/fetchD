import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: homePage());
  }
}

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String stringResponse = "";

  List listResponse = [];

List facts = [];     // squre bracekts is use to  for list

 Map mapResponse  ={}; // for map

  Future fetchData() async {
    http.Response response;
    response = await http
        .get(Uri.parse("https://www.thegrowingdeveloper.org/apiview?id=2"));

    if (response.statusCode == 200) {
      setState(() {
        // stringResponse = response.body; // this for single string
        // listResponse = json.decode(response.body);
        mapResponse = json.decode(response.body);

        facts = mapResponse['facts'];
      });
    }
  }
// call this method

  @override
  void initState() {
    // TODO: implement initState

    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "data",
        ),
        backgroundColor: Colors.blue[900],
      ),

      body: mapResponse == null
          ? Container()
          : SingleChildScrollView(
            child: Column(
                children: [
                  Text(
                    mapResponse["category"].toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  
                 ListView.builder(
                   shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),

                     itemCount: facts.length,
                     itemBuilder: (BuildContext context, int index){

                       return Container(
                         child: Column(
                           children: [
                             Image.network(facts[index]["image_url"]),
                             Text(
                               facts[index]["title"].toString(),
                               style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),


                           ],



                         ),



                       );

                     }



                 )
                ],
              ),
          ),

      // ListView.builder(
      //   itemCount: listResponse.length,
      //   itemBuilder: (BuildContext context, int index) {
      //
      //     return  Card(
      //       elevation: 5,
      //       color: Colors.blue,
      //       child: ListTile(
      //         leading: Icon(Icons.album),
      //         title: Text('${listResponse[index]}'),
      //
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

//
// listResponse == null
// ? Container(
//
// )
//     : Text(
// listResponse.toString(),
// style: TextStyle(
// fontSize: 20,
// fontWeight: FontWeight.bold,
// ),
// ),
