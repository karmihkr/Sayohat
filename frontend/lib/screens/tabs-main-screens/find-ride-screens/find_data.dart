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
    this.from = from;
    this.to = to;
    this.date = date;
    this.passengers = passengers;
  }
}

DataSearch userSearch = DataSearch.empty();
