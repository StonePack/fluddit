import 'package:fluddit/models/index.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GalleryContent extends StatelessWidget {
  GalleryContent({
    Key? key,
    required this.constraints,
    required this.post,
  }) : super(key: key);

  final BoxConstraints constraints;
  final RedditPost post;

  @override
  Widget build(BuildContext context) {
    print(post.galleryData);
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        height: constraints.maxHeight - 115,
        viewportFraction: 1,
      ),
      items: List.generate(
        post.galleryData.length,
        (i) {
          final String mediaId = post.galleryData[i]['media_id'];
          final String contentType = post.metaData[mediaId]['m'].split('/')[1];

          return Stack(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Image.network(
                  'https://i.redd.it/$mediaId.$contentType',
                  width: MediaQuery.of(context).size.width,
                  height: constraints.maxHeight - 115,
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.all(15),
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.black45,
                  child: Text('${i + 1} / ${post.galleryData.length}'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}