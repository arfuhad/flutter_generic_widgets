part of flutter_generic_widgets;

class GenericDataRow extends StatelessWidget {
  final Widget title;
  final Widget value;
  final bool color;
  const GenericDataRow(
      {@required this.title, @required this.value, this.color = false, Key key})
      : assert(title != null,
            'A non-null Widget must be provided to the GenericDataRow widget'),
        assert(value != null,
            'A non-null Widget must be provided to the GenericDataRow widget'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ? Colors.grey[300] : Colors.white,
      child: Row(
        children: [
          title,
          Spacer(),
          value,
        ],
      ),
    );
  }
}
