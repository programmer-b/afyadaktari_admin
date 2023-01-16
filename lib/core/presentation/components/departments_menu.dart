import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Dpartmentmenu extends StatelessWidget {
  const Dpartmentmenu({super.key, this.onSelected});

  final void Function(DepartMenu)? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: onSelected,
      itemBuilder: (context) => <PopupMenuEntry<DepartMenu>>[
        PopupMenuItem<DepartMenu>(
            value: DepartMenu.delete,
            child: Row(
              children: [
                const Icon(
                  Icons.delete,
                  color: redColor,
                ),
                6.width,
                Text(
                  'Delete',
                  style: primaryTextStyle(),
                )
              ],
            ))
      ],
    );
  }
}

enum DepartMenu { view, addSchedule, delete }
