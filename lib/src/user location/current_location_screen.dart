import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

import 'image_provider.dart';
import 'image_upload_page.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

const kGoogleApiKey = 'AIzaSyD6ysBfnoOV7B28zqb5Ukr7Q-GnmBx2ud4';

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  Set<Marker> markersList = {};
  TextEditingController searchController = TextEditingController();
  bool showSuggestions = false;
  bool isLoading = false;

  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(6.490, 3.384), zoom: 16);

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Prediction> predictions = [];

  Future<void> _fetchPlacePredictions(String searchText) async {
    try {
      final places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
      PlacesAutocompleteResponse response = await places.autocomplete(
        searchText,
        components: [Component(Component.country, "ng")],
        language: 'en',
        types: [],
        strictbounds: false,
      );

      setState(() {
        predictions = response.predictions;
        showSuggestions = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching place predictions: $e'),
        backgroundColor: Colors.black.withOpacity(0.7),
      ));
    }
  }

  Future<void> _getUserLocation() async {
    try {
      setState(() {
        isLoading = true;
      });

      Position position = await _determinePosition();

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              position.latitude,
              position.longitude,
            ),
            zoom: 20,
          ),
        ),
      );

      markersList.clear();

      markersList.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(
            position.latitude,
            position.longitude,
          ),
        ),
      );

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied permanently');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));
  }

  Future<void> displayPrediction(Prediction p, BuildContext context) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(
      Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name),
      ),
    );

    googleMapController.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, lng), 20.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final userPictureProvider = context.watch<UserPictureProvider>();
    final userPicture = userPictureProvider.userPicture;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: isLoading
                ? initialCameraPosition
                : markersList.isNotEmpty
                    ? CameraPosition(
                        target: markersList.first.position,
                        zoom: 16,
                      )
                    : initialCameraPosition,
            markers: markersList,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              width: double.maxFinite,
              height: screenHeight * 0.16,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.044,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (userPicture != null)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ImageUploadScreen(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: FileImage(userPicture),
                          ),
                        )
                      else
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ImageUploadScreen(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color(0xff99cc9b),
                            child: Center(
                              child: Text(
                                'AB',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.056,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(
                        width: 100,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: screenWidth * 0.05,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.014,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.78,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (text) {
                            // Show suggestions when there's text in the search field
                            setState(() {
                              showSuggestions = text.isNotEmpty;
                            });
                            _fetchPlacePredictions(text);
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Clear the search field and results
                          setState(() {
                            searchController.clear();
                            predictions.clear();
                            showSuggestions = false; // Hide suggestions
                          });
                        },
                        child: const Text('clear'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (showSuggestions)
            Positioned(
              top: screenHeight * 0.158,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight * 0.43,
                color: Colors.white,
                width: double.maxFinite,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.maxFinite,
                      height: screenHeight * 0.08,
                      color: Colors.white,
                      child: ListTile(
                        title: Text(predictions[index].description ??
                            'No description available'),
                        onTap: () {
                          if (predictions[index] != null) {
                            displayPrediction(predictions[index], context);
                            // Hide the suggestion pop-up
                            setState(() {
                              showSuggestions = false;
                            });
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getUserLocation,
        child: const Icon(
          Icons.location_searching_outlined,
          size: 35,
        ),
      ),
    );
  }
}