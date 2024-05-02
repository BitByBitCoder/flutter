import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/controller/comment_controller.dart';
import 'package:testapp/util/smallp.dart';

class SecondScreen extends ConsumerStatefulWidget {
  ScrollController? scrollController;
  SecondScreen({super.key, this.scrollController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SecondScreenState(scrollController);
}

class _SecondScreenState extends ConsumerState<SecondScreen> {
  bool _loading = false;

  ScrollController? secondScroll;
  _SecondScreenState(this.secondScroll);
  @override
  void initState() {
    // secondScroll!.addListener(listentoscroll);
    super.initState();
  }

  // void listentoscroll() async {
  //   print('object');
  //   _loading = true;
  //   if (secondScroll?.position.pixels ==
  //       secondScroll?.position.maxScrollExtent) {
  //     print('object');
  //     await ref.read(controllerCommentProvider.notifier).update();
  //     _loading = false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final _data = ref.watch(controllerCommentProvider);
    return _data.when(data: (data) {
      return ListView.builder(
          controller: secondScroll,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length + 1,
          itemBuilder: (context, index) {
            if (index < data.length) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Color.fromARGB(255, 155, 196, 9),
                  height: 200,
                  width: 400,
                  child: Center(
                      child: Column(
                    children: [
                      Text('${data[index].id}'),
                      Text('${data[index].name}'),
                    ],
                  )),
                ),
              );
            } else if (ref.watch(isloadingProvider)) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }, error: (Error, StackTrace) {
      return Text('OPPs');
    }, loading: () {
      return Center(child: CircularProgressIndicator());
    });
  }
}
