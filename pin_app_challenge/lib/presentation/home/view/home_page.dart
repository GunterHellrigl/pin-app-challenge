import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_app_challenge/di.dart';
import 'package:pin_app_challenge/presentation/common/dialogs/error_dialog.dart';
import 'package:pin_app_challenge/presentation/common/widgets/simple_app_bar.dart';
import 'package:pin_app_challenge/presentation/home/bloc/home_bloc.dart';
import 'package:pin_app_challenge/presentation/home/widgets/post_card.dart';
import 'package:pin_app_challenge/router/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => sl()..add(const GetPosts()),
      child: const HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.showErrorDialog) {
              ErrorDialog.show(
                context: context,
                onRetry: () {
                  context.read<HomeBloc>().add(const GetPosts());
                },
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Posts',
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 16),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) => PostCard(
                      post: state.posts[index],
                      onTap: () {
                        context.push(
                            '${Routes.comments}/${state.posts[index].id}');
                      },
                    ),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
