import 'package:dart_eval/dart_eval_security.dart';

/// A permission that allows access to Flutter assets.
class AssetPermission implements Permission {
  /// The pattern that will be matched against the path.
  final Pattern matchPattern;

  /// Create a new filesystem permission that matches a [Pattern].
  const AssetPermission(this.matchPattern);

  /// A permission that allows access to any file system resource.
  static final AssetPermission any = AssetPermission(RegExp('.*'));

  /// Create a new filesystem permission that matches a specific file.
  factory AssetPermission.asset(String asset) {
    final escaped = asset.replaceAll(r'\', r'\\').replaceAll(r'/', r'\/');
    return AssetPermission(RegExp('^$escaped\$'));
  }

  @override
  List<String> get domains => ['asset'];

  @override
  bool match([Object? data]) {
    if (data is String) {
      return matchPattern.matchAsPrefix(data) != null;
    }
    return false;
  }

  @override
  bool operator ==(Object other) {
    if (other is AssetPermission) {
      return other.matchPattern == matchPattern && other.domains == domains;
    }
    return false;
  }

  @override
  int get hashCode => matchPattern.hashCode ^ domains.hashCode;
}
