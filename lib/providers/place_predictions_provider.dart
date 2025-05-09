import 'package:BuMo/models/autocomplete_prediction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacePredictionsNotifier
    extends StateNotifier<List<AutocompletePrediction>> {
  PlacePredictionsNotifier(super.state);

  void updatePredictions(List<AutocompletePrediction> predictions) {
    state = predictions;
  }
}
