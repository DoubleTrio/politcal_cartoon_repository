import 'package:intl/intl.dart';

enum ImageType { all, cartoon, photo, document, infographic }

extension ImageTypeExtension on ImageType {
  static const imageTypes = {
    ImageType.cartoon: 'cartoon',
    ImageType.photo: 'photo',
    ImageType.document: 'document',
    ImageType.infographic: 'infographic',
  };

  static const stringToImageType = {
    'cartoon': ImageType.cartoon,
    'photo': ImageType.photo,
    'document': ImageType.document,
    'infographic': ImageType.infographic,
  };

  static ImageType fromString(String str) {
    return stringToImageType[str] ?? ImageType.all;
  }

  String get imageType => toBeginningOfSentenceCase(imageTypes[this]) ?? '';
  String get docType => imageTypes[this] ?? '';
}
