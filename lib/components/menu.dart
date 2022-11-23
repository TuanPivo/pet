import 'package:apporder/utils/custom.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ReviewUI extends StatelessWidget {
  final String image, name, date, comment;
  final double rating;
  final Function() onTap, onPressed;
  final bool isLess;
  const ReviewUI({
    Key? key,
    required this.image,
    required this.name,
    required this.date,
    required this.comment,
    required this.rating,
    required this.onTap,
    required this.isLess,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 2.0,
        bottom: 2.0,
        left: 16.0,
        right: 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 45.0,
                width: 45.0,
                margin: EdgeInsets.only(right: 16.0),
                child: CachedNetworkImage(
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(44.0),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              SmoothStarRating(
                starCount: 5,
                rating: rating,
                size: 28.0,
                color: Colors.orange,
                borderColor: Colors.orange,
              ),
              SizedBox(width: 10),
              Text(
                date,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: onTap,
            child: isLess
                ? Text(
                    comment,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Palette.animationColor,
                    ),
                  )
                : Text(
                    comment,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Palette.animationColor,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
