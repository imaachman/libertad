import 'package:flutter/material.dart';
import 'package:libertad/data/repositories/database_repository.dart';

import '../authors/authors_screen.dart';
import '../books/screens/books_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = const [
    Tab(text: 'Books'),
    Tab(text: 'Authors'),
    Tab(text: 'Issued Books'),
    Tab(text: 'Borrowers'),
  ];

  final List<Widget> _tabViews = const [
    BooksPage(),
    AuthorsPage(),
    BooksPage(),
    AuthorsPage(),
  ];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Libertad'),
        actions: [
          IconButton(
            onPressed: DatabaseRepository.instance.clearDatabase,
            icon: Icon(Icons.clear_all),
          ),
          IconButton(
            onPressed: DatabaseRepository.instance.resetDatabase,
            icon: Icon(Icons.restart_alt_rounded),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
          tabAlignment: TabAlignment.center,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((tab) => _tabViews[_tabs.indexOf(tab)]).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add new book',
        child: const Icon(Icons.add),
      ),
    );
  }
}
