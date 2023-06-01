

import 'package:animation_examples/ui/movie_app/core/constants/constants.dart';
import 'package:animation_examples/ui/movie_app/src/movies/dot_tab_indicator.dart';
import 'package:flutter/material.dart';

import 'movies_view.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> with  SingleTickerProviderStateMixin{
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }
@override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: AppTheme.light,
      home: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            indicator: const DotIndicator(),
            tabs: const [
              Tab(text: 'Movies',),
              Tab(text: 'Series',),
              Tab(text: 'TV shows',)
            ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            MoviesView(),
            SizedBox.expand(),
            SizedBox.expand()
        ]),
      ),
    );
  }
}