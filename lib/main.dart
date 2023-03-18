import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AppRoot(),
    ),
  );
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: PageContents());
  }
}

// The page should have a fixed footer on the bottom
// Then the rest of the content should fit
class PageContents extends StatefulWidget {
  const PageContents({super.key});

  @override
  State<PageContents> createState() => _PageContentsState();
}

class _PageContentsState extends State<PageContents> {
  bool fullView = true;

  @override
  Widget build(BuildContext context) {
    return Column(
        // this part makes sure the footer ends up at the bottom
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_otherContent(), _footer()]);
  }

  Widget _otherContent() {
    const spacing = 16.0;

    final extraButtons = [
      Container(height: spacing),
      _button(),
      Container(height: spacing),
      _button()
    ];

    // -- POINT --
    // Using Expanded here forces the child to use the size constraints of parent
    // in this case, that is the available space in column
    return Expanded(
      child: FittedBox(
        child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
                color: Colors.red,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  _button(text: "Toggle view", onTap: _toggleView),
                  Container(height: spacing),
                  _button(),
                  Container(height: spacing),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    // -- POINT --
                    // We have to use the Flexible with FlexFit.loose here instead of Expanded
                    Flexible(fit: FlexFit.loose, child: _button()),
                    Container(width: spacing),
                    Flexible(fit: FlexFit.loose, child: _button())
                  ]),
                  if (fullView) ...extraButtons
                ]))),
      ),
    );
  }

  Widget _footer() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
          color: Colors.blue,
          child: const Padding(
              padding: EdgeInsets.all(16.0), child: Text("Left"))),
      Container(
          color: Colors.green,
          child: const Padding(
              padding: EdgeInsets.all(16.0), child: Text("Right")))
    ]);
  }

  _toggleView() {
    setState(() {
      fullView = !fullView;
    });
  }

  Widget _button({String text = "Button", VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 128.0,
          color: Colors.purple,
          child: Center(child: Text(text))),
    );
  }
}
