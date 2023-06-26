class Notes
{
  int? note_id;
  String? note_name;
  String? note_description;
  int? color;
  String? date;
  String? time;

  Notes({
    this.note_id,
    this.note_name,
    this.note_description,
    this.date,
    this.color,
    this.time,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    note_id: int.parse(json["note_id"]),
    note_name: json["note_name"],
    note_description: json['note_description'],
    date: json['date'],
    color: json['color'],
    time: json['time'],
  );
}