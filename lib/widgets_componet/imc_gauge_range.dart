import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcGaugeRange extends GaugeRange {
  ImcGaugeRange(
      {required Color color,
      required double start,
      required double end,
      required String labe})
      : super(
          startValue: start,
          endValue: end,
          color: color,
          label: labe,
          sizeUnit: GaugeSizeUnit.factor,
          labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize: 12),
          startWidth: 0.65,
          endWidth: 0.65,
        );
}
