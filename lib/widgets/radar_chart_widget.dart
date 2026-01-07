import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evi_example/provider/chat_provider.dart';

class RadarChartWidget extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;

  const RadarChartWidget({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
  });

  Map<String, double> _processEmotions(List<Map<String, dynamic>> chats) {
    Map<String, double> allEmotions = {};
    int chatCount = 0;

    for (final chat in chats) {
      if (chat['emotions'] != null) {
        final emotions = chat['emotions'] as Map<String, dynamic>;
        emotions.forEach((emotion, value) {
          allEmotions[emotion] =
              (allEmotions[emotion] ?? 0.0) + (value as num).toDouble();
        });
        chatCount++;
      }
    }

    // Calculate averages
    if (chatCount > 0) {
      allEmotions =
          allEmotions.map((key, value) => MapEntry(key, value / chatCount));
    }

    // Sort emotions by value and get top 6
    final sortedEmotions = allEmotions.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Map.fromEntries(sortedEmotions.take(6));
  }

  List<Map<String, dynamic>> _filterChats(List<Map<String, dynamic>> chats) {
    final selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    return chats.where((chat) {
      final chatDate = DateTime.parse(chat['createdAt']);
      return chatDate.isAfter(selectedDateTime) &&
          chatDate.isBefore(DateTime.now());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        final filteredChats = _filterChats(chatProvider.previousChats);
        final processedEmotions = _processEmotions(filteredChats);
        final emotions = processedEmotions.entries.toList();

        if (emotions.isEmpty) {
          return const Center(
            child: Text(
              'No data available for selected time period',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return SizedBox(
          height: 300,
          child: RadarChart(
            RadarChartData(
              radarShape: RadarShape.polygon,
              ticksTextStyle:
                  const TextStyle(fontSize: 10, color: Colors.transparent),
              gridBorderData: BorderSide(color: Colors.grey),
              titlePositionPercentageOffset: 0.2,
              titleTextStyle: const TextStyle(color: Colors.white),
              radarBorderData: BorderSide(color: Colors.grey),
              tickBorderData: BorderSide(color: Colors.grey),
              dataSets: [
                RadarDataSet(
                  fillColor: Colors.blue.withOpacity(0.2),
                  borderColor: Colors.blue,
                  entryRadius: 3,
                  dataEntries:
                      emotions.map((e) => RadarEntry(value: e.value)).toList(),
                ),
              ],
              getTitle: (index, angle) => RadarChartTitle(
                text: emotions[index].key,
              ),
              tickCount: 5,
            ),
          ),
        );
      },
    );
  }
}
