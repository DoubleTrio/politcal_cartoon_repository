import '../models/models.dart';

List<Unit> mapUnitIdToUnits(List<int> unitIds) {
  return unitIds.map((u) => Unit.values[u]).toList();
}
