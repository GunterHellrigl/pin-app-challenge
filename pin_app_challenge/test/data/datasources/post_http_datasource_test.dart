import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pin_app_challenge/data/datasources/post_http_datasource.dart';
import 'package:pin_app_challenge/data/responses/get_posts_response.dart';

import 'post_http_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late PostHttpDatasource dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = PostHttpDatasource(mockClient);
  });

  group('getPosts', () {
    const tPostResponse = PostResponse(
      userId: 1,
      id: 1,
      title: 'Test Title',
      body: 'Test Body',
    );
    final tPostList = [tPostResponse];
    final tPostListJson = jsonEncode([
      {
        'userId': 1,
        'id': 1,
        'title': 'Test Title',
        'body': 'Test Body',
      }
    ]);

    test(
      'should return a list of PostResponse when the code is 200 (success)',
      () async {
        when(mockClient.get(any)).thenAnswer(
          (_) async => http.Response(tPostListJson, 200),
        );

        final result = await dataSource.getPosts();

        expect(result.isRight, true);
        expect(result.right, tPostList);
        verify(mockClient.get(any));
        verifyNoMoreInteractions(mockClient);
      },
    );

    test(
      'should return an Exception when the response code is not 200',
      () async {
        when(mockClient.get(any)).thenAnswer(
          (_) async => http.Response('Something went wrong', 404),
        );

        final result = await dataSource.getPosts();

        expect(result.isLeft, true);
        expect(result.left, isA<Exception>());
        verify(mockClient.get(any));
        verifyNoMoreInteractions(mockClient);
      },
    );
  });
}
