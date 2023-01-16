import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Doctormenu extends StatelessWidget {
  const Doctormenu({super.key, this.onSelected});

  final void Function(DocMenu)? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: onSelected,
      itemBuilder: (context) => <PopupMenuEntry<DocMenu>>[
        PopupMenuItem<DocMenu>(
            value: DocMenu.view,
            child: Row(
              children: [
                const Icon(
                  Icons.visibility,
                  color: blueColor,
                ),
                6.width,
                Text(
                  'View',
                  style: primaryTextStyle(),
                )
              ],
            )),
        PopupMenuItem<DocMenu>(
            value: DocMenu.addSchedule,
            child: Row(
              children: [
                const Icon(
                  Icons.manage_accounts,
                  color: greenColor,
                ),
                6.width,
                Text(
                  'Manage schedule',
                  style: primaryTextStyle(),
                )
              ],
            )),
        PopupMenuItem<DocMenu>(
            value: DocMenu.delete,
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

enum DocMenu { view, addSchedule, delete }
