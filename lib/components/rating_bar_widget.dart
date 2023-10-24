import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RatingBarWidget extends StatefulWidget {
  const RatingBarWidget({
    Key? key,
    required this.rating,
    required this.totalRatings,
    required this.progress,
  }) : super(key: key);

  final int? rating;
  final int? totalRatings;
  final double? progress;

  @override
  _RatingBarWidgetState createState() => _RatingBarWidgetState();
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 10,
            child: Text(
              widget.rating.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(4, 0, 6, 0),
            child: Icon(
              Icons.star_sharp,
              color: Colors.amber,
              size: 16,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 6, 0),
              child: LinearPercentIndicator(
                percent: widget.progress!,
                lineHeight: 8,
                animation: true,
                animateFromLastPercent: true,
                progressColor: Colors.green,
                barRadius: const Radius.circular(4),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          SizedBox(
            width: 32,
            child: Text(
              widget.totalRatings.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
