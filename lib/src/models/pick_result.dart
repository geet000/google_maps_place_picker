import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:collection/collection.dart';

class PickResult {
  PickResult({
    this.placeId,
    this.geometry,
    this.formattedAddress,
    this.types,
    this.addressComponents,
    this.adrAddress,
    this.formattedPhoneNumber,
    this.id,
    this.reference,
    this.icon,
    this.name,
    this.openingHours,
    this.photos,
    this.internationalPhoneNumber,
    this.priceLevel,
    this.rating,
    this.scope,
    this.url,
    this.vicinity,
    this.utcOffset,
    this.website,
    this.reviews,
    this.state = '',
    this.city = '',
    this.pincode = '',
  });

  final String? placeId;
  final Geometry? geometry;
  final String? formattedAddress;
  final List<String>? types;
  final List<AddressComponent>? addressComponents;
  final String state;
  final String city;
  final String pincode;

  // Below results will not be fetched if 'usePlaceDetailSearch' is set to false (Defaults to false).
  final String? adrAddress;
  final String? formattedPhoneNumber;
  final String? id;
  final String? reference;
  final String? icon;
  final String? name;
  final OpeningHoursDetail? openingHours;
  final List<Photo>? photos;
  final String? internationalPhoneNumber;
  final PriceLevel? priceLevel;
  final num? rating;
  final String? scope;
  final String? url;
  final String? vicinity;
  final num? utcOffset;
  final String? website;
  final List<Review>? reviews;

  factory PickResult.fromGeocodingResult(GeocodingResult result) {
    final String state = _getAddressComponent(
        result.addressComponents, "administrative_area_level_1");
    final String city = _getAddressComponent(
        result.addressComponents, "administrative_area_level_2");
    final String pincode =
        _getAddressComponent(result.addressComponents, "postal_code");

    return PickResult(
      placeId: result.placeId,
      geometry: result.geometry,
      formattedAddress: result.formattedAddress,
      types: result.types,
      addressComponents: result.addressComponents,
      state: state,
      city: city,
      pincode: pincode,
    );
  }

  static String _getAddressComponent(
          List<AddressComponent> addressComponents, String key) =>
      addressComponents
          .firstWhereOrNull((comp) => comp.types.contains("street_number"))
          ?.longName
          .toLowerCase() ??
      '';

  factory PickResult.fromPlaceDetailResult(PlaceDetails result) {
    final String state = _getAddressComponent(
        result.addressComponents, "administrative_area_level_1");
    final String city = _getAddressComponent(
        result.addressComponents, "administrative_area_level_2");
    final String pincode =
        _getAddressComponent(result.addressComponents, "postal_code");
    return PickResult(
      placeId: result.placeId,
      geometry: result.geometry,
      formattedAddress: result.formattedAddress,
      types: result.types,
      addressComponents: result.addressComponents,
      adrAddress: result.adrAddress,
      formattedPhoneNumber: result.formattedPhoneNumber,
      id: result.id,
      reference: result.reference,
      icon: result.icon,
      name: result.name,
      openingHours: result.openingHours,
      photos: result.photos,
      internationalPhoneNumber: result.internationalPhoneNumber,
      priceLevel: result.priceLevel,
      rating: result.rating,
      scope: result.scope,
      url: result.url,
      vicinity: result.vicinity,
      utcOffset: result.utcOffset,
      website: result.website,
      reviews: result.reviews,
      state: state,
      city: city,
      pincode: pincode,
    );
  }

  @override
  String toString() {
    return 'PickResult(placeId: $placeId, geometry: $geometry, formattedAddress: $formattedAddress, types: $types, addressComponents: ${addressComponents?.map((e) => e.toJson())}, adrAddress: $adrAddress, formattedPhoneNumber: $formattedPhoneNumber, id: $id, reference: $reference, icon: $icon, name: $name, openingHours: $openingHours, photos: $photos, internationalPhoneNumber: $internationalPhoneNumber, priceLevel: $priceLevel, rating: $rating, scope: $scope, url: $url, vicinity: $vicinity, utcOffset: $utcOffset, website: $website, reviews: $reviews)';
  }
}
