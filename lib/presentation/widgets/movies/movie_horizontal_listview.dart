import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.loadNextPage,
    this.subTitle
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: <Widget>[
          if(title != null || subTitle != null) _Title(
            title: title,
            subTitle: subTitle,
          ),

          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _Slide(movie: movies[index]);
              },
            ),
          ),

        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  
  const _Slide({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null){
                    return const Center(child: CircularProgressIndicator(strokeWidth: 2,));
                  }

                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.star_half_outlined,
                color: Colors.yellow.shade800,
              ),
              const SizedBox(width: 3,),
              Text(
                '${movie.voteAverage}',
                style: textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800),
              ),
              const SizedBox(width: 10,),
              Text(
                '${HumanFormat.number(movie.popularity)}K',
                style: textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800),
              )
            ],
          )
        ],
      ),
    );
  }
}


class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({
    this.title,
    this.subTitle,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          if(title != null) Text(title!, style: titleStyle,),
          const Spacer(),
          if(title != null) FilledButton(
            style: const ButtonStyle( visualDensity: VisualDensity.compact),
            child: Text(subTitle!,),
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}

