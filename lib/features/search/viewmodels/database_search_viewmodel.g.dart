// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_search_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseSearchViewModelHash() =>
    r'4f265408eab17998802e29cd2987d16988d59a66';

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

abstract class _$DatabaseSearchViewModel
    extends BuildlessAutoDisposeAsyncNotifier<SearchResult> {
  late final String query;

  FutureOr<SearchResult> build(
    String query,
  );
}

/// See also [DatabaseSearchViewModel].
@ProviderFor(DatabaseSearchViewModel)
const databaseSearchViewModelProvider = DatabaseSearchViewModelFamily();

/// See also [DatabaseSearchViewModel].
class DatabaseSearchViewModelFamily extends Family<AsyncValue<SearchResult>> {
  /// See also [DatabaseSearchViewModel].
  const DatabaseSearchViewModelFamily();

  /// See also [DatabaseSearchViewModel].
  DatabaseSearchViewModelProvider call(
    String query,
  ) {
    return DatabaseSearchViewModelProvider(
      query,
    );
  }

  @override
  DatabaseSearchViewModelProvider getProviderOverride(
    covariant DatabaseSearchViewModelProvider provider,
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
  String? get name => r'databaseSearchViewModelProvider';
}

/// See also [DatabaseSearchViewModel].
class DatabaseSearchViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DatabaseSearchViewModel,
        SearchResult> {
  /// See also [DatabaseSearchViewModel].
  DatabaseSearchViewModelProvider(
    String query,
  ) : this._internal(
          () => DatabaseSearchViewModel()..query = query,
          from: databaseSearchViewModelProvider,
          name: r'databaseSearchViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$databaseSearchViewModelHash,
          dependencies: DatabaseSearchViewModelFamily._dependencies,
          allTransitiveDependencies:
              DatabaseSearchViewModelFamily._allTransitiveDependencies,
          query: query,
        );

  DatabaseSearchViewModelProvider._internal(
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
  FutureOr<SearchResult> runNotifierBuild(
    covariant DatabaseSearchViewModel notifier,
  ) {
    return notifier.build(
      query,
    );
  }

  @override
  Override overrideWith(DatabaseSearchViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: DatabaseSearchViewModelProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<DatabaseSearchViewModel, SearchResult>
      createElement() {
    return _DatabaseSearchViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DatabaseSearchViewModelProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DatabaseSearchViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<SearchResult> {
  /// The parameter `query` of this provider.
  String get query;
}

class _DatabaseSearchViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DatabaseSearchViewModel,
        SearchResult> with DatabaseSearchViewModelRef {
  _DatabaseSearchViewModelProviderElement(super.provider);

  @override
  String get query => (origin as DatabaseSearchViewModelProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
