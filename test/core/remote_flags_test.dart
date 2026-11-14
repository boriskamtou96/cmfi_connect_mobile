import 'package:cmfi_connect/src/core/services/remote_flags.dart';
import 'package:cmfi_connect/src/features/bible/application/semeur.dart';
import 'package:cmfi_connect/src/features/bible/domain/bible_version.dart';
import 'package:cmfi_connect/src/features/bible/infrastructure/bible_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../helpers/bible_fakes.dart';

class _Flags implements RemoteFlags {
  _Flags(this.value);

  final String value;

  @override
  Future<String> read(String key) async => key == semeurFlag ? value : '';

  @override
  Future<void> refresh() async {}

  @override
  Stream<Set<String>> get changes => const Stream.empty();
}

void main() {
  test('a switch of the console: on, off, or the default', () {
    for (final on in ['on', 'true', '1']) {
      expect(remoteSwitch(on, fallback: false), isTrue, reason: on);
    }
    for (final off in ['off', 'false', '0']) {
      expect(remoteSwitch(off, fallback: true), isFalse, reason: off);
    }
    expect(remoteSwitch('', fallback: true), isTrue);
    expect(remoteSwitch('maybe', fallback: false), isFalse);
  });

  test('La Bible du Semeur joins the French versions when switched on', () {
    final on = availableBibleVersions(semeur: true);
    final french = [
      for (final version in on)
        if (version.language == 'fr') version.id,
    ];
    expect(french.last, semeurVersion.id);
    expect(on, hasLength(bibleVersions.length + 1));
    expect(bibleVersionOf(semeurVersion.id, semeur: true), semeurVersion);
    // read on Bibleserver only while it is off
    expect(externalBiblesWith(semeur: true), isEmpty);
    expect(externalBiblesWith(semeur: false).single.abbreviation, 'BDS');

    expect(availableBibleVersions(semeur: false), bibleVersions);
    expect(bibleVersionOf(semeurVersion.id), isNull);
  });

  test('without the key of the platform, the console cannot switch it on, '
      'and its copy goes', () async {
    final storage = FakeBibleStorage()
      ..files['fra_bds/complete.json'] = '{}'
      ..files['fra_lsg/complete.json'] = '{}';
    final container = ProviderContainer(
      overrides: [
        remoteFlagsProvider.overrideWithValue(_Flags('on')),
        bibleStorageProvider.overrideWithValue(storage),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(semeurInAppProvider), isFalse);
    await pumpEventQueue();
    expect(container.read(semeurInAppProvider), isFalse);
    expect(storage.files.keys, ['fra_lsg/complete.json']);
  });
}
