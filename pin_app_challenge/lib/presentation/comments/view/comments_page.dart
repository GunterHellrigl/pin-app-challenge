import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_app_challenge/di.dart';
import 'package:pin_app_challenge/presentation/comments/bloc/comments_bloc.dart';
import 'package:pin_app_challenge/presentation/comments/widgets/comment_card.dart';
import 'package:pin_app_challenge/presentation/common/dialogs/error_dialog.dart';
import 'package:pin_app_challenge/presentation/common/widgets/simple_app_bar.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({
    super.key,
    required this.postId,
  });

  final int postId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentsBloc>(
      create: (context) => sl()..add(GetComments(postId: postId)),
      child: PostContent(postId: postId),
    );
  }
}

class PostContent extends StatelessWidget {
  const PostContent({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: BlocConsumer<CommentsBloc, CommentsState>(
          listener: (context, state) {
            if (state.showErrorDialog) {
              ErrorDialog.show(
                context: context,
                onRetry: () {
                  context.read<CommentsBloc>().add(GetComments(postId: postId));
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
                  Text(
                    'Comments',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.comments.length,
                    itemBuilder: (context, index) {
                      return CommentCard(comment: state.comments[index]);
                    },
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
