import 'package:flutter_app/src/Pages/Home/login_Example.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('title', () {});
  test('empty email returns error string', () {
    var result = EmailFieldValidator.validate('');
    expect(result, 'O campo de email deve ser preenchido.');
  });

  test('non-empty email returns null', () {
    var result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

  test('empty password returns error string', () {
    var result = PasswordFieldValidator.validate('');
    expect(result, 'O campo de senha deve ser preenchido.');
  });

  test('non-empty password returns null', () {
    var result = PasswordFieldValidator.validate('senha');
    expect(result, null);
  });
}
