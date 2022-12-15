import 'dart:convert';

import 'package:ecologital/data/category.dart';
import 'package:ecologital/ui/home/custom_search_delegate.dart';
import 'package:ecologital/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'transaction_response.dart';
import 'transactions.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<TransactionResponse>? response;
  Future<List<Category>>? categories;

  @override
  void initState() {
    super.initState();
    response = fetchTransactions();
    categories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            title: AppBarRow(),
            backgroundColor: Colors.white,
            pinned: true,
            floating: true,
            snap: true,
            // expandedHeight: 210.0,
            // flexibleSpace: FlexibleSpaceBar(
            //   background: FlexibleBar(),
            // ),
          ),

          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Categories"),
                  Container(
                    height: 100.0,
                    child: FutureBuilder<List<Category>>(
                      future: fetchCategories(),
                      builder: (ctx, snapshot) {
                        if (ConnectionState.active != null && !snapshot.hasData) {
                          return Center(
                            child: Text("loading..."),
                          );
                        }

                        if (ConnectionState.done != null && snapshot.hasError) {
                          return Center(
                            child: Text("Error ${snapshot.error}"),
                          );
                        }
                        return ListView.separated(
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(width: 10,),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Category cat = snapshot.data![index];
                            return Chip(
                              avatar: Image.network(cat.image, color: Colors.white,),
                              label: Text(cat.name),
                              backgroundColor: AppTheme.accentColor,
                              padding: EdgeInsets.all(8),
                              labelStyle: TextStyle(color: Colors.white),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return FutureBuilder(
                future: response,
                builder: (BuildContext context,
                    AsyncSnapshot<TransactionResponse> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Transactions response =
                        snapshot.data!.transactionsList[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Text(
                          response.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: Text(response.type),
                        trailing: response.amount.isNegative
                            ? Text(
                                "${response.amount.toString()}\$",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            : Text(
                                "${response.amount.toString()}\$",
                                style: const TextStyle(color: Colors.green),
                              ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            }, childCount: 17),
          ),
        ],
      ),
    );
  }

  Future<List<Category>> fetchCategories() async {
    await Future.delayed(const Duration(seconds: 2));
    String resultJson = await rootBundle.loadString(Constants.categoriesURL);
    return (jsonDecode(resultJson) as List)
        .map((item) => Category.fromJson(item))
        .toList();
  }

  Future<TransactionResponse> fetchTransactions() async {
    String resultJson = await rootBundle.loadString(Constants.transactionsURL);
    Map<String, dynamic> result = jsonDecode(resultJson);
    TransactionResponse transactionResponse =
        TransactionResponse.fromJson(result);
    return transactionResponse;
  }
}

class AppBarRow extends StatelessWidget {
  AppBarRow({Key? key}) : super(key: key);

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined)),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: AppTheme.bgColor,
                  borderRadius: BorderRadius.circular(30)),
              child: TextField(
                focusNode: focusNode,
                onTap: () {
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                },
                onTapOutside: (event) {
                  focusNode.unfocus();
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search), label: Text("Search")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Constants {
//colors
  static const appBarBackgroundColor = Color(0xFFC2DEEE);
  static const appBarTextColor = Color(0xFF020000);
  static const linearProgressIndicatorColor =
      Color.fromARGB(255, 225, 236, 241);

//endpoints
  static const transactionsURL = "assets/data/transactions.json";
  static const categoriesURL = "assets/data/categories.json";
}

class FlexibleBar extends StatefulWidget {
  const FlexibleBar({Key? key}) : super(key: key);

  @override
  State<FlexibleBar> createState() => _FlexibleBarState();
}

class _FlexibleBarState extends State<FlexibleBar> {
  Future<List<Category>>? response;

  @override
  void initState() {
    super.initState();
    response = fetchCategories();
  }

  Future<List<Category>> fetchCategories() async {
    String resultJson = await rootBundle.loadString(Constants.categoriesURL);
    return (jsonDecode(resultJson) as List)
        .map((item) => Category.fromJson(item))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text("Category"),
          FutureBuilder(
              future: fetchCategories(),
              builder: (context, snapshot) {
                if (ConnectionState.active != null && !snapshot.hasData) {
                  return Center(
                    child: Text("loading..."),
                  );
                }

                if (ConnectionState.done != null && snapshot.hasError) {
                  return Center(
                    child: Text("Error ${snapshot.error}"),
                  );
                }

                return Container(
                  height: 170,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (ctx, count) => const Text("data"),
                  ),
                );
              })
        ],
      ),
    );
  }
}
