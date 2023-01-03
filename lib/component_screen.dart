// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:material_3_demo/constants.dart';
import 'package:material_3_demo/helper/generate_random.dart';
import 'package:material_3_demo/models/link_model.dart';
import 'package:material_3_demo/service/api_service.dart';

class ComponentScreen extends StatelessWidget {
  const ComponentScreen({super.key, required this.showNavBottomBar});

  final bool showNavBottomBar;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: _maxWidthConstraint,
            child: ListView(
              shrinkWrap: true,
              children: [
                _colDivider,
                shortLinkCard(),
                _colDivider,
                const Dialogs(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const _rowDivider = SizedBox(width: 10);
const _colDivider = SizedBox(height: 10);
const double _cardWidth = 115;

const double _maxWidthConstraint = 400;



void showsnackbar(BuildContext context, String text,bool success ) {
  final snackBar = SnackBar(
    backgroundColor: success? Theme.of(context).colorScheme.primary:
                              Theme.of(context).colorScheme.error,
    content: Text(text),
    action: SnackBarAction(
      textColor: Theme.of(context).colorScheme.surface,
      label: 'Close',
      onPressed: () {},
    ),
    duration: Duration(seconds: 5),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


class copyShortLink extends StatelessWidget {
   // copyShortLink({Key? key}) : super(key: key,required this.short_link);
  const copyShortLink({super.key,required  this.short_link});
  final  String short_link;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(short_link),
          Icon(Icons.content_copy_outlined),
        ],
      ),
    );
  }
}

Future<void> _dialogBuilder(BuildContext context,String short_link) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Hooray !'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            copyShortLink(short_link: ApiConstants.baseUrl+'/'+ short_link,),
            copyShortLink(short_link: ApiConstants.fastApiBaseUrl+'/'+short_link,),
            copyShortLink(short_link: ApiConstants.loadBalanceBaseUrl+'/'+short_link,),
          ],
        ), 
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



class shortLinkCard extends StatefulWidget {
   shortLinkCard({Key? key}) : super(key: key);

  @override
  State<shortLinkCard> createState() => _shortLinkCardState();
}

class _shortLinkCardState extends State<shortLinkCard> {

  final main_link = TextEditingController(text: 'https://');
  final short_link = TextEditingController(text: getRandomString(6));
  var test = getRandomString(10);
  late LinkModel? _linkModel ;

  @override
  Widget build(BuildContext context) {
    double width_75 = MediaQuery.of(context).size.width*0.75;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: width_75,
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children:  [
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Are you ready? "),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: main_link,
                      
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        hintText: 'Enter Long url',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: short_link,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        hintText: 'Enter uri',
                      ),
                    ),
                    SizedBox(height: 25,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // Foreground color
                          // ignore: deprecated_member_use
                          onPrimary: Theme.of(context).colorScheme.onPrimary,
                          // Background color
                          // ignore: deprecated_member_use
                          primary: Theme.of(context).colorScheme.primary,
                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                        // onPressed: handlePressed(context, false, "FilledButton"),
                        onPressed: () async{
                          // print(main_url.text);

                          _linkModel= (await ApiService().getLink())!;
                          // _linkCreateModel =(await ApiService().createLink(
                          //     main_link.text, short_link.text))!;
                          ApiService().createLink(
                              main_link.text,
                              short_link.text).then((value) {
                                if(value != null){

                                  showsnackbar(context,'Finished ! ',true);
                                  _dialogBuilder(context,short_link.text);
                                  // _dialogBuilder(context);
                                } else{
                                  showsnackbar(context,'error : please fill all fields',false);
                                }
                          });
                        },
                        child: const Text('Create'),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}





class Dialogs extends StatefulWidget {
  const Dialogs({super.key});

  @override
  State<Dialogs> createState() => _DialogsState();
}

class _DialogsState extends State<Dialogs> {
  void openDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("HELP"),
        content: const Text(
            "this is shorter url for MCINEXT interview! for work this app, just need to enter long url and press create enter, after that, open dialog and shows shorter link."),
        actions: <Widget>[
          TextButton(
            child: const Text('Dismiss'),
            onPressed: () => Navigator.of(context).pop(),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        child: const Text(
          "Help !",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () => openDialog(context),
      ),
    );
  }
}

const List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.cut),
    label: 'shorter',
    selectedIcon: Icon(Icons.cut_sharp),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.cruelty_free_outlined ),
    label: 'ME',
    selectedIcon: Icon(Icons.cruelty_free_outlined ),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.text_snippet_outlined),
    label: 'noThings',
    selectedIcon: Icon(Icons.text_snippet),
  ),
  // NavigationDestination(
  //   tooltip: "",
  //   icon: Icon(Icons.invert_colors_on_outlined),
  //   label: 'Elevation',
  //   selectedIcon: Icon(Icons.opacity),
  // )
];

final List<NavigationRailDestination> navRailDestinations = appBarDestinations
    .map(
      (destination) => NavigationRailDestination(
        icon: Tooltip(
          message: destination.label,
          child: destination.icon,
        ),
        selectedIcon: Tooltip(
          message: destination.label,
          child: destination.selectedIcon,
        ),
        label: Text(destination.label),
      ),
    )
    .toList();

const List<Widget> exampleBarDestinations = [
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.explore_outlined),
    label: 'Explore',
    selectedIcon: Icon(Icons.explore),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.pets_outlined),
    label: 'Pets',
    selectedIcon: Icon(Icons.pets),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.account_box_outlined),
    label: 'Account',
    selectedIcon: Icon(Icons.account_box),
  )
];

class NavigationBars extends StatefulWidget {
  final void Function(int)? onSelectItem;
  final int selectedIndex;
  final bool isExampleBar;

  const NavigationBars(
      {super.key,
      this.onSelectItem,
      required this.selectedIndex,
      required this.isExampleBar});

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
        if (!widget.isExampleBar) widget.onSelectItem!(index);
      },
      destinations:
          widget.isExampleBar ? exampleBarDestinations : appBarDestinations,
    );
  }
}

class NavigationRailSection extends StatefulWidget {
  final void Function(int) onSelectItem;
  final int selectedIndex;

  const NavigationRailSection(
      {super.key, required this.onSelectItem, required this.selectedIndex});

  @override
  State<NavigationRailSection> createState() => _NavigationRailSectionState();
}

class _NavigationRailSectionState extends State<NavigationRailSection> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      minWidth: 50,
      destinations: navRailDestinations,
      selectedIndex: _selectedIndex,
      useIndicator: true,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
        widget.onSelectItem(index);
      },
    );
  }
}
