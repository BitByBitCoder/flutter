import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:r_pagination/controller/comments_controller.dart';

class FirstScreen extends ConsumerStatefulWidget {
  const FirstScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {
  final scontroller = ScrollController();
  bool _isloading = false;
  @override
  void initState() {
    scontroller.addListener(_scrollListener);
    // TODO: implement initState
    super.initState();
  }

  void _scrollListener() {
    if (scontroller.position.pixels == scontroller.position.maxScrollExtent &&
        !_isloading) {
      setState(() {
        _isloading = true;
      });
      ref.read(commentControllerProvider.notifier).loadMore().then((value) {
        setState(() {
          _isloading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    scontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(commentControllerProvider);
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: data.when(data: (data) {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              controller: scontroller,
              itemCount: data.length + 1,
              itemBuilder: (context, index) {
                if (index < data.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amber),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Text('hello'),
                    ),
                  );
                } else {
                  return _isloading
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          child: Text(''),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                        ); // Return an empty container when not loading
                }
              });
        }, error: (error, StackTrace) {
          return Center(
            child: Text('error'),
          );
        }, loading: () {
          Center(child: Text('loading'));
        }));
  }
}
