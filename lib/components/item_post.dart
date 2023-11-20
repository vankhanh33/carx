import 'package:cached_network_image/cached_network_image.dart';
import 'package:carx/utilities/app_colors.dart';
import 'package:carx/utilities/app_text.dart';
import 'package:flutter/material.dart';

class PostItem extends StatefulWidget {
  const PostItem({super.key});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: CachedNetworkImage(
                    imageUrl: images[0],
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/China-Construction-Bank.png',
                      width: 52,
                      height: 52,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ayaya Rental',
                      style: AppText.subtitle3,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      '16 hours ago',
                      style: AppText.body2.copyWith(color: AppColors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              images[0],
              style: AppText.body2,
              textAlign: TextAlign.justify,
            ),
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: images.length == 1 ? 1 : 2,
                childAspectRatio: 1.0,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: images[index],
                errorWidget: (context, url, error) {
                  return Image.asset('assets/images/logo-dark.png');
                },
              );
            },
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: images.length > 4 ? 4 : images.length,
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '10 like',
                  style: AppText.bodyFontColor,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  '1 comments',
                  style: AppText.bodyFontColor,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          const Divider(
            height: 24,
            thickness: 1,
            color: AppColors.lightGray,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        size: 20,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Like',
                        style: AppText.bodyFontColor,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: const Row(
                    children: [
                      Icon(
                        Icons.message_rounded,
                        size: 20,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Comment',
                        style: AppText.bodyFontColor,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: const Row(
                    children: [
                      Icon(
                        Icons.share,
                        size: 20,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Share',
                        style: AppText.bodyFontColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const images = [
  'https://upload.wikimedia.org/wikipedia/vi/0/0a/Genshin_Impact_cover.jpg',
  'https://static.wikia.nocookie.net/gensin-impact/images/1/16/Rosaria_Card.png/revision/latest/scale-to-width/360?cb=20210330063015',
  'https://static.wikia.nocookie.net/gensin-impact/images/1/16/Rosaria_Card.png/revision/latest/scale-to-width/360?cb=20210330063015',
  'https://chevroletauto.110.vn/files/product/1597/16-04-2019/1_25tNLf51.png',
  
];
