class CoursesModel {
  CoursesModel({
    this.message,
    this.courses,
  });

  final String? message;
  final List<CoursesModelCourse>? courses;

  factory CoursesModel.fromJson(Map<String, dynamic> json) {
    return CoursesModel(
      message: json["message"],
      courses: json["courses"] == null
          ? []
          : List<CoursesModelCourse>.from(
              json["courses"]!.map((x) => CoursesModelCourse.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "courses": courses!.map((x) => x.toJson()).toList(),
      };
}

class CoursesModelCourse {
  CoursesModelCourse({
    required this.levelCount,
    required this.levels,
    required this.techStack,
    required this.resourcesGeneral,
    required this.resourcesTools,
    required this.status,
    required this.id,
    required this.courses,
  });

  final int? levelCount;
  final List<dynamic> levels;
  final List<dynamic> techStack;
  final List<dynamic> resourcesGeneral;
  final List<dynamic> resourcesTools;
  final String? status;
  final String? id;
  final List<CourseCourse> courses;

  factory CoursesModelCourse.fromJson(Map<String, dynamic> json) {
    return CoursesModelCourse(
      levelCount: json["levelCount"],
      levels: json["levels"] == null
          ? []
          : List<dynamic>.from(json["levels"]!.map((x) => x)),
      techStack: json["techStack"] == null
          ? []
          : List<dynamic>.from(json["techStack"]!.map((x) => x)),
      resourcesGeneral: json["resourcesGeneral"] == null
          ? []
          : List<dynamic>.from(json["resourcesGeneral"]!.map((x) => x)),
      resourcesTools: json["resourcesTools"] == null
          ? []
          : List<dynamic>.from(json["resourcesTools"]!.map((x) => x)),
      status: json["status"],
      id: json["_id"],
      courses: json["courses"] == null
          ? []
          : List<CourseCourse>.from(
              json["courses"]!.map((x) => CourseCourse.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "levelCount": levelCount,
        "levels": levels.map((x) => x).toList(),
        "techStack": techStack.map((x) => x).toList(),
        "resourcesGeneral": resourcesGeneral.map((x) => x).toList(),
        "resourcesTools": resourcesTools.map((x) => x).toList(),
        "status": status,
        "_id": id,
        "courses": courses.map((x) => x.toJson()).toList(),
      };
}

class CourseCourse {
  CourseCourse({
    required this.flutter,
    required this.mean,
    required this.uiUx,
  });

  final Flutter? flutter;
  final Flutter? mean;
  final Flutter? uiUx;

  factory CourseCourse.fromJson(Map<String, dynamic> json) {
    return CourseCourse(
      flutter:
          json["flutter"] == null ? null : Flutter.fromJson(json["flutter"]),
      mean: json["mean"] == null ? null : Flutter.fromJson(json["mean"]),
      uiUx: json["ui_ux"] == null ? null : Flutter.fromJson(json["ui_ux"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "flutter": flutter?.toJson(),
        "mean": mean?.toJson(),
        "ui_ux": uiUx?.toJson(),
      };
}

class Flutter {
  Flutter({
    required this.title,
    required this.description,
    required this.levels,
    required this.finalProject,
    required this.resources,
  });

  final String? title;
  final String? description;
  final List<Level> levels;
  final FinalProject? finalProject;
  final Resources? resources;

  factory Flutter.fromJson(Map<String, dynamic> json) {
    return Flutter(
      title: json["title"],
      description: json["description"],
      levels: json["levels"] == null
          ? []
          : List<Level>.from(json["levels"]!.map((x) => Level.fromJson(x))),
      finalProject: json["final_project"] == null
          ? null
          : FinalProject.fromJson(json["final_project"]),
      resources: json["resources"] == null
          ? null
          : Resources.fromJson(json["resources"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "levels": levels.map((x) => x.toJson()).toList(),
        "final_project": finalProject?.toJson(),
        "resources": resources?.toJson(),
      };
}

class FinalProject {
  FinalProject({
    required this.name,
    required this.description,
    required this.features,
    required this.techStack,
    required this.duration,
    required this.reviewGuidance,
  });

  final String? name;
  final String? description;
  final List<String> features;
  final List<String> techStack;
  final String? duration;
  final String? reviewGuidance;

  factory FinalProject.fromJson(Map<String, dynamic> json) {
    return FinalProject(
      name: json["name"],
      description: json["description"],
      features: json["features"] == null
          ? []
          : List<String>.from(json["features"]!.map((x) => x)),
      techStack: json["tech_stack"] == null
          ? []
          : List<String>.from(json["tech_stack"]!.map((x) => x)),
      duration: json["duration"],
      reviewGuidance: json["review_guidance"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "features": features.map((x) => x).toList(),
        "tech_stack": techStack.map((x) => x).toList(),
        "duration": duration,
        "review_guidance": reviewGuidance,
      };
}

class Level {
  Level({
    required this.level,
    required this.name,
    required this.duration,
    required this.goals,
    required this.topics,
    required this.tasks,
    required this.resources,
  });

  final String? level;
  final String? name;
  final String? duration;
  final String? goals;
  final List<Topic> topics;
  final List<Task> tasks;
  final List<String> resources;

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      level: json["level"],
      name: json["name"],
      duration: json["duration"],
      goals: json["goals"],
      topics: json["topics"] == null
          ? []
          : List<Topic>.from(json["topics"]!.map((x) => Topic.fromJson(x))),
      tasks: json["tasks"] == null
          ? []
          : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
      resources: json["resources"] == null
          ? []
          : List<String>.from(json["resources"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "level": level,
        "name": name,
        "duration": duration,
        "goals": goals,
        "topics": topics.map((x) => x.toJson()).toList(),
        "tasks": tasks.map((x) => x.toJson()).toList(),
        "resources": resources.map((x) => x).toList(),
      };
}

class Task {
  Task({
    required this.type,
    required this.name,
    required this.description,
    required this.features,
    required this.reviewGuidance,
  });

  final String? type;
  final String? name;
  final String? description;
  final List<String> features;
  final String? reviewGuidance;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      type: json["type"],
      name: json["name"],
      description: json["description"],
      features: json["features"] == null
          ? []
          : List<String>.from(json["features"]!.map((x) => x)),
      reviewGuidance: json["review_guidance"],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "description": description,
        "features": features.map((x) => x).toList(),
        "review_guidance": reviewGuidance,
      };
}

class Topic {
  Topic({
    required this.name,
    required this.subtopics,
    required this.duration,
  });

  final String? name;
  final List<String> subtopics;
  final String? duration;

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      name: json["name"],
      subtopics: json["subtopics"] == null
          ? []
          : List<String>.from(json["subtopics"]!.map((x) => x)),
      duration: json["duration"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "subtopics": subtopics.map((x) => x).toList(),
        "duration": duration,
      };
}

class Resources {
  Resources({
    required this.general,
    required this.tools,
  });

  final List<String> general;
  final List<String> tools;

  factory Resources.fromJson(Map<String, dynamic> json) {
    return Resources(
      general: json["general"] == null
          ? []
          : List<String>.from(json["general"]!.map((x) => x)),
      tools: json["tools"] == null
          ? []
          : List<String>.from(json["tools"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "general": general.map((x) => x).toList(),
        "tools": tools.map((x) => x).toList(),
      };
}
