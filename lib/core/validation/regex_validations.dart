// ignore_for_file: prefer_constructors_over_static_methods

class RegexValidations {
  RegexValidations._init();
  static RegexValidations? _instace;
  static RegexValidations get instance {
    _instace ??= RegexValidations._init();
    return _instace!;
  }

  RegExp get emailRegex => RegExp(r'\S+@\S+\.\S+');
}
