import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlFetchData {
  String readRepositories = r"""
query ($name: String!) {
  __type(name: $name) {
   name 
  }
  company {
    ceo
    coo
  }
}
""";

  dynamic fetchData() async {
    final HttpLink httpLink =
        HttpLink('https://spacex-production.up.railway.app/');

    final GraphQLClient _graphQLClient = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );

    final QueryOptions queryOptions = QueryOptions(
      document: gql(readRepositories),
      variables: {'name': 'users'},
    );

    final QueryResult queryResult = await _graphQLClient.query(queryOptions);

    if (queryResult.hasException) {
      throw Exception('Error : ${queryResult.exception.toString()}');
    } else if (queryResult.isLoading) {
      print('Is loading...');
    }

    Map<String, dynamic> repository = queryResult.data?['company'];
    return repository;
    // queryResult.data?['characters']?['company]?['ceo];
  }
}
