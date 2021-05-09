import '../models/models.dart';

List<int> mapUnitsToUnitIds(List<Unit> units) {
  return units.map((u) => u.index).toList();
}
