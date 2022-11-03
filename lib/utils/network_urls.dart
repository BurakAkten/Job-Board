import 'network_config.dart';

class NetworkUrls {
  final _baseUrl = NetworkConfig().baseUrl;

  //URL
  final String _jobs = "jobs";

  //ENDPoint
  String get jobsUrl => _baseUrl + _jobs;
}
