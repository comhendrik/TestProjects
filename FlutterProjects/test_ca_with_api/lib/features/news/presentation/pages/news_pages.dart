import 'package:test_ca_with_api/features/news/presentation/bloc/news_bloc.dart';
import 'package:test_ca_with_api/features/news/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class NewsPage extends StatelessWidget {

  const NewsPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NewsBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NewsBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              // Top half
              BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is NewsInitial) {
                    return const MessageDisplay(
                      message: 'Start searching!',
                    );
                  } else if (state is NewsLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is NewsLoaded) {
                    return NewsDisplay(newsList: state.newsList);
                  } else if (state is NewsError) {
                    return MessageDisplay(
                      message: state.errorMsg,
                    );
                  } else {
                    return const Text("Test");
                  }
                },
              ),
              const SizedBox(height: 20),
              // Bottom half
              const Controls()
            ],
          ),
        ),
      ),
    );
  }
}