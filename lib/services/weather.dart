import 'location.dart';
import 'networking.dart';

const apiKey = '07461019636662238b52a83cac7f32d0';
const baseUrl = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    String url =
        '$baseUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityData(cityName) {
    var url = '$baseUrl?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }
}
