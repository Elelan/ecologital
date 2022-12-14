import 'package:ecologital/utils/theme.dart';
import 'package:flutter/material.dart';

import '../ui/home/custom_search_delegate.dart';

class MyStoreApp extends StatelessWidget {

  MyStoreApp({Key? key}) : super(key: key);

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          title: Container(
            decoration: BoxDecoration(
                color: AppTheme.bgColor,
                borderRadius: BorderRadius.circular(30.0)),
            child: TextField(
              focusNode: focusNode,
              onEditingComplete: () {
                print("editing complete");
              },
              onSubmitted: (text) {
                print("submitting complete");
                FocusScope.of(context).unfocus();
              },
              autofocus: false,
              maxLines: 1,
              expands: false,
              decoration: InputDecoration(
                  label: Text("Search"),
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none),
              onTap: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.red,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Category"),
                  Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        Chip(avatar: Icon(Icons.face),label: Text("Main dish")),
                        Chip(avatar: Icon(Icons.face),label: Text("Desert")),
                        Chip(avatar: Icon(Icons.face),label: Text("Beverage"))
                      ],
                    ),
                  )
                ],
              ),
            ),

            Container(
              color: Colors.green,
              child: ListView(
                shrinkWrap: true,
                children: [
                  FoodItem(),
                  FoodItem(),
                  FoodItem(),
                  FoodItem()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class FoodItem extends StatelessWidget {
  const FoodItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, offset: Offset(0, -1))
          ]
      ),
      child: Row(
        children: [
          Container(
            child: Image.network("https://static.toiimg.com/thumb/56933159.cms?imgsize=686279&width=800&height=800",
              height: 100,
              width: 100,
              fit: BoxFit.fill,),
          )
        ],
      ),
    );
  }
}
