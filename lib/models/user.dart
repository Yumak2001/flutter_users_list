class User {
  late Name name;
  late Location location;
  late String username;
  late Picture picture;

  User(
    this.name,
    this.location,
    this.username,
    this.picture,
  );

  User.fromJson(Map json){
    name = Name.fromJson(json['name']);
    location = Location.fromJson(json['location']);
    username = json['login']['username'].toString();
    picture = Picture.fromJson(json['picture']);
  }
}

class Name {
  late String title;
  late String first;
  late String last;

  Name(
    this.title,
    this.first,
    this.last
  );

  Name.fromJson(Map json){
    title = json['title'].toString();
    first = json['first'].toString();
    last = json['last'].toString();
  }
}

class Location {
  late String street;
  late String city;
  late String state;
  late String postcode;

  Location(
    this.street,
    this.city,
    this.state,
    this.postcode
  );

  Location.fromJson(Map json){
    street = "${json['street']['number']} ${json['street']['name']}";
    city = json['city'].toString();
    state = json['state'].toString();
    postcode = json['postcode'].toString();
  }
}

class Picture {
  late String large;
  late String thumbnail;

  Picture(
    this.large,
    this.thumbnail
  );

  Picture.fromJson(Map json){
    large = json['large'].toString();
    thumbnail = json['thumbnail'].toString();
  }
}
