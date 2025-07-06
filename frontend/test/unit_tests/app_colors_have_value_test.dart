import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/theme/app_colors.dart';

void main() {
  test('Color has a value', () {
    final contrast1 = AppColors.primaryGreen.value;
    expect(contrast1 == 0xFF2D615F, isTrue);
  });
}
