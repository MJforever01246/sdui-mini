/// Config super app truyền vào khi mở mini.
class RegisterConfig {
  const RegisterConfig({
    this.partnerId = 'super-host-demo',
    this.locale = 'vi',
    this.sessionToken,
  });

  final String partnerId;
  final String locale;
  final String? sessionToken;
}
