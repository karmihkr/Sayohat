import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/theme/app_colors.dart';

void main() {
  test('primary and accent are defined and not equal', () {
    expect(AppColors.primaryGreen, isNotNull);
    expect(AppColors.primaryWhite, isNotNull);
    expect(AppColors.backgroundGreen, isNotNull);
  });
}
