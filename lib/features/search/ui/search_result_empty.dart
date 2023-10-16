import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchResultEmptyWidget extends StatelessWidget {
  const SearchResultEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 120),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SvgPicture.asset(
                'assets/images/undraw_file_searching_re_3evy-1.svg',
                height: 160,
                fit: BoxFit.contain,
              ),
            ),
           const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Sorry, no results found!',
                  ),
                  Text(
                    'Please check the spelling or try searching for something else',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
