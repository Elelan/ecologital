import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/item.dart';
import '../home_controller.dart';

class CustomSearchDelegate extends SearchDelegate<Item?> {
  final controller = Get.find<HomeController>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
              showSuggestions(context);
            }
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.location_city, size: 120),
        const SizedBox(height: 48),
        Text(
          query,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 64,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var filteredList = controller.itemList.where((item) {
      String queryText = query.toLowerCase();
      String itemName = item.name.toLowerCase();
      bool startsWith = itemName.startsWith(queryText);
      return startsWith;
    }).toList();
    return buildSuggestionsSuccess(filteredList);
  }

  Widget buildSuggestionsSuccess(List<Item> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.name.substring(0, query.length);
          final remainingText = suggestion.name.substring(query.length);

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 32),
            onTap: () {
              query = suggestion.name;

              // 1. Show Results
              //showResults(context);

              // 2. Close Search & Return Result
              close(context, suggestion);

              // 3. Navigate to Result Page
              //  Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => ResultPage(suggestion),
              //   ),
              // );
            },
            // leading: const Icon(Icons.location_city),
            title: RichText(
                text: TextSpan(
                    text: queryText,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: remainingText,
                      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal))
                    ]
                )
            ),
          );
        },
      );
}
