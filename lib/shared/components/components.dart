import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(article)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover
            )
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "'${article['title']}'",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "'${article['publishedAt']}'",
                style: TextStyle(
                    color: Colors.grey
                ),
              )
            ],
          ),
        ),
      )
    ],
  ),
);


Widget articleBuilder(list) => ConditionalBuilder(
  condition:list.length>0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index]),
    separatorBuilder: (context, index) => Divider(
      height: 5,
      thickness: 1.5,
      endIndent: 20,
      indent: 20,
    ),
    itemCount: list.length,
  ),
  fallback: (context) => Center(child: CircularProgressIndicator()),
);