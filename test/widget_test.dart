import 'package:flutter_test/flutter_test.dart';

import 'package:secure_http/utils/validators.dart';

void main() {
  group('Validators', () {
    test('isValidEmail menerima email valid dan menolak yang tidak valid', () {
      expect(Validators.isValidEmail('user@example.com'), isTrue);
      expect(Validators.isValidEmail('userexample.com'), isFalse);
    });

    test('sanitize mengganti karakter berbahaya', () {
      expect(
        Validators.sanitize('<script>"x"</script>'),
        '&lt;script&gt;&quot;x&quot;&lt;/script&gt;',
      );
    });

    test('validateText memeriksa kosong dan panjang', () {
      expect(Validators.validateText(''), isNotNull);
      expect(Validators.validateText('abc', maxLength: 2), isNotNull);
      expect(Validators.validateText('abc'), isNull);
    });
  });
}
