// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authors_search_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authorsSearchViewModelHash() =>
    r'5f08931bcfdf90b8b9ecbcdee558e78a0dc6acc3';

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

abstract class _$AuthorsSearchViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<Author>> {
  late final String query;

  FutureOr<List<Author>> build(
    String query,
  );
}

/// See also [AuthorsSearchViewModel].
@ProviderFor(AuthorsSearchViewModel)
const authorsSearchViewModelProvider = AuthorsSearchViewModelFamily();

/// See also [AuthorsSearchViewModel].
class AuthorsSearchViewModelFamily extends Family<AsyncValue<List<Author>>> {
  /// See also [AuthorsSearchViewModel].
  const AuthorsSearchViewModelFamily();

  /// See also [AuthorsSearchViewModel].
  AuthorsSearchViewModelProvider call(
    String query,
  ) {
    return AuthorsSearchViewModelProvider(
      query,
    );
  }

  @override
  AuthorsSearchViewModelProvider getProviderOverride(
    covariant AuthorsSearchViewModelProvider provider,
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
  String? get name => r'authorsSearchViewModelProvider';
}

/// See also [AuthorsSearchViewModel].
class AuthorsSearchViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AuthorsSearchViewModel,
        List<Author>> {
  /// See also [AuthorsSearchViewModel].
  AuthorsSearchViewModelProvider(
    String query,
  ) : this._internal(
          () => AuthorsSearchViewModel()..query = query,
          from: authorsSearchViewModelProvider,
          name: r'authorsSearchViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$authorsSearchViewModelHash,
          dependencies: AuthorsSearchViewModelFamily._dependencies,
          allTransitiveDependencies:
              AuthorsSearchViewModelFamily._allTransitiveDependencies,
          query: query,
        );

  AuthorsSearchViewModelProvider._internal(
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
  FutureOr<List<Author>> runNotifierBuild(
    covariant AuthorsSearchViewModel notifier,
  ) {
    return notifier.build(
      query,
    );
  }

  @override
  Override overrideWith(AuthorsSearchViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: AuthorsSearchViewModelProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<AuthorsSearchViewModel, List<Author>>
      createElement() {
    return _AuthorsSearchViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthorsSearchViewModelProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AuthorsSearchViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<List<Author>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _AuthorsSearchViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AuthorsSearchViewModel,
        List<Author>> with AuthorsSearchViewModelRef {
  _AuthorsSearchViewModelProviderElement(super.provider);

  @override
  String get query => (origin as AuthorsSearchViewModelProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
