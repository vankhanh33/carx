import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsCardWidget extends StatefulWidget {
  const ReviewsCardWidget({Key? key}) : super(key: key);

  @override
  _ReviewsCardWidgetState createState() => _ReviewsCardWidgetState();
}

class _ReviewsCardWidgetState extends State<ReviewsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Sarah, Dubai Sarah',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Icon(
                          Icons.verified,
                          size: 12,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 0, 12, 0),
                        child: Text(
                          'Verified Purchase',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RatingBarIndicator(
                  itemBuilder: (context, index) => const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFC107),
                  ),
                  direction: Axis.horizontal,
                  rating: 4.5,
                  itemCount: 5,
                  itemSize: 12,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(),
              child: const Text(
                'Awesome performance mobile and best experience as well camera is also good very clear picture quality and battery is 80% charge in 15 minute. Good product by OnePlus.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.thumb_up_off_alt,
                  size: 16,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                  child: Text(
                    '16',
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Icon(
                    Icons.thumb_down_off_alt,
                    size: 16,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                  child: Text(
                    '3',
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 24,
            thickness: 1,
            color: Color.fromARGB(255, 245, 244, 244),
          ),
        ],
      ),
    );
  }
}
