import 'dart:io';

import 'package:flutter/foundation.dart';

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.location,
  });
}

class PlaceLocation {
  final double lat;
  final double lng;
  final String adress;

  PlaceLocation({
    @required this.lat,
    @required this.lng,
    this.adress,
  });
}
