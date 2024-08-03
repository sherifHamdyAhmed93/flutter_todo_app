class MyUser {
  String id;
  String? email;
  String? name;

  static const String _idKey = 'id';
  static const String _nameKey = 'name';
  static const String _emailKey = 'email';

  MyUser({required this.id, required this.email, required this.name});

  MyUser.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?[_idKey] as String,
          name: data?[_nameKey] as String,
          email: data?[_emailKey] as String,
        );

  Map<String, dynamic> toFireStore() {
    return {
      _idKey: id,
      _nameKey: name,
      _emailKey: email,
    };
  }
}
