import 'dart:async';

import 'package:flick_scout/features/movie_search/bloc/movie_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class MovieSearchBar extends StatefulWidget {
  final void Function(String) onChanged;
  const MovieSearchBar({super.key, required this.onChanged});

  @override
  State<MovieSearchBar> createState() => _MovieSearchBarState();
}

class _MovieSearchBarState extends State<MovieSearchBar> {
  final _textController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onSearchChanged);
    _textController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_textController.text.length > 1) {
        context.read<MovieSearchBloc>().add(SearchMovies(query: _textController.text));
      } else {
        context.read<MovieSearchBloc>().add(ResetSearch());
      }
    });
    widget.onChanged(_textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: _textController,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18.sp,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[300],
          hintText: 'Search for a movie...',
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 18.sp,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[500],
            size: 20.sp,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 20.0,
          ),
        ),
        onChanged: (value) => _onSearchChanged(),
      ),
    );
  }
}