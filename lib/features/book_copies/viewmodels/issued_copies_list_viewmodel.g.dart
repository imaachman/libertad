// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issued_copies_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$issuedCopiesListViewModelHash() =>
    r'ef0643553ac631baeed7a525e29ed17c91836e34';

/// Business logic layer of issued copies list page.
///
/// Copied from [IssuedCopiesListViewModel].
@ProviderFor(IssuedCopiesListViewModel)
final issuedCopiesListViewModelProvider = AutoDisposeAsyncNotifierProvider<
    IssuedCopiesListViewModel, List<BookCopy>>.internal(
  IssuedCopiesListViewModel.new,
  name: r'issuedCopiesListViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$issuedCopiesListViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IssuedCopiesListViewModel = AutoDisposeAsyncNotifier<List<BookCopy>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
