// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrowers_search_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$borrowersSearchViewModelHash() =>
    r'bf70ce9aab3d87423f5fa6019173fae3755cf478';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$BorrowersSearchViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<Borrower>> {
  late final String query;

  FutureOr<List<Borrower>> build(
    String query,
  );
}

/// See also [BorrowersSearchViewModel].
@ProviderFor(BorrowersSearchViewModel)
const borrowersSearchViewModelProvider = BorrowersSearchViewModelFamily();

/// See also [BorrowersSearchViewModel].
class BorrowersSearchViewModelFamily
    extends Family<AsyncValue<List<Borrower>>> {
  /// See also [BorrowersSearchViewModel].
  const BorrowersSearchViewModelFamily();

  /// See also [BorrowersSearchViewModel].
  BorrowersSearchViewModelProvider call(
    String query,
  ) {
    return BorrowersSearchViewModelProvider(
      query,
    );
  }

  @override
  BorrowersSearchViewModelProvider getProviderOverride(
    covariant BorrowersSearchViewModelProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'borrowersSearchViewModelProvider';
}

/// See also [BorrowersSearchViewModel].
class BorrowersSearchViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<BorrowersSearchViewModel,
        List<Borrower>> {
  /// See also [BorrowersSearchViewModel].
  BorrowersSearchViewModelProvider(
    String query,
  ) : this._internal(
          () => BorrowersSearchViewModel()..query = query,
          from: borrowersSearchViewModelProvider,
          name: r'borrowersSearchViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$borrowersSearchViewModelHash,
          dependencies: BorrowersSearchViewModelFamily._dependencies,
          allTransitiveDependencies:
              BorrowersSearchViewModelFamily._allTransitiveDependencies,
          query: query,
        );

  BorrowersSearchViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  FutureOr<List<Borrower>> runNotifierBuild(
    covariant BorrowersSearchViewModel notifier,
  ) {
    return notifier.build(
      query,
    );
  }

  @override
  Override overrideWith(BorrowersSearchViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: BorrowersSearchViewModelProvider._internal(
        () => create()..query = query,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<BorrowersSearchViewModel,
      List<Borrower>> createElement() {
    return _BorrowersSearchViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BorrowersSearchViewModelProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BorrowersSearchViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<List<Borrower>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _BorrowersSearchViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BorrowersSearchViewModel,
        List<Borrower>> with BorrowersSearchViewModelRef {
  _BorrowersSearchViewModelProviderElement(super.provider);

  @override
  String get query => (origin as BorrowersSearchViewModelProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
