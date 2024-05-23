import 'package:equatable/equatable.dart';

import '../../model/post_model.dart';

abstract class MyLikedState extends Equatable {
  const MyLikedState();
}

class MyLikedInitialState extends MyLikedState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class MyLikedLoadingState extends MyLikedState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MyLikedSuccessState extends MyLikedState {
  List<Post> items;

  MyLikedSuccessState({required this.items});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MyLikedFailureState extends MyLikedState {
  final String errorMessage;

  MyLikedFailureState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UnLikePostSuccessState extends MyLikedState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RemovePostSuccessState extends MyLikedState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}