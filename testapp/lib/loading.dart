import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/controller/comment_controller.dart';
import 'package:testapp/home_layout.dart';
import 'package:testapp/repository/comment_repository.dart';

class Loading extends ConsumerStatefulWidget {
  const Loading({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoadingState();
}

class _LoadingState extends ConsumerState<Loading> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(controllerCommentProvider);
    return Scaffold(
        appBar: AppBar(),
        body: data.when(
            data: (data) {
              return HomeLayout();
            },
            error: (error, StackTrace) {},
            loading: () {
              return Center(
                child: HomeLayout(),
              );
            }));
  }
}
