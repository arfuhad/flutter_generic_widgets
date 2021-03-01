part of flutter_generic_widgets;

class GenericNetworkErrorView extends StatefulWidget {
  final Function checkingFunction;
  GenericNetworkErrorView({@required this.checkingFunction, Key key})
      : assert(checkingFunction != null,
            'A non-null function must be provided to the GenericNetworkErrorView widget '),
        super(key: key);

  @override
  _GenericNetworkErrorViewState createState() =>
      _GenericNetworkErrorViewState();
}

class _GenericNetworkErrorViewState extends State<GenericNetworkErrorView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          child: Center(
        child: Text(
          "Please check your Network.\nTap To try again..",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      )),
      onTap: () {
        // _isLoaded = false;
        return widget.checkingFunction;
      },
    );
  }
}
