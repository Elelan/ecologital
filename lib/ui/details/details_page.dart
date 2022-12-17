import 'package:ecologital/app/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/item.dart';
import '../../data/unit_type.dart';
import '../../utils/theme.dart';

class DetailsPage extends StatelessWidget {
  static const routeName = "/detail";

  DetailsPage({Key? key}) : super(key: key);

  Item item = Item(
      id: "6393264316c9ce0d05aed147",
      name: "Chicken Pizza",
      image:
          "https://media-cdn.tripadvisor.com/media/photo-s/08/b3/38/cf/pizza-milano.jpg",
      categoryId: "6393203716c9ce0d05a63b14",
      categoryName: "Main Dish",
      price: 950,
      unitType: [
        UnitType(name: "Size", value: "Regular", price: 720),
        UnitType(name: "Size", value: "Large", price: 950),
      ],
      description:
          "Labore exercitation adipisicing occaecat velit officia commodo occaecat laboris qui cupidatat veniam fugiat. Veniam laborum cillum anim ullamco qui non aliqua ad veniam velit adipisicing nostrud. Nostrud laborum do est dolore aliquip consequat id. Et ut do minim minim aliqua tempor amet est. Proident excepteur pariatur deserunt cillum velit aliqua incididunt voluptate laborum.\r\n");

  final formatCurrency = new NumberFormat.simpleCurrency();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppTheme.bgColor,
              bottom:
                  PreferredSize(child: Container(), preferredSize: Size(0, 20)),
              pinned: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              collapsedHeight: MediaQuery.of(context).size.height * 0.1,
              flexibleSpace: Stack(
                children: [
                  Positioned(
                    child: Image.network(
                      item.image,
                      fit: BoxFit.cover,
                    ),
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                  ),
                  Positioned(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: AppTheme.bgColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(50))),
                    ),
                    bottom: -1,
                    left: 0,
                    right: 0,
                  )
                ],
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("---")],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.name),
                        IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ActionChip(label: Text("L")),
                        ActionChip(label: Text("M"))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rs ${item.price.toStringAsFixed(2)}"),

                        Container(
                          child: Row(
                            children: [
                              Text("-"),
                              Text("1"),
                              Text("+")
                            ],
                          ),
                        )
                      ],
                    ),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(height: 3,thickness: 3,),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Add to cart'),
            style: ElevatedButton.styleFrom(
                primary: AppTheme.accentColor,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
          ),
        ));
  }
}
