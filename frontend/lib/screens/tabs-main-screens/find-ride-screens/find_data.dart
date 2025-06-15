class DataSearch {
  String? from;
  String? to;
  String? date;
  String? passengers;

  DataSearch.empty() {
    from = '';
    to = '';
    date = '';
    passengers = '';
  }

  DataSearch(String? from, String? to, String? date, String? passengers) {
    this.from;
    this.to;
    this.date;
    this.passengers;
  }
}

DataSearch userSearch = DataSearch.empty();
