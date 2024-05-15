import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabbarstate/provider.dart';

class Home extends ConsumerStatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    _setInitialIndex();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    ref.read(tabIndexProvider.notifier).state = _tabController.index;
  }

  void _setInitialIndex() {
    final currentIndex = ref.read(tabIndexProvider);
    _tabController.index = currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBar Example'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Cat'),
            Tab(text: 'Dog'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('Cat Tab')),
          Center(child: Text('Dog Tab')),
        ],
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final tabIndex = ref.watch(tabIndexProvider);
          return Text('Current tab index: $tabIndex');
        },
      ),
    );
  }
}
