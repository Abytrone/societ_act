import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                  colors: [
                    Colors.blue,
                    // Color(0xFFA8DADC),
                    // Color(0xFF457B9D),
                    // Color(0xFF1D3557),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Please wait...'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
