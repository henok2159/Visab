
import 'package:tourist_guide/models/item_detail.dart';

class DetailPageState{
}

class OnError extends DetailPageState{
}
class OnLoading extends DetailPageState{
}
class OnSuccess extends DetailPageState{
  Object _itemDetail;
  OnSuccess(this._itemDetail);
  Object get itemDetail => _itemDetail;
}


