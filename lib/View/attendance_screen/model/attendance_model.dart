class AttendanceModel {
  String? message;
  List<AttendanceModelAttendance>? attendance;

  AttendanceModel({
    this.message,
    this.attendance,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        message: json["message"],
        attendance: json["attendance"] == null
            ? []
            : List<AttendanceModelAttendance>.from(json["attendance"]!
                .map((x) => AttendanceModelAttendance.fromJson(x))),
      );
}

class AttendanceModelAttendance {
  String? id;
  String? email;
  List<AttendanceAttendance>? attendance;

  AttendanceModelAttendance({
    this.id,
    this.email,
    this.attendance,
  });

  factory AttendanceModelAttendance.fromJson(Map<String, dynamic> json) =>
      AttendanceModelAttendance(
        id: json["_id"],
        email: json["email"],
        attendance: json["attendance"] == null
            ? []
            : List<AttendanceAttendance>.from(json["attendance"]!
                .map((x) => AttendanceAttendance.fromJson(x))),
      );
}

class AttendanceAttendance {
  String? date;
  String? checkIn;
  String? checkOut;
  double? hoursWorked;

  AttendanceAttendance({
    this.date,
    this.checkIn,
    this.checkOut,
    this.hoursWorked,
  });

  factory AttendanceAttendance.fromJson(Map<String, dynamic> json) =>
      AttendanceAttendance(
        date: json["date"],
        checkIn: json["checkIn"],
        checkOut: json["checkOut"],
        hoursWorked: json["hoursWorked"]?.toDouble(),
      );
}
