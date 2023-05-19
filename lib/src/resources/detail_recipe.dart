import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_food/src/resources/detail_recipe.dart';
import 'package:recipe_food/src/resources/model/getApiModel.dart';

class DetailRecipe extends StatefulWidget{
  final String lableRecipe;
  DetailRecipe(this.lableRecipe);
  @override
  _DetailRecipeState createState() => _DetailRecipeState();

}

class _DetailRecipeState extends State<DetailRecipe>{
  String name = '' ;
  String urlDetailRecipe = '' ;
  getApiData()async{
    var response = await http.get(Uri.parse(urlDetailRecipe));
    Map json = jsonDecode(response.body);
    print(json['hits']);
    // json['hits'].forEach((e){
    //   Model model = Model(
    //       image: e['recipe']['image'],
    //       url: e['recipe']['url'],
    //       source: e['recipe']['image'],
    //       label: e['recipe']['label']
    //   );
    // });
  }

  @override
  void initState(){
    super.initState();
    name = widget.lableRecipe;
    urlDetailRecipe = "https://api.edamam.com/search?q=$name&app_id=5870bcd8&app_key=4ccf4a8543e018d1bba1c6882c959c66&from=0&to=1&calories=591-722&health=alcohol-free";
    getApiData();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GestureDetector(
        onTap: ()=> Navigator.of(context).pop(),
        child: Container(
          height: 58,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.only(topLeft: Radius.circular(26), topRight: Radius.circular(26))),
          child: Text(
            "Back",
            style: TextStyle(
                fontSize: 24,
                color: Colors.black
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: 50,
          left: 28,
        ),
        child: Text(
          widget.lableRecipe,
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}