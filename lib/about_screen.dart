// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Expanded(
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 7),
          TextStyleExample(
              name: "about Me", style: textTheme.displayLarge!),

          TextStyleExample(name: "My Name Is MH Sharifi !", style: textTheme.titleLarge!),
          TextStyleExample(name: "I'm  just simple programmer :)", style: textTheme.bodyMedium!),
          InkWell(
            child: TextStyleExample(name: "http://mh.sharifi.stu.um.ac.ir", style: textTheme.bodyMedium!),
            onTap: (){},
          ),
          TextStyleExample(name: "have good time , 1/3/2023", style: textTheme.bodySmall!),
        ],
      ),
    );
  }
}

class TextStyleExample extends StatelessWidget {
  const TextStyleExample({
    super.key,
    required this.name,
    required this.style,
  });

  final String name;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(name, style: style),
    );
  }
}
