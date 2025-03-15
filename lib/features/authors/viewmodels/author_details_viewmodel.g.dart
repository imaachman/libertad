// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_details_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authorDetailsViewModelHash() =>
    r'ad7728b2f591f355c7ac0c32d6b58327809582d1';

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

abstract class _$AuthorDetailsViewModel
    extends BuildlessAutoDisposeNotifier<Author> {
  late final Author author;

  Author build(
    Author author,
  );
}

/// See also [AuthorDetailsViewModel].
@ProviderFor(AuthorDetailsViewModel)
const authorDetailsViewModelProvider = AuthorDetailsViewModelFamily();

/// See also [AuthorDetailsViewModel].
class AuthorDetailsViewModelFamily extends Family<Author> {
  /// See also [AuthorDetailsViewModel].
  const AuthorDetailsViewModelFamily();

  /// See also [AuthorDetailsViewModel].
  AuthorDetailsViewModelProvider call(
    Author author,
  ) {
    return AuthorDetailsViewModelProvider(
      author,
    );
  }

  @override
  AuthorDetailsViewModelProvider getProviderOverride(
    covariant AuthorDetailsViewModelProvider provider,
  ) {
    return call(
      provider.author,
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
  String? get name => r'authorDetailsViewModelProvider';
}

/// See also [AuthorDetailsViewModel].
class AuthorDetailsViewModelProvider
    extends AutoDisposeNotifierProviderImpl<AuthorDetailsViewModel, Author> {
  /// See also [AuthorDetailsViewModel].
  AuthorDetailsViewModelProvider(
    Author author,
  ) : this._internal(
          () => AuthorDetailsViewModel()..author = author,
          from: authorDetailsViewModelProvider,
          name: r'authorDetailsViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$authorDetailsViewModelHash,
          dependencies: AuthorDetailsViewModelFamily._dependencies,
          allTransitiveDependencies:
              AuthorDetailsViewModelFamily._allTransitiveDependencies,
          author: author,
        );

  AuthorDetailsViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.author,
  }) : super.internal();

  final Author author;

  @override
  Author runNotifierBuild(
    covariant AuthorDetailsViewModel notifier,
  ) {
    return notifier.build(
      author,
    );
  }

  @override
  Override overrideWith(AuthorDetailsViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: AuthorDetailsViewModelProvider._internal(
        () => create()..author = author,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        author: author,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<AuthorDetailsViewModel, Author>
      createElement() {
    return _AuthorDetailsViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthorDetailsViewModelProvider && other.author == author;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, author.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AuthorDetailsViewModelRef on AutoDisposeNotifierProviderRef<Author> {
  /// The parameter `author` of this provider.
  Author get author;
}

class _AuthorDetailsViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<AuthorDetailsViewModel, Author>
    with AuthorDetailsViewModelRef {
  _AuthorDetailsViewModelProviderElement(super.provider);

  @override
  Author get author => (origin as AuthorDetailsViewModelProvider).author;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
