enum Unit {
  all,
  unit1,
  unit2,
  unit3,
  unit4,
  unit5,
  unit6,
  unit7,
  unit8,
  unit9,
  unit10,
  unit11,
  unit12,
  unit13,
  unit14,
  unit15,
  unit16,
  unit17,
  unit18,
  worldHistory,
}

extension Units on Unit {
  static const names = {
    Unit.all: 'All',
    Unit.unit1: 'The New World',
    Unit.unit2: 'European Colonization',
    Unit.unit3: 'The American Revolution',
    Unit.unit4: 'The Jacksonian Era',
    Unit.unit5: 'The Civil War',
    Unit.unit6: 'Reconstruction',
    Unit.unit7: 'The Gilded Age',
    Unit.unit8: 'US Imperialism',
    Unit.unit9: 'Progressivism',
    Unit.unit10: 'World War I',
    Unit.unit11: 'The Roaring 20s',
    Unit.unit12: 'The Great Depression',
    Unit.unit13: 'World War II',
    Unit.unit14: 'The Cold War',
    Unit.unit15: 'Modern America',
    Unit.unit16: 'Civil Rights',
    Unit.unit17: 'Native Americans',
    Unit.unit18: 'Imperialism',
    Unit.worldHistory: 'World History',
  };

  // static final periodRanges = {
  //   Unit.all: PeriodRange(0, 0, isValidPeriod: false),
  //   Unit.unit1: PeriodRange(1491, 1607),
  //   Unit.unit2: PeriodRange(1607, 1754),
  //   Unit.unit3: PeriodRange(1754, 1800),
  //   Unit.unit4: PeriodRange(1800, 1848),
  //   Unit.unit5: PeriodRange(1844, 1877),
  //   Unit.unit6: PeriodRange(1865, 1898),
  //   Unit.unit7: PeriodRange(1890, 1945),
  //   Unit.unit8: PeriodRange(1945, 1980),
  //   Unit.unit9: PeriodRange(1980, DateTime.now().year),
  //   Unit.worldHistory: PeriodRange(0, 0, isValidPeriod: false),
  // };

  String get name => names[this] ?? 'Unknown';

  // PeriodRange get periodRange =>
  //     periodRanges[this] ?? PeriodRange(0, 0, isValidPeriod: false);
}
