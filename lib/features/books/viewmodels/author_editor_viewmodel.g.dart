// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_editor_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authorEditorViewModelHash() =>
    r'9670f01d4e764557f8e9e0a709006d3f7ca2e796';

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

abstract class _$AuthorEditorViewModel
    extends BuildlessAutoDisposeNotifier<Author?> {
  late final Author? author;

  Author? build(
    Author? author,
  );
}

/// See also [AuthorEditorViewModel].
@ProviderFor(AuthorEditorViewModel)
const authorEditorViewModelProvider = AuthorEditorViewModelFamily();

/// See also [AuthorEditorViewModel].
class AuthorEditorViewModelFamily extends Family<Author?> {
  /// See also [AuthorEditorViewModel].
  const AuthorEditorViewModelFamily();

  /// See also [AuthorEditorViewModel].
  AuthorEditorViewModelProvider call(
    Author? author,
  ) {
    return AuthorEditorViewModelProvider(
      author,
    );
  }

  @override
  AuthorEditorViewModelProvider getProviderOverride(
    covariant AuthorEditorViewModelProvider provider,
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
  String? get name => r'authorEditorViewModelProvider';
}

/// See also [AuthorEditorViewModel].
class AuthorEditorViewModelProvider
    extends AutoDisposeNotifierProviderImpl<AuthorEditorViewModel, Author?> {
  /// See also [AuthorEditorViewModel].
  AuthorEditorViewModelProvider(
    Author? author,
  ) : this._internal(
          () => AuthorEditorViewModel()..author = author,
          from: authorEditorViewModelProvider,
          name: r'authorEditorViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$authorEditorViewModelHash,
          dependencies: AuthorEditorViewModelFamily._dependencies,
          allTransitiveDependencies:
              AuthorEditorViewModelFamily._allTransitiveDependencies,
          author: author,
        );

  AuthorEditorViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.author,
  }) : super.internal();

  final Author? author;

  @override
  Author? runNotifierBuild(
    covariant AuthorEditorViewModel notifier,
  ) {
    return notifier.build(
      author,
    );
  }

  @override
  Override overrideWith(AuthorEditorViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: AuthorEditorViewModelProvider._internal(
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
  AutoDisposeNotifierProviderElement<AuthorEditorViewModel, Author?>
      createElement() {
    return _AuthorEditorViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthorEditorViewModelProvider && other.author == author;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, author.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AuthorEditorViewModelRef on AutoDisposeNotifierProviderRef<Author?> {
  /// The parameter `author` of this provider.
  Author? get author;
}

class _AuthorEditorViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<AuthorEditorViewModel, Author?>
    with AuthorEditorViewModelRef {
  _AuthorEditorViewModelProviderElement(super.provider);

  @override
  Author? get author => (origin as AuthorEditorViewModelProvider).author;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
