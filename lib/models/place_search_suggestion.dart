class PlaceSearch {
  final String description;
  final String placeId;
  final List<dynamic> types;

  PlaceSearch({required this.description,required this.placeId, required this.types});

  factory PlaceSearch.fromJson(Map<String,dynamic> json){
    return PlaceSearch(
        description: json['description'],
        placeId: json['place_id'],
        types: json.containsKey("types") ? json['types'] :[""]);
  }

  @override
  String toString() {
    return "Autocomplete SearchItem\nDescription: $description\nplace_id: $placeId\ntype: $types";
  }
}