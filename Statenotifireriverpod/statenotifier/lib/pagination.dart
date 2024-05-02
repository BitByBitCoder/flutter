import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:statenotifier/model/movie.dart';

class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  final scontoller = ScrollController();
  int paginate = 1;
  Movie? movie;
  bool loading = true;
  bool gettingmoredata = false;
  Future fetchMovie(pag) async {
    if (gettingmoredata) return;

    setState(() {
      gettingmoredata = true;
    });
    print(pag);
    final response = await http.get(Uri.parse(
        'http://www.omdbapi.com/?apikey=8e047b9a&s=Batman&page=$pag'));
    final result = convert.jsonDecode(response.body);
    // List data = result['Search'];

    movie = Movie.fromJson(result);
    print("${movie?.search?[1].title}");
    setState(() {
      loading = false;
      gettingmoredata = false;
    });
  }

  @override
  void initState() {
    scontoller.addListener(() {
      if (scontoller.position.pixels == scontoller.position.maxScrollExtent) {
        paginate = paginate + 1;
        fetchMovie(paginate);
      }
    });
    fetchMovie(1);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: loading
            ? Text('Loading')
            : ListView.builder(
                controller: scontoller,
                itemCount: movie!.search!.length + (gettingmoredata ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == movie!.search!.length) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return ListTile(
                    leading: Text('$index'),
                    title: Text(
                      '${movie!.search![index].title}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                    ),
                  );
                }));
  }
}
