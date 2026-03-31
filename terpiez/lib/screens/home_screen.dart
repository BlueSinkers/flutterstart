import 'package:flutter/material.dart';

import 'package:terpiez/widgets/finder_tab.dart';
import 'package:terpiez/widgets/list_tab.dart';
import 'package:terpiez/widgets/stats_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Terpiez'),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Stats'),
                Tab(text: 'Finder'),
                Tab(text: 'List'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              StatsTab(),
              FinderTab(),
              ListTab(),
            ],
          ),
        ),
      ),
    );
  }
}
