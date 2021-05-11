import '../models/models.dart';

List<Tag> mapTagIdToTags(List<int> tagIds) {
  return tagIds.map((u) => Tag.values[u]).toList();
}
