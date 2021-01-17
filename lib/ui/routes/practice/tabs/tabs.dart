import 'package:flutter/material.dart';

enum TabType {
  goal,
  exercise,
  positive,
  improvement,
  notes,
}

String captionTabType(TabType tabType) {
  switch (tabType) {
    case TabType.goal:
      return "Today's practice goal...";
    case TabType.exercise:
      return 'Name of an exercise...';
    case TabType.positive:
      return 'What went great?';
    case TabType.improvement:
      return 'What is to improve?';
    default:
      return 'Additional notes on the practice...';
  }
}

class PracticeTab {
  final String title;
  final IconData icon;
  final TabType tabType;

  const PracticeTab(this.title, this.icon, this.tabType);
}

const List<PracticeTab> tabs = const <PracticeTab>[
  const PracticeTab('Goals', Icons.golf_course, TabType.goal),
  const PracticeTab('Exercises', Icons.format_list_numbered, TabType.exercise),
  const PracticeTab('Positives', Icons.thumb_up, TabType.positive),
  const PracticeTab('Improvements', Icons.thumb_down, TabType.improvement),
  const PracticeTab('Notes', Icons.speaker_notes, TabType.notes),
];
