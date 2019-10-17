class User {
  String gender;
  String nickName;
  String headImageUrl;
  int id;
  String token;

  User({this.gender, this.nickName, this.headImageUrl, this.id, this.token});

  User.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    nickName = json['nickName'];
    headImageUrl = json['headImageUrl'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['nickName'] = this.nickName;
    data['headImageUrl'] = this.headImageUrl;
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }

  @override
  String toString() {
    return 'User{gender: $gender, nickName: $nickName, headImageUrl: $headImageUrl, id: $id, token: $token}';
  }
}
