import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'fsdf',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Query(
              options: QueryOptions(
                document: gql(
                    readRepositories), // this is the query string you just created
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
                  return const Text('Loading');
                }

                Map<String, dynamic> repositories = result.data?['company'];
                print(result.data?['company']);

                if (repositories.isEmpty) {
                  return const Text('No repositories');
                }

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: repositories.length,
                    itemBuilder: (context, index) {
                      final repository = repositories[index];

                      return Text(repository ?? '');
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
