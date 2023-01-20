import 'package:mobx/mobx.dart';
import '../../external/gift_datasource.dart';

import '../../infra/models/gift_model.dart';
part 'wheel_store.g.dart';

class WheelStore = _WheelStoreBase with _$WheelStore;

abstract class _WheelStoreBase with Store {
  final GiftDatasource _datasource;
  _WheelStoreBase(this._datasource);

  @observable
  List<GiftModel> gifts = ObservableList();

  @action
  void clear() {
    gifts.clear();
  }

  @action
  Future<void> fetchGifts() async {
    gifts.clear();
    gifts.addAll(await _datasource.fetchGifts());
  }
}
