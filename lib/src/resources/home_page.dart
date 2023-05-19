import 'dart:convert';


import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_food/src/resources/detail_recipe.dart';
import 'package:recipe_food/src/resources/model/getApiModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Model> list = <Model>[];
  String? text;
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
      appBar: AppBar(
        elevation: 0,
        title: Text('recipe'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                onChanged: (v) {
                  text = v;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Searchpage(
                                search: text,
                              )));
                    },
                    icon: Icon(Icons.search),
                  ),
                  hintText: "tìm kiếm công thức",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.green.withOpacity(0.04),
                  filled: true,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPage(
                                  url: x.url,
                                )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(x.image.toString()),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(3),
                              height: 40,
                              color: Colors.grey.withOpacity(0.5),
                              child: Center(
                                child: Text(
                                  x.label.toString(),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(3),
                              height: 40,
                              color: Colors.grey.withOpacity(0.5),
                              child: Center(
                                child: Text(
                                  "Source: " + x.source.toString(),
                                ),
                              ),
                            ),
                          ],
                        ),
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

class WebPage extends StatelessWidget {
  final url;
  WebPage({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: url,
        ),
      )
    );
  }
}

class Searchpage extends StatefulWidget {
  String? search;
  Searchpage({this.search});
  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  List<Model> list = <Model>[];
  String? text;

  Future<void> getApiData(search) async {
    final url =
        'https://api.edamam.com/search?q=${search}&app_id=5870bcd8&app_key=4ccf4a8543e018d1bba1c6882c959c66&from=0&to=100&calories=591-722&health=alcohol-free';
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> json = jsonDecode(response.body);
    json['hits'].forEach((e) {
      Model model = Model(
        url: e['recipe']['url'],
        image: e['recipe']['image'],
        source: e['recipe']['source'],
        label: e['recipe']['label'],
        // other properties
      );
      setState(() {
        list.add(model);
      });
      // use the model object
    });
  }

  @override
  void initState() {
    super.initState();
    getApiData(widget.search);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('recipe'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPage(
                                  url: x.url,
                                )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(x.image.toString()),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(3),
                              height: 40,
                              color: Colors.grey.withOpacity(0.5),
                              child: Center(
                                child: Text(
                                  x.label.toString(),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(3),
                              height: 40,
                              color: Colors.grey.withOpacity(0.5),
                              child: Center(
                                child: Text(
                                  "Source: " + x.source.toString(),
                                ),
                              ),
                            ),
                          ],
                        ),
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
