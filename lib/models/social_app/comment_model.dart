class CommentModel
{
  late String name;
  late String uId;
  late String dateTime;
  late String text;

  CommentModel({
    required this.name,
    required this.uId,

    required this.dateTime,
    required this.text,

  });

  CommentModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'uId':uId,
      'dateTime':dateTime,
      'text':text,
    };
  }
}