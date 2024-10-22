import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_app_challenge/presentation/home/view/home_page.dart';
import 'package:pin_app_challenge/presentation/comments/view/comments_page.dart';

class Routes {
  static const home = '/';
  static const comments = '/comments';
}

/// The route configuration.
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '${Routes.comments}/:postId',
      builder: (BuildContext context, GoRouterState state) {
        return CommentsPage(
          postId: int.parse(state.pathParameters['postId']!),
        );
      },
      redirect: (context, state) {
        if (state.pathParameters['postId'] == null) {
          return Routes.home;
        }

        return null;
      },
    ),
  ],
);
