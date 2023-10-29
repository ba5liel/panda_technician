class Schedule {
    Schedule({
      required  this.date,
      required  this.time,
    });

    String date;
    String time;

    factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        date: json["date"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "date": date.toString(),
        "time": time,
    };
}