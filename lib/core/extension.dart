extension ExtractLastFourAndRest on String {
  List<String> extractLastFourAndRest() {
    if (this.length >= 4) {
      return [this.substring(this.length - 4), this.substring(0, this.length - 4)];
    } else {
      throw Exception("String is too short to extract last four characters.");
    }
  }
}