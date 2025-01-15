import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/features/authors/authors_screen.dart';
import 'package:libertad/features/books/screens/books_screen.dart';
import 'package:libertad/features/home/viewmodels/home_viewmodel.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
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
            onPressed: ref.read(homeViewModelProvider.notifier).clearDatabase,
            icon: Icon(Icons.clear_all),
          ),
          IconButton(
            onPressed: ref.read(homeViewModelProvider.notifier).resetDatabase,
            icon: Icon(Icons.restart_alt_rounded),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
          tabAlignment: TabAlignment.center,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((tab) => _tabViews[_tabs.indexOf(tab)]).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(homeViewModelProvider.notifier).addBook(
              Book(
                title: 'Becoming',
                author: 'Michelle Obama',
                genre: 'Memoir',
                releaseDate: DateTime(2018, 11, 13),
                summary:
                    'A powerful and inspiring memoir from the former First Lady of the United States.',
                coverImage: '',
                totalCopies: 12,
                issuedCopies: 7,
              ),
            ),
        tooltip: 'Add new book',
        child: const Icon(Icons.add),
      ),
    );
  }
}
