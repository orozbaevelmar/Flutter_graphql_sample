import 'package:flutter/material.dart';
import 'package:flutter_graphql_sample/graphQl_fetch.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GraphQlFetchData _graphQlFetchData = GraphQlFetchData();

  Map<String, dynamic>? data; //_graphQlFetchData.fetchData(repository)

  TextEditingController _controller = TextEditingController();

  final String readRepositories = r"""
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

  List<dynamic> list = ['__typename', 'ceo', 'coo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'GraphQl Widget',
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

                return Container(
                  height: 200,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: repositories.length,
                      itemBuilder: (context, index) {
                        final repository = repositories[list[index]];

                        return Text(repository ?? '');
                      }),
                );
              },
            ),
            Container(
              child: Text(
                'GraphQl class => Fetch from another class ',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            _myButton(),
            TextField(
              controller: _controller,
            )
          ],
        ),
      ),
    );
  }

  Widget _myButton() {
    return TextButton(
      onPressed: () async {
        data = await _graphQlFetchData.fetchData();
        setState(() {
          _controller.text = data?['ceo'] ?? '';
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 195,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          'Post',
          style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
        ),
      ),
    );
  }
}
