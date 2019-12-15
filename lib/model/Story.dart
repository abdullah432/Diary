class Story {
  int _id;
  String _date;
  String _feeling;
  String _reason;
  String _note;

  Story(this._date, this._feeling, this._reason, [this._note]);
  Story.withID(this._date, this._feeling, this._reason, [this._note]);

  int get id => this._id;
  String get date => this._date;
  String get feeling => this._feeling;
  String get reason => this._reason;
  String get note => this._note;

  set date(String date) {
    this._date = date;
  }

  set feeling(String feeling) {
    this._feeling = feeling;
  }

  set reason(String reason) {
    this._reason = reason;
  }

  set note(String note) {
    this._note = note;
  }

  //Convert Story object to map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null)
      map['id'] = _id;
    map['date'] = _date;
    map['feeling'] = _feeling;
    map['reason'] = _reason;
    map['note'] = _note;

    return map;
  }

  //Convert Map object to Story object
  Story.fromMapObject(Map<String, dynamic> map){
    _id = map['id'];
    _date = map['date'];
    _feeling = map['feeling'];
    _reason = map['reason'];
    _note = map['note'];
  }
}
