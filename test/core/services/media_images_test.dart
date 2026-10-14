import 'package:cmfi_connect/src/core/services/media_images.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const images = MediaImages('https://api.cmfi-connect.com/v1');

  test('an image of the API: on its host', () {
    expect(
      images.resolve('/v1/media/3f91.jpg'),
      'https://api.cmfi-connect.com/v1/media/3f91.jpg',
    );
  });

  test('an image of the CDN: its address as it is', () {
    expect(
      images.resolve('https://media.cmfi-connect.com/3f91.jpg'),
      'https://media.cmfi-connect.com/3f91.jpg',
    );
  });
}
