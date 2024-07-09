import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:giphy_app/features/home/presentation/controller/trending_gifs_controller.dart';

class TrendingGifsScreen extends StatelessWidget {
  final TrendingGifsController controller = Get.put(TrendingGifsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giphy'),
        leading: SvgPicture.asset('assets/giphy.svg'),
        elevation: 4,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.purple),
          );
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${controller.errorMessage}'));
        } else if (controller.trendingGifs.isEmpty) {
          return const Center(child: Text('No trending GIFs found'));
        } else {
          return GridView.builder(
            padding: EdgeInsets.all(0.010.sh),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: controller.trendingGifs.length,
            itemBuilder: (context, index) {
              final gif = controller.trendingGifs[index];
              final gifUrl = gif.images?.fixedHeight?.url ?? '';
              return GridTile(
                child: Image.network(
                  gifUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                        color: Colors.purple,
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
