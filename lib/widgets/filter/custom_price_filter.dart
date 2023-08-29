import 'package:LetsGo/theme/LetsGo_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPriceFilter extends StatefulWidget {
  const CustomPriceFilter({Key? key}) : super(key: key);

  @override
  State<CustomPriceFilter> createState() => _CustomPriceFilterState();
}

class _CustomPriceFilterState extends State<CustomPriceFilter> {
  RangeValues _currentRangeValues = const RangeValues(100, 500);

  @override
  Widget build(BuildContext context) {
    RangeLabels labels = RangeLabels(
      _currentRangeValues.start.toString(),
      _currentRangeValues.end.toString(),
    );
    return Column(
      children: [
        Text(
          '${_currentRangeValues.start}€ - ${_currentRangeValues.end}€',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        RangeSlider(
          values: _currentRangeValues,
          activeColor: LetsGoTheme.main,
          min: 0,
          max: 1000,
          divisions: 100,
          labels: labels,
          onChanged: (newRangeValues) {
            setState(() {
              _currentRangeValues = newRangeValues;
            });
          },
        ),
      ],
    );
  }
}
