const GOOGLE_API_KEY = "AIzaSyB8ajCeTVXpR3NPLDKcY8VdR_0XR9Ugcfo";

class LocationHelper {
  static String generateLocationPreviewImage({double lat, double lng}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$lat,$lng&key=$GOOGLE_API_KEY';
  }
}
