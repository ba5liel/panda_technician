class Price {
    Price({
     required   this.diagnosticFee,
      required  this.hourlyFee,
    });

    double diagnosticFee;
    double hourlyFee;

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        diagnosticFee:json["diagnosticFee"].toDouble(),
        hourlyFee: json["hourlyFee"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "diagnosticFee": diagnosticFee,
        "hourlyFee": hourlyFee,
    };
}