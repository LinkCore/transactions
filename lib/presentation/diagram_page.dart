import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_transaction/data/models/type_transaction.dart';
import 'package:test_transaction/domain/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:test_transaction/presentation/widgets/indicator.dart';

class DiagramPage extends StatefulWidget {
  const DiagramPage({super.key});

  @override
  State<StatefulWidget> createState() => DiagramPageState();
}

class DiagramPageState extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is LoadingTransactionState) {
            return const CircularProgressIndicator();
          } else if (state is HasDataTransactionState) {
            Map<TypeTransaction, double> toChart = {
              TypeTransaction.income: 0.0,
              TypeTransaction.transfer: 0.0,
              TypeTransaction.withdrawal: 0.0,
            };

            for (var t in state.transactionList) {
              double ttCRT = toChart[t.type]!;
              toChart[t.type] = ttCRT + t.amount;
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          startDegreeOffset: 180,
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 1,
                          centerSpaceRadius: 0,
                          sections: showingSections(toChart),
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < TypeTransaction.values.length; i++)
                    Indicator(
                      color: TypeTransaction.values[i].typeToColor,
                      text: TypeTransaction.values[i].typeToString,
                      isSquare: false,
                      size: touchedIndex == i ? 18 : 16,
                      textColor:
                          touchedIndex == i ? Colors.orange : Colors.blue,
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      )),
    );
  }

  List<PieChartSectionData> showingSections(
      Map<TypeTransaction, double> mapToChart) {
    return List.generate(
      3,
      (i) {
        final isTouched = i == touchedIndex;

        return PieChartSectionData(
          color: mapToChart.keys.elementAt(i).typeToColor,
          value: mapToChart.values.elementAt(i),
          title: mapToChart.keys.elementAt(i).typeToString,
          radius: 100,
          titlePositionPercentageOffset: 0.55,
          borderSide: isTouched
              ? const BorderSide(color: Colors.white, width: 6)
              : BorderSide(color: Colors.white.withOpacity(0)),
        );
      },
    );
  }
}
