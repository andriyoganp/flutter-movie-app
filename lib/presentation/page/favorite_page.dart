import 'package:flutter/material.dart';

import '../component/search_field.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FavoritePageContent();
  }
}

class _FavoritePageContent extends StatefulWidget {
  const _FavoritePageContent({super.key});

  @override
  State<_FavoritePageContent> createState() => _FavoritePageContentState();
}

class _FavoritePageContentState extends State<_FavoritePageContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SearchField()
      ],
    );
  }
}
