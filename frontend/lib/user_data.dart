class User {
  String? phone;
  String? name;
  String? surname;
  String? birth;
  String? telegramRequestId;

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

  void setTelegramRequestId(String? requestId) {
    this.telegramRequestId = requestId;
  }
}

User user = User();
