extension FirstToUpper on String {
  firstToUpper() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension AddCeros on String {
  addCeros() {
    String auxId = '';

    if (int.parse(this) < 1000) {
      if (int.parse(this) < 10) {
        auxId = '00$this';
      } else if (int.parse(this) < 100) {
        auxId = '0$this';
      } else {
        auxId = this;
      }
    }

    return auxId;
  }
}
