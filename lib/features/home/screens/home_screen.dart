import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/authors/screens/authors_screen/authors_screen.dart';
import 'package:libertad/features/book_copies/screens/issued_copies_screen/issued_copies_screen.dart';
import 'package:libertad/features/books/screens/books_screen/books_screen.dart';
import 'package:libertad/features/borrowers/screens/borrowers_screen/borrowers_screen.dart';
import 'package:libertad/features/home/viewmodels/home_viewmodel.dart';

/// Home page of the app with tabs views displaying books, authors, issued
/// books, and borrowers.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  /// List of tabs with labels.
  final List<Tab> _tabs = const [
    Tab(text: 'Books'),
    Tab(text: 'Authors'),
    Tab(text: 'Issued Books'),
    Tab(text: 'Borrowers'),
  ];

  /// List of widgets to be displayed as tab views.
  final List<Widget> _tabViews = const [
    BooksPage(),
    AuthorsPage(),
    IssuedCopiesPage(),
    BorrowersPage(),
  ];

  /// Controller to access current tab and control tab bar's behavior.
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_tabListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabListener);
    _tabController.dispose();
    super.dispose();
  }

  /// Whether to enable filter button.
  bool _filterButtonEnabled = true;

  /// Whether to show FAB button.
  bool _fabEnabled = true;

  /// Enables/disables filter button and FAB based on the selected tab.
  void _tabListener() {
    final int index = _tabController.index;
    setState(() {
      if (index == 1) {
        _filterButtonEnabled = false;
      } else {
        _filterButtonEnabled = true;
      }
      if (index == 0 || index == 3) {
        _fabEnabled = true;
      } else {
        _fabEnabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final HomeViewModel model =
        ref.watch(homeViewModelProvider(_tabController).notifier);

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
              PopupMenuItem(
                value: 2,
                onTap: model.hyperPopulateDatabase,
                child: Row(
                  children: [
                    Icon(
                      Icons.data_thresholding_outlined,
                      size: 18,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Hyper populate database',
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
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () => model.showSortDialog(context),
                  icon: Icon(Icons.sort_rounded),
                  label: Text('Sort'),
                ),
                TextButton.icon(
                  onPressed: _filterButtonEnabled
                      ? () => model.showFilterDialog(context)
                      : null,
                  icon: Icon(Icons.filter_alt),
                  label: Text('Filter'),
                ),
              ],
            ),
          ),
          Divider(height: 0),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:
                  _tabs.map((tab) => _tabViews[_tabs.indexOf(tab)]).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: _fabEnabled
          ? FloatingActionButton(
              onPressed: () => model.showEditor(context: context),
              tooltip: 'Add new book',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
