import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/controller/comment_controller.dart';

class GridList extends ConsumerStatefulWidget {
  const GridList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GridListState();
}

class _GridListState extends ConsumerState<GridList> {
  @override
  Widget build(BuildContext context) {
    final _data = ref.watch(controllerCommentProvider);
    return _data.when(data: (data) {
      return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  color: Colors.purpleAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(child: Text("${data[index].id}")),
                      Align(
                          alignment: Alignment.center,
                          child: Text("${data[index].name}"))
                    ],
                  )),
            );
          });
    }, error: (error, StackTrace) {
      return Center(
        child: Text('Opps errror'),
      );
    }, loading: () {
      return CircularProgressIndicator();
    });
  }
}
