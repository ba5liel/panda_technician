class Services {
  Services(
      {this.diagnosticServices = true,
      this.dignoasticFee = 0,
      this.hourlyFee = 0,
      this.repairServices = true});

  bool diagnosticServices;
  double dignoasticFee;
  double hourlyFee;

  bool repairServices;
}
