enum Tag {
  all,
  tag1,
  tag2,
  tag3,
  tag4,
  tag5,
  tag6,
  tag7,
  tag8,
  tag9,
  tag10,
  tag11,
  tag12,
  tag13,
  tag14,
  tag15,
  tag16,
  tag17,
  tag18,
  tag19,
  worldHistory,
}

extension Tags on Tag {
  static const names = {
    Tag.all: 'All',
    Tag.tag1: 'The New World',
    Tag.tag2: 'European Colonization',
    Tag.tag3: 'The American Revolution',
    Tag.tag4: 'The Jacksonian Era',
    Tag.tag5: 'The Civil War',
    Tag.tag6: 'Reconstruction',
    Tag.tag7: 'The Gilded Age',
    Tag.tag8: 'US Imperialism',
    Tag.tag9: 'Progressivism',
    Tag.tag10: 'World War I',
    Tag.tag11: 'The Roaring 20s',
    Tag.tag12: 'The Great Depression',
    Tag.tag13: 'World War II',
    Tag.tag14: 'The Cold War',
    Tag.tag15: 'Modern America',
    Tag.tag16: 'Civil Rights',
    Tag.tag17: 'Native Americans',
    Tag.tag18: 'Imperialism',
    Tag.tag19: 'Elections',
    Tag.worldHistory: 'World History',
  };

  // static final periodRanges = {
  //   Tag.all: PeriodRange(0, 0, isValidPeriod: false),
  //   Tag.tag1: PeriodRange(1491, 1607),
  //   Tag.tag2: PeriodRange(1607, 1754),
  //   Tag.tag3: PeriodRange(1754, 1800),
  //   Tag.tag4: PeriodRange(1800, 1848),
  //   Tag.tag5: PeriodRange(1844, 1877),
  //   Tag.tag6: PeriodRange(1865, 1898),
  //   Tag.tag7: PeriodRange(1890, 1945),
  //   Tag.tag8: PeriodRange(1945, 1980),
  //   Tag.tag9: PeriodRange(1980, DateTime.now().year),
  //   Tag.worldHistory: PeriodRange(0, 0, isValidPeriod: false),
  // };

  String get name => names[this] ?? 'Unknown';

  // PeriodRange get periodRange =>
  //     periodRanges[this] ?? PeriodRange(0, 0, isValidPeriod: false);
}
