import '../../../shared/utils.dart';
import '../infra/models/gift_model.dart';

class GiftDatasource {
  Future<List<GiftModel>> fetchGifts() async {
    List<GiftModel> gifts = [];
    const url = "${ApiConstants.base}/Gifts";
    final result = await Dio().get(url);
    if (result.statusCode == 200) {
      for (var json in result.data['data']) {
        gifts.add(GiftModel.fromJson(json));
      }
    }
    return gifts;
  }
}
