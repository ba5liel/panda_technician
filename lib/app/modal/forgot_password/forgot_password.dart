class ForgotPasswordData {
  final String title;
  final String content;
  final ForgotPasswordType type;
  final String buttonText;
  ForgotPasswordData({
    required this.title,
    required this.content,
    required this.type,
    required this.buttonText,
  });
}

enum ForgotPasswordType {
  reset,
  verify,
  forgot,
}