import 'package:flutter/material.dart';
import 'package:muplix/model/movie.dart';
import 'package:muplix/detail_movie_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Muplix', style: TextStyle(fontFamily: 'Nuvel'),),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return MovieListGrid(gridCount: 2);
          } else if (constraints.maxWidth <= 1200) {
            return MovieListGrid(gridCount: 4);
          } else {
            return MovieListGrid(gridCount: 6);
          }
        },
      ),
    );
  }
}

class MovieListGrid extends StatelessWidget {
  final int gridCount;
  const MovieListGrid({Key? key, required this.gridCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16
        ),
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          final Movie movie = movieList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailMoviePage(movie: movie, index: index)
              ));
            },
            child: Card(
              color: Colors.pink,
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)
                        ),
                        child: Hero(
                          tag: "posterHero-$index",
                          transitionOnUserGestures: true,
                          child: Image.asset(
                            movie.poster,
                            fit: BoxFit.fill,
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Mustica Pro',
                        fontSize: 14.0,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}