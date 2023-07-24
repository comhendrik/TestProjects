import 'package:test_ca_with_api/features/news/presentation/bloc/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Controls extends StatefulWidget {
  const Controls({
    super.key
  });


  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        dispatchNews();
      },
      child: const Text("Get News"),
    );
  }

  void dispatchNews() {
    BlocProvider.of<NewsBloc>(context)
        .add(GetNewsEvent());
  }
}