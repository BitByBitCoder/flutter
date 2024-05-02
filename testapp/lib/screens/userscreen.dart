import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/controller/user_controller.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(userControllerProvider);
    return Scaffold(
        appBar: AppBar(),
        body: data.when(
            data: (data) {
              return Column(
                children: [
                  Text('${data.Name}'),
                  TextButton(
                      onPressed: () {
                        ref
                            .read(userControllerProvider.notifier)
                            .update('ffffff');
                      },
                      child: Text('cl'))
                ],
              );
            },
            error: (Error, StackTrace) {},
            loading: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
