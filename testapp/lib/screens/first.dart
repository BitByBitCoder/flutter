import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/controller/comment_controller.dart';

class FirstScreen extends ConsumerStatefulWidget {
  const FirstScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {
  bool _loading = false;
  final _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(listentoscroll);
    super.initState();
  }

  void listentoscroll() async {
    _loading = true;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await ref.read(controllerCommentProvider.notifier).update();
      _loading = false;
    }
  }

  Widget build(BuildContext context) {
    final _data = ref.watch(controllerCommentProvider);
    return Container(
      height: 200,
      width: double.infinity,
      child: _data.when(data: (data) {
        return ListView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: data.length + 1,
            itemBuilder: (context, index) {
              if (index < data.length) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.blue,
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
              } else if (_loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            });
      }, error: (Error, StackTrace) {
        return Text('OPPs');
      }, loading: () {
        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
