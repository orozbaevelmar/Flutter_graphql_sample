import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FetchData {
  void main_1() async {
    await initHiveForFlutter();

    final HttpLink httpLink =
        HttpLink('https://spacex-production.up.railway.app/');

    final AuthLink authLink =
        AuthLink(getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>');

    final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(
          store: HiveStore(),
        ),
      ),
    );
    runApp(
      MyApp1(client: client),
    );
  }
}

class MyApp1 extends StatelessWidget {
  ValueNotifier<GraphQLClient>? client;
  MyApp1({this.client});

  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        home: HomeScreen1(),
      ),
    );
  }
}

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  final String _readRepositories = r"""
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

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(_readRepositories),
        variables: {'name': 'users'},
        pollInterval: const Duration(seconds: 10),
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          print(result.exception);
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return const Text('Is Loading...');
        }

        Map<String, dynamic> repositories = result.data?['company'];
        List<dynamic> list = ['_typeName', 'ceo', 'coo'];

        if (repositories.isEmpty) {
          return const Text('No repositories');
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: repositories.length,
            itemBuilder: (context, index) {
              final repository = repositories[list[index]];

              return Text(repository ?? '');
            });
      },
    );
  }
}
