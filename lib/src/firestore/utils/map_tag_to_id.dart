import '../models/models.dart';

List<int> mapTagsToTagIds(List<Tag> tags) {
  return tags.map((u) => u.index).toList();
}
