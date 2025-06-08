import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../models/projects_model.dart';

class ChatScreen extends StatefulWidget {
  final Project project;

  const ChatScreen({super.key, required this.project});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late double positive;
  late double neutral;
  late double negative;
  late double maxY;

  @override
  void initState() {
    super.initState();
    final stats = widget.project.chatStats;
    positive = (stats['positive'] ?? 0).toDouble();
    neutral = (stats['neutral'] ?? 0).toDouble();
    negative = (stats['negative'] ?? 0).toDouble();

    final maxValue = [positive, neutral, negative].reduce((a, b) => a > b ? a : b);
    maxY = ((maxValue + 30) / 10).ceil() * 10; // Round to nearest 10
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "Chart",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: maxY,
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 10,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return const Text("Positive");
                      case 1:
                        return const Text("Neutral");
                      case 2:
                        return const Text("Negative");
                      default:
                        return const Text('');
                    }
                  },
                ),
              ),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),drawBelowEverything: false),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: true),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: positive,
                    color: Colors.green,
                    width: 20,
                    borderRadius: BorderRadius.circular(4),
                  )
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: neutral,
                    color: Colors.blue,
                    width: 20,
                    borderRadius: BorderRadius.circular(4),
                  )
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    toY: negative,
                    color: Colors.red,
                    width: 20,
                    borderRadius: BorderRadius.circular(4),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
