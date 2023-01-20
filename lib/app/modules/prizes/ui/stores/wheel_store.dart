import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../../shared/utils.dart';
import '../../../forms/ui/stores/user_store.dart';
import '../../external/gift_datasource.dart';

import '../../infra/models/draw_model.dart';
import '../../infra/models/gift_model.dart';
part 'wheel_store.g.dart';

class WheelStore = _WheelStoreBase with _$WheelStore;

abstract class _WheelStoreBase with Store {
  final GiftDatasource _datasource;
  _WheelStoreBase(this._datasource);

  @observable
  List<GiftModel> gifts = ObservableList();

  @action
  void start() => drawing = true;

  @action
  Future<void> draw() async {
    didDraw = true;
    didLose = false;

    int index = gifts.indexWhere((element) => element.id == userDraw.giftId);

    if (index == -1) {
      index = wheelItens.length - 1;
      didLose = true;
      selectedGift = null;
    } else {
      selectedGift = gifts[index];
    }

    controller.add(index);
    final step = 1 / (gifts.length * FortuneWidget.kDefaultRotationCount);
    double lastStep = 0;
    for (var i = 0.0; i <= 1; i += 0.001) {
      final transform = FortuneCurve.spin.transform(i);
      final deltaStep = transform - lastStep;
      if (deltaStep > step) {
        lastStep = transform;
        HapticFeedback.selectionClick();
      }
      await Future.delayed(Duration(microseconds: 5000));
    }
  }

  @action
  void endDrawing() {
    drawing = false;
    if (didLose) {
      colorTweenController?.forward();
    }
  }

  @observable
  DrawModel userDraw = DrawModel.empty();

  @observable
  GiftModel? selectedGift;

  AnimationController? colorTweenController;
  final controller = StreamController<int>();
  Stream<int> get stream => controller.stream;

  @observable
  bool didDraw = false, drawing = false, didLose = false;

  @action
  void clear() {
    gifts.clear();
  }

  @action
  Future<void> fetchGifts() async {
    gifts.clear();
    gifts.addAll(await _datasource.fetchGifts());
  }

  @computed
  List<FortuneItem> get wheelItens {
    if (gifts.isEmpty) {
      return [
        buildItem("😢\nNão foi desta vez!"),
        buildItem("😢\nNão foi desta vez!"),
      ];
    }
    return [
      ...gifts.map((e) => buildItem(e.name)),
      buildItem("😢\nNão foi desta vez!"),
    ];
  }

  @action
  Future<void> fetchDraw() async {
    final userStore = Modular.get<UserStore>();
    final result = await _datasource.fetchDraw(userStore.name!);
    userDraw = result;
  }

  FortuneItem buildItem(String name) {
    return FortuneItem(
      child: Text(
        name,
        style: PodiTexts.heading5.weightBold.withColor(PodiColors.white),
      ),
      style: FortuneItemStyle(
        circleRatio: 0.4,
        axis: Axis.horizontal,
        color: PodiColors.purple,
        borderWidth: 0,
        gradient: LinearGradient(
          colors: [PodiColors.purple[300]!, PodiColors.purple[600]!],
        ),
      ),
    );
  }
}
