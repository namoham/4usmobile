import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/chart/chart_data.dart';
import 'package:mobile4us_new_version/utils/hexColor.dart';
import 'package:mobile4us_new_version/views/reports/pie_chart/indicators_widget.dart';

class PieChartPage2 extends StatefulWidget {


  final VoidCallback signOut;

  int userLoginId;

  String chartQuery;
  PieChartPage2(this.signOut, this.userLoginId, this.chartQuery);

  @override
  State<StatefulWidget> createState() => PieChartPage2State(this.signOut, this.userLoginId, this.chartQuery);
}

class PieChartPage2State extends State {
  int touchedIndex;

  VoidCallback signOut;
  int userLoginId;

  String chartQuery;
  ChartDataHelper helperChart = new ChartDataHelper();
  List<ChartData> chartData = <ChartData>[];

  PieChartPage2State(this.signOut, this.userLoginId, this.chartQuery);

  @override
  void initState() {
    super.initState();

    helperChart.getList(chartQuery).then((userFromServer){
      setState(() {
        chartData = userFromServer;
        chartData[0].color = '#FF0000';
        chartData[1].color = '#00cd00';
        chartData[2].color = '#FA8800';
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), // here the desired height
            child: AppBar(
              title: Text(
                  AppLocalizations.of(context)
                      .getTranslated('PieChart')
              ),
            )),
        body: Card(
          child: Column(
            children: <Widget>[
              Expanded(
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (pieTouchResponse) {
                        setState(() {
                          final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                              pieTouchResponse.touchInput is! PointerUpEvent;
                          if (desiredTouch && pieTouchResponse.touchedSection != null) {
                            touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        });
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: getSections(touchedIndex),
                  ),
                ),
              ),
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: IndicatorsWidget(chartData),
                  ),
                ],
              ),),
            ],
          ),
        )
    );
  }

  List<PieChartSectionData> getSections(int touchedIndex) =>
      chartData.asMap().map<int, PieChartSectionData>((index, data) {
        final isTouched = index == touchedIndex;
        final double fontSize = isTouched ? 25 : 16;
        final double radius = isTouched ? 100 : 80;

        final value = PieChartSectionData(
          color: HexColor(data.color),
          value: data.value.toDouble(),
          title: data.percentage + '%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        );
        return MapEntry(index, value);
      }).values.toList();
}