import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_food/src/resources/model/getApiModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Model> list = <Model>[];
  final url = "https://api.edamam.com/search?q=chicken&app_id=5870bcd8&app_key=4ccf4a8543e018d1bba1c6882c959c66&from=0&to=100&calories=591-722&health=alcohol-free";
  getApiData()async{
    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    json['hits'].forEach((e){
      Model model = Model(
        image: e['recipe']['image'],
        url: e['recipe']['url'],
        source: e['recipe']['image'],
        label: e['recipe']['label']
      );
      setState(() {
        list.add(model);
      });
    });
  }

  @override
  void initState(){
    super.initState();
    getApiData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text("Recipe")),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),

                  ),
                  fillColor: Colors.green.withOpacity(0.04),
                  filled: true,
                ),
              ),
              SizedBox(
                  height: 15
              ),
              GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                  primary: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5
              ),
                  itemCount: list.length,
                  itemBuilder: (context, i){
                  final x = list[i];
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(x.image.toString())
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.black,
                        height: 40,
                        child: Text(
                            x.label.toString(),
                            style: TextStyle(
                                color: Colors.yellow,
                              fontSize: 16,
                            ),
                        ),
                      ),
                      Container()
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
