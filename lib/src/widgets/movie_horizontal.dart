import 'package:flutter/material.dart';
import 'package:movieapp/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget{

  final List<Movie> movies;
  final Function nextPage;
  MovieHorizontal( {@required this.movies, @required this.nextPage });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build( BuildContext context ){

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( (){

      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ){
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _cards( context ),
        itemCount: movies.length,
        itemBuilder: ( BuildContext context, int index ){

          return _card( context, movies[index]);
        },
      ),
    );
  }

  Widget _card( BuildContext context, Movie movie ){
    final movieCard = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.fill,
                height: 80.0,
              ),
            ),
            SizedBox(height: 4.0,),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        )
      );

      return GestureDetector(
        child: movieCard,
        onTap: (){
          Navigator.pushNamed( context, 'detail', arguments: movie );
        },
      );
  }
}