
class HomePageState{
}
class OnError extends HomePageState{
}
class OnLoading extends HomePageState{
}
class OnSuccess extends HomePageState{
      List<Object> _lists;
      OnSuccess(this._lists);
      List<Object> get lists => _lists;
}


