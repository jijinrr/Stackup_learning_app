class UsersModel {
  String? message;
  List<User>? users;

  UsersModel({
    this.message,
    this.users,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        message: json["message"],
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class User {
  String? id;
  String? email;
  String? profileUrl;
  String? firstName;
  String? lastName;
  int? age;
  String? qualification;
  String? phoneNumber;
  String? selectedCourse;
  String? place;
  String? bio;
  String? progressLevel;
  String? coursePercentage;
  String? course;
  int? typingPercentage;
  int? englishPercentage;
  int? softSkillPercentage;
  int? speakingPercentage;

  User({
    this.id,
    this.email,
    this.profileUrl,
    this.firstName,
    this.lastName,
    this.age,
    this.qualification,
    this.phoneNumber,
    this.selectedCourse,
    this.place,
    this.bio,
    this.progressLevel,
    this.coursePercentage,
    this.course,
    this.typingPercentage,
    this.englishPercentage,
    this.softSkillPercentage,
    this.speakingPercentage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        profileUrl: json["profileUrl"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        age: json["age"],
        qualification: json["qualification"],
        phoneNumber: json["phoneNumber"],
        selectedCourse: json["selectedCourse"],
        place: json["place"],
        bio: json["bio"],
        progressLevel: json["progressLevel"],
        coursePercentage: json["coursePercentage"].toString(),
        course: json["course"],
        typingPercentage: json["typingPercentage"],
        englishPercentage: json["englishPercentage"],
        softSkillPercentage: json["softSkillPercentage"],
        speakingPercentage: json["speakingPercentage"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "profileUrl": profileUrl,
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "qualification": qualification,
        "phoneNumber": phoneNumber,
        "selectedCourse": selectedCourse,
        "place": place,
        "bio": bio,
        "progressLevel": progressLevel,
        "coursePercentage": coursePercentage,
        "course": course,
        "typingPercentage": typingPercentage,
        "englishPercentage": englishPercentage,
        "softSkillPercentage": softSkillPercentage,
        "speakingPercentage": speakingPercentage,
      };
}
