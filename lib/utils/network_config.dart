class NetworkConfig {
  NetworkConfig._();

  static final NetworkConfig _instance = NetworkConfig._();

  factory NetworkConfig() => _instance;

  String get baseUrl {
    return "https://6169a28b09e030001712c4dc.mockapi.io/";
  }
}
