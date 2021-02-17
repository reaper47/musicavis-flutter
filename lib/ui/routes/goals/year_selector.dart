import 'package:flutter/material.dart';
import 'package:musicavis/providers/goals.dart';
import 'package:musicavis/ui/widgets/buttons.dart';

class YearSelector extends StatefulWidget {
  final GoalsProvider provider;

  YearSelector(this.provider);

  @override
  _YearSelectorState createState() => _YearSelectorState();
}

class _YearSelectorState extends State<YearSelector> {
  String _selected;
  List<String> _years;

  @override
  void initState() {
    _selected = widget.provider.currentYear;
    _years = widget.provider.years;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final onSave = () {
      widget.provider.updateYear(_selected);
      Navigator.of(context).pop();
    };

    return AlertDialog(
      title: Center(child: Text('Select Year')),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.33,
        width: MediaQuery.of(context).size.width * 0.25,
        child: ListView.builder(
          itemCount: _years.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(Icons.arrow_right_alt),
            selected: _years[index] == _selected,
            selectedTileColor: Colors.lightBlue.withOpacity(0.2),
            title: Text(_years[index]),
            visualDensity: VisualDensity.compact,
            onTap: () => setState(() => _selected = _years[index]),
          ),
        ),
      ),
      actions: cancelSaveButtons(context, onSave),
      elevation: 24.0,
    );
  }
}
