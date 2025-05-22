import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FetchData {
  //List<dynamic> list = [];
  //bool loading = false;
  /* void fetchData() async {
    //setState(){
    //loading = true;
    //}

    HttpLink httpLink = HttpLink(
        "https://studio.apollographql.com/public/SpaceX-pxxbxen/variant/current/explorer");

    GraphQLClient qlClient = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );

    QueryResult queryResult = await qlClient.query(
      QueryOptions(
        document: gql(r"""
              query ($name: String!) {
                __type(name: $name) {
                name 
                }
                company {
                  ceo
                  summary
                  coo
                  employees
                  founded
                  vehicles
                  founder
                  launch_sites
                  name
                }
              }
          """),
        variables: {
          'name': 'users',
        },
      ),
    );

    if (queryResult.hasException) {
            return Text('Error: ${queryResult.exception.toString()}');
          }

          if (queryResult.isLoading) {
            return Text('Loading...');
          }

          final data =queryResult.data;

          //data['items'].length,
          //data['items][index]
          //  final item = data['items'][index];
          // item['title']
          // item['description']

    //setState(){
    //list = queryResult.data!['company'];
    //loading = true;
    //loading = false;
    //}
  } */
}
