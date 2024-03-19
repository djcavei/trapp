class PackageNameEntity {

  final String packageName;

  PackageNameEntity(this.packageName);

  Map<String, Object?> toMap() {
    return {
      'name': packageName
    };
  }

  static PackageNameEntity fromMap(Map<String, Object?> map) {
    return PackageNameEntity(map['name'] as String);
  }

}