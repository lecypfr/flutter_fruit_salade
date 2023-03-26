import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_fruit/providers/fruits_provider.dart';

class SeasonFilter extends StatelessWidget {
  const SeasonFilter({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<FruitsProvider>(builder: (context, model, child) {
      return DropdownButton(
        value: model.seasonSelected,
        items: const [
          DropdownMenuItem(value: "", child: Text("Tous")),
          DropdownMenuItem(value: "Printemps", child: Text("Printemps")),
          DropdownMenuItem(value: "Eté", child: Text("Été")),
          DropdownMenuItem(value: "Automne", child: Text("Automne")),
          DropdownMenuItem(value: "Hiver", child: Text("Hiver")),
        ],
        onChanged: (newSeasonSelected) =>
            Provider.of<FruitsProvider>(context, listen: false)
                .editSeasonFilter(newSeasonSelected!),
      );
    });
  }
}
