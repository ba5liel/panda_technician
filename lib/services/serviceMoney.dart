String removeZero(double money) {
  var response = money.toString();

  if (money.toString().split(".").length > 0) {
    var decmialPoint = money.toString().split(".")[1];
    if (decmialPoint == "0") {
      response = response.split(".0").join("");
    }
    if (decmialPoint == "00") {
      response = response.split(".00").join("");
    }
  }

  return response;
}

String removeZeroFromString(String money) {
  var response = money;
  if (money.split(".").length > 0) {
    print("moneyzzzzz: " + money);
    var decmialPoint = money.split(".")[1];
    if (decmialPoint == "0") {
      response = response.split(".0").join("");
    }
    if (decmialPoint == "00") {
      response = response.split(".00").join("");
    }
  }

  return response;
}
