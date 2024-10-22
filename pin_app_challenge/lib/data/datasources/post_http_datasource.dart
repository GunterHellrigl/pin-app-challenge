import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:pin_app_challenge/data/responses/get_posts_response.dart';

class PostHttpDatasource {
  final http.Client client;

  PostHttpDatasource(this.client);

  Future<Either<Exception, List<PostResponse>>> getPosts() async {
    try {
      final response = await client.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts',
      ));

      if (response.statusCode == 200) {
        final List<dynamic> list = json.decode(response.body);
        return Right(list.map((e) => PostResponse.fromJson(e)).toList());
      } else {
        return Left(Exception('Failed to load posts'));
      }
    } catch (e) {
      return Left(Exception('Failed to load posts'));
    }
  }
}
