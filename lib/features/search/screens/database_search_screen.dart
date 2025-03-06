import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/search_result.dart';
import 'package:libertad/features/authors/screens/authors_screen/author_list_tile.dart';
import 'package:libertad/features/book_copies/screens/issued_copies_screen/issued_copy_tile.dart';
import 'package:libertad/features/borrowers/screens/borrowers_screen/borrower_list_tile.dart';
import 'package:libertad/features/home/viewmodels/home_viewmodel.dart';
import 'package:libertad/features/search/viewmodels/database_search_viewmodel.dart';
import 'package:libertad/widgets/book_list_tile.dart';

class DatabaseSearchPage extends ConsumerStatefulWidget {
  final String query;
  final void Function(BuildContext context, dynamic result) close;

  const DatabaseSearchPage(
      {super.key, required this.query, required this.close});

  @override
  ConsumerState<DatabaseSearchPage> createState() => _DatabaseSearchPageState();
}

class _DatabaseSearchPageState extends ConsumerState<DatabaseSearchPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = const [
    Tab(text: 'Books'),
    Tab(text: 'Authors'),
    Tab(text: 'Issued Books'),
    Tab(text: 'Borrowers'),
  ];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<SearchResult> result =
        ref.watch(databaseSearchViewModelProvider(widget.query));
    final HomeViewModel homeModel = ref.watch(homeViewModelProvider.notifier);

    _tabController.index = homeModel.selectedTabIndex;

    return result.when(
      data: (data) => Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: _tabs,
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            onTap: (value) => homeModel.selectedTabIndex = value,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.separated(
                  padding: const EdgeInsets.only(bottom: 64),
                  physics: BouncingScrollPhysics(),
                  itemCount: data.books.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return BookListTile(
                      book: data.books[index],
                      index: index,
                    );
                  },
                ),
                ListView.separated(
                  padding: const EdgeInsets.only(bottom: 64),
                  physics: BouncingScrollPhysics(),
                  itemCount: data.authors.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return AuthorListTile(
                      author: data.authors[index],
                      index: index,
                    );
                  },
                ),
                ListView.separated(
                  padding: const EdgeInsets.only(bottom: 64),
                  physics: BouncingScrollPhysics(),
                  itemCount: data.issuedCopies.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return IssuedCopyTile(
                      copy: data.issuedCopies[index],
                      index: index,
                    );
                  },
                ),
                ListView.separated(
                  padding: const EdgeInsets.only(bottom: 64),
                  physics: BouncingScrollPhysics(),
                  itemCount: data.borrowers.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return BorrowerListTile(
                      borrower: data.borrowers[index],
                      index: index,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      error: (error, stacktrace) =>
          Center(child: Text('Something unexpected has occured')),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
