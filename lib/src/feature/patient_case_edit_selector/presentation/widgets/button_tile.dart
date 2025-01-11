
import 'package:flutter/material.dart';

class ButtonTile extends StatelessWidget {
   const ButtonTile({super.key, required this.titleOptionText, required this.descOptionText, required this.iconData, required this.route});

   final String titleOptionText;
   final String descOptionText;
   final IconData iconData;
   final String route;

   @override
   Widget build(BuildContext context) {
     return Column(
       children: [
         ListTile(
           title: Text(titleOptionText),
           subtitle: Text(descOptionText),
           leading: Container(
             padding: const EdgeInsets.only(right: 4),
             child: Icon(iconData),
           ),
           onTap: () {
             Navigator.of(context).pushNamed('/main/patients/details/edit-case/$route');
           },
         ),
         const Divider()
       ],
     );
   }
}