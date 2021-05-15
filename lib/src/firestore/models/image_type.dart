import 'package:intl/intl.dart';

enum ImageType {
  all,
  cartoon,
  photo,
  document,
}

extension ImageTypeExtension on ImageType {
  static const imageTypes = {
    ImageType.cartoon: 'cartoon',
    ImageType.photo: 'photo',
    ImageType.document: 'document'
  };

  static const stringToImageType = {
    'cartoon': ImageType.cartoon,
    'photo': ImageType.photo,
    'document': ImageType.document,
  };

  static ImageType fromString(String str) {
    return stringToImageType[str] ?? ImageType.all;
  }

  String get imageType => toBeginningOfSentenceCase(imageTypes[this]) ?? '';
}