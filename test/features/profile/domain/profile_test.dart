import 'package:cmfi_connect/src/core/session/account.dart';
import 'package:cmfi_connect/src/features/profile/domain/profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const account = Account(
    firstName: 'Boris',
    lastName: 'Kamtou',
    phoneNumber: '+237659460125',
  );

  test('empty name and phone on the server come from the account', () {
    final profile = Profile.resolve(
      const Profile(firstName: '', phoneNumber: '', church: 'PSU-Yaoundé'),
      account,
    );

    expect(profile.fullName, 'Boris Kamtou');
    expect(profile.phoneNumber, '+237659460125');
    expect(profile.church, 'PSU-Yaoundé');
    expect(profile.exists, isTrue);
  });

  test('the server values win when they are filled', () {
    final profile = Profile.resolve(
      const Profile(
        firstName: 'Bob',
        lastName: 'K',
        phoneNumber: '+237600000000',
      ),
      account,
    );

    expect(profile.fullName, 'Bob K');
    expect(profile.phoneNumber, '+237600000000');
  });

  test('no profile on the server: built from the account, to be created', () {
    final profile = Profile.resolve(null, account);

    expect(profile.fullName, 'Boris Kamtou');
    expect(profile.exists, isFalse);
  });

  test('nothing known: no name', () {
    final profile = Profile.resolve(
      const Profile(firstName: '', phoneNumber: ''),
      null,
    );

    expect(profile.hasName, isFalse);
    expect(profile.initials, '');
  });
}
