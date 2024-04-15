import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:r_pagination/Lists_screens/first.dart';
import 'package:r_pagination/Lists_screens/second.dart';
import 'package:r_pagination/controller/comments_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(commentControllerProvider);
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          ref.read(commentControllerProvider.notifier).loadMore();
        }),
        appBar: AppBar(
          title: Text('hello'),
        ),
        body: data.when(
            data: (data) => PageView(),
            error: (Error, StackTrace) {
              return Center(
                  child: Column(
                children: [
                  Text(
                    'OOOOPs',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  TextButton(
                      onPressed: () {
                        ref
                            .read(commentControllerProvider.notifier)
                            .fetchCommentController();
                      },
                      child: Text('Retry'))
                ],
              ));
            },
            loading: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

class PageView extends ConsumerStatefulWidget {
  const PageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PageViewState();
}

class _PageViewState extends ConsumerState<PageView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(commentControllerProvider.notifier).fetchCommentController();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            FirstScreen(),
            SizedBox(
              height: 10,
            ),
            SecondScreen(),
            FirstScreen(),
            SecondScreen(),
          ],
        ),
      ),
    );
  }
}
