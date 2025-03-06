import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/authors/screens/authors_screen/authors_screen.dart';
import 'package:libertad/features/book_copies/screens/issued_copies_screen/issued_copies_screen.dart';
import 'package:libertad/features/books/screens/books_screen/books_screen.dart';
import 'package:libertad/features/borrowers/screens/borrowers_screen/borrowers_screen.dart';
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
    IssuedBooksPage(),
    BorrowersPage(),
  ];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final HomeViewModel model = ref.watch(homeViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Libertad'),
        actions: [
          IconButton(
            onPressed: () =>
                model.searchDatabase(context, _tabController.index),
            icon: Icon(Icons.search),
            tooltip: 'Search database',
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                onTap: () => model.showDocumentsDirectory(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.file_present_outlined,
                      size: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'View app files',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                onTap: model.clearDatabase,
                child: Row(
                  children: [
                    Icon(
                      Icons.clear_all,
                      size: 18,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Clear database',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                onTap: model.resetDatabase,
                child: Row(
                  children: [
                    Icon(
                      Icons.restart_alt_rounded,
                      size: 18,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Reset database',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
          tabAlignment: TabAlignment.center,
          isScrollable: true,
          onTap: (value) => model.selectedTabIndex = value,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((tab) => _tabViews[_tabs.indexOf(tab)]).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model.showBookEditor(context: context),
        tooltip: 'Add new book',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
