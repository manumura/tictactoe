import 'package:flutter/foundation.dart';

import '../game_internals/board_setting.dart';

/// Encapsulates a score and the arithmetic to compute it.
@immutable
class Score {
  final int score;

  final Duration duration;

  final int level;

  factory Score(int level, BoardSetting setting, int difficulty, Duration duration) {
    // The higher the difficulty, the higher the score.
    var score = difficulty * difficulty;
    // The higher the number of tiles in a row needed to win, the higher the score.
    score *= setting.k * setting.k;
    // The lower the time to beat the level, the higher the score.
    score *= 1000 ~/ (duration.inSeconds.abs() + 1);
    return Score._(score, duration, level);
  }

  const Score._(this.score, this.duration, this.level);

  String get formattedTime {
    final buf = StringBuffer();
    if (duration.inHours > 0) {
      buf.write('${duration.inHours}');
      buf.write(':');
    }
    final minutes = duration.inMinutes % Duration.minutesPerHour;
    if (minutes > 9) {
      buf.write('$minutes');
    } else {
      buf.write('0');
      buf.write('$minutes');
    }
    buf.write(':');
    buf.write((duration.inSeconds % Duration.secondsPerMinute)
        .toString()
        .padLeft(2, '0'));
    return buf.toString();
  }

  @override
  String toString() => 'Score<$score,$formattedTime,$level>';
}
