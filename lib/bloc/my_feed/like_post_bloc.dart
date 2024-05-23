


import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngdemo17/bloc/my_feed/like_post_event.dart';
import 'package:ngdemo17/bloc/my_feed/like_post_state.dart';
import 'package:ngdemo17/bloc/my_feed/my_feed_event.dart';
import 'package:ngdemo17/bloc/my_feed/my_feed_state.dart';

import '../../services/db_service.dart';

class LikePostBloc extends Bloc<LikedEvent, LikeState> {
  LikePostBloc() : super(LikePostInitialState()) {
    on<LikePostEvent>(_onLikePostEvent);
    on<UnLikePostEvent>(_onUnlikePostEvent);

  }

  Future<void> _onLikePostEvent(LikePostEvent event, Emitter<LikeState> emit) async {
    await DBService.likePost(event.post, true);
    event.post.liked = true;
    emit(LikePostSuccessState(post: event.post));
  }

  Future<void> _onUnlikePostEvent(UnLikePostEvent event, Emitter<LikeState> emit) async {
    await DBService.likePost(event.post, false);
    event.post.liked = false;
    emit(UnLikePostSuccessState(post: event.post));
  }


  }
