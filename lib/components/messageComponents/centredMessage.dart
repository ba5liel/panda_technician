import 'package:flutter/widgets.dart';

class CentredMessage extends StatelessWidget {
  CentredMessage({super.key, required this.messageWidget});
  Widget messageWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: messageWidget);
  }
}
