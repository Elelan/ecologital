import 'package:ecologital/data/item.dart';
import 'package:flutter/material.dart';

import '../../utils/theme.dart';

const double imageHeight = 120;

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      // clipBehavior: Clip.antiAlias,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(8),
        child: Row(children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(item.image), fit: BoxFit.fill)),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 14,
            child: Container(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(item.name,
                      style: AppTheme.titleStyle
                  ),
                  const SizedBox(height: 8,),
                  Text(item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.subTextStyle
                  ),
                  const SizedBox(height: 8,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(item.categoryName, style: AppTheme.titleStyle,),
                        Text("Rs ${item.price}", style: AppTheme.titleStyle)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.favorite_border,
                    color: AppTheme.accentColor,)),
                ),
              ))
        ]),
      ),
    );
  }
}
