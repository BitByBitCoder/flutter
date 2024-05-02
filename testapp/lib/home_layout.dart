import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/controller/comment_controller.dart';
import 'package:testapp/screens/first.dart';
import 'package:testapp/screens/gridlistview.dart';
import 'package:testapp/screens/second.dart';
import 'package:testapp/util/smallp.dart';

class HomeLayout extends ConsumerStatefulWidget {
  const HomeLayout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends ConsumerState<HomeLayout> {
  bool _loading = false;
  final _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(listentoscroll);
    super.initState();
  }

  void listentoscroll() async {
    ref.read(isloadingProvider.notifier).state = true;

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await ref.read(controllerCommentProvider.notifier).update();
      ref.read(isloadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _data = ref.watch(controllerCommentProvider);
    String? ads = ref.watch(adsProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                ref.read(adsProvider.notifier).state = 'hello';
              },
              icon: Icon(Icons.abc))
        ],
        title: Text('Home'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(controllerCommentProvider.notifier)
              .fetchcontrollcomment();
        },
        child: ListView(
          controller: _scrollController,
          children: [
            FirstScreen(),
            if (ads != null)
              Container(
                height: 200,
                width: double.infinity,
                color: const Color.fromARGB(255, 52, 79, 53),
                child: Center(child: Text('${ads}')),
              ),
            GridList()
            // SecondScreen(
            //     // scrollController: _scrollController,
            //     ),
          ],
        ),
      ),
    );
  }
}
