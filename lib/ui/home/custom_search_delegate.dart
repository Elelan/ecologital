import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return ([IconButton(onPressed: () {}, icon: const Icon(Icons.close))]);
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
    // TODO: implement buildResults
    return Column(
      children: const [Text("item 1"), Text("item 2")],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}