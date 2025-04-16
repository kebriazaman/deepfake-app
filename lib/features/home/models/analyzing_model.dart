class AnalyzingModel {
  Predictions? predictions;

  AnalyzingModel({this.predictions});

  AnalyzingModel.fromJson(Map<String, dynamic> json) {
    predictions = json['predictions'] != null
        ? Predictions.fromJson(json['predictions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (predictions != null) {
      data['predictions'] = predictions!.toJson();
    }
    return data;
  }
}

class Predictions {
  String? eyeModel;
  String? lipModel;

  Predictions({this.eyeModel, this.lipModel});

  Predictions.fromJson(Map<String, dynamic> json) {
    eyeModel = json['eye_model'];
    lipModel = json['lip_model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eye_model'] = eyeModel;
    data['lip_model'] = lipModel;
    return data;
  }
}
