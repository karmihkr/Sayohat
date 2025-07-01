class User {
  String? phone;
  String? name;
  String? surname;
  String? birth;
  String? vericodeRequestId;

  void setPhone(String? phone) {
    this.phone = phone;
  }

  void setName(String? name) {
    this.name = name;
  }

  void setSurname(String? surname) {
    this.surname = surname;
  }

  void setBirth(String? birth) {
    this.birth = birth;
  }

  void setVericodeRequestId(String? requestId) {
    this.vericodeRequestId = requestId;
  }
}

User user = User();
