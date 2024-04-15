import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:r_pagination/controller/comments_controller.dart';

class SixScreen extends ConsumerStatefulWidget {
  const SixScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SixScreenState();
}

class _SixScreenState extends ConsumerState<SixScreen> {
  final _scrollController = ScrollController();
  bool _isloading = false;
  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    // TODO: implement initState
    super.initState();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isloading) {
      print('hello bottom');
      setState(() {
        _isloading = true;
      });
      await ref.read(commentControllerProvider.notifier).loadMore();
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(commentControllerProvider);

    return data.when(
        data: (data) {
          return GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: data.length + 1,
              controller: _scrollController,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                if (index < data.length) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.black,
                    ),
                  );
                } else {
                  return _isloading
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          child: Text(''),
                          width: MediaQuery.of(context).size.width,
                        ); //
                }
              });
        },
        error: ((error, stackTrace) => Text('error')),
        loading: () {
          return CircularProgressIndicator();
        });
  }
}
