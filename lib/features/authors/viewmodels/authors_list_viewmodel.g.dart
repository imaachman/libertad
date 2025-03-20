// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authors_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authorsListViewModelHash() =>
    r'e671240c3567997a2772119a076018eb95143794';

/// Business logic layer for authors list page.
///
/// Copied from [AuthorsListViewModel].
@ProviderFor(AuthorsListViewModel)
final authorsListViewModelProvider = AutoDisposeAsyncNotifierProvider<
    AuthorsListViewModel, List<Author>>.internal(
  AuthorsListViewModel.new,
  name: r'authorsListViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authorsListViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthorsListViewModel = AutoDisposeAsyncNotifier<List<Author>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
