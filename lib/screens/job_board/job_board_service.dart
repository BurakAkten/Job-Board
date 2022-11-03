import '../../base/network_manager.dart';
import '../../utils/network_urls.dart';

class JobBoardService {
  Future<NetworkResponse> getJobs() async {
    var url = NetworkUrls().jobsUrl;
    return await NetworkManager().makeRequest(url);
  }
}
