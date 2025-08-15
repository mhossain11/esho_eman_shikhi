 class SaveModel{

  final String page;
  final String time;
  final String date;

  SaveModel(this.page, this.time, this.date);

  Map<String, dynamic> toJson() => {
    'page': page,
    'time': time,
    'date': date,
  };

  factory SaveModel.fromJson(Map<String, dynamic> json) {
    return SaveModel(
      json['page'],
      json['time'],
      json['date'],
    );
  }
}