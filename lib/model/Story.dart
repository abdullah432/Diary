class Story {
  int _id;
  String _title;
  String _date;
  String _feeling;
  String _reason;
  String _whatHappened;
  String _note;

  Story(
      this._title, this._date, this._feeling, this._reason, this._whatHappened,
      [this._note]);
  Story.withID(
      this._title, this._date, this._feeling, this._reason, this._whatHappened,
      [this._note]);

  int get id => this._id;
  String get title => this._title;
  String get date => this._date;
  String get feeling => this._feeling;
  String get reason => this._reason;
  String get whatHappened => this._whatHappened;
  String get note => this._note;

  set title(String title) {
    this._title = title;
  }

  set date(String date) {
    this._date = date;
  }

  set feeling(String feeling) {
    this._feeling = feeling;
  }

  set reason(String reason) {
    this._reason = reason;
  }

  set whatHappened(String text) {
    this._whatHappened = text;
  }

  set note(String note) {
    this._note = note;
  }

  //Convert Story object to map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) map['id'] = _id;
    map['title'] = _title;
    map['date'] = _date;
    map['feeling'] = _feeling;
    map['reason'] = _reason;
    map['whatHappened'] = _whatHappened;
    map['note'] = _note;

    return map;
  }

  //Convert Map object to Story object
  Story.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _date = map['date'];
    _feeling = map['feeling'];
    _reason = map['reason'];
    _whatHappened = map['whatHappened'];
    _note = map['note'];
  }
}
