import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/models/chart/chart_data.dart';
import 'package:mobile4us_new_version/utils/hexColor.dart';

class IndicatorsWidget extends StatelessWidget {

  List<ChartData> chartData;

  IndicatorsWidget(this.chartData);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: chartData
        .map(
          (data) => Container(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: buildIndicator(
            color: HexColor(data.color),
            text: data.key,
          )),
    )
        .toList(),
  );

  Widget buildIndicator({
    @required Color color,
    @required String text,
    bool isSquare = false,
    double size = 16,
    Color textColor = const Color(0xff505050),
  }) =>
      Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          text !=null ? Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ) : Text('')
        ],
      );
}