import 'package:get/get.dart';
import 'package:giphy_app/features/home/data/model/trending_gifs_model.dart';
import 'package:giphy_app/features/home/data/repository/trending_repo.dart';

class TrendingGifsController extends GetxController {
  final TrendingRepo trendingRepo = TrendingRepo();
  var trendingGifs = <Datum>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchTrendingGifs();
    super.onInit();
  }

  Future<void> fetchTrendingGifs() async {
    try {
      isLoading(true);
      errorMessage('');
      final response = await trendingRepo.getTrendingGifs();
      final gifs = TrendingGifsModel.fromJson(response);
      if (gifs.data != null) {
        trendingGifs.assignAll(gifs.data!);
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
