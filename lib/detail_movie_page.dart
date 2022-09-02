import 'package:flutter/material.dart';
import 'package:muplix/model/movie.dart';
import 'package:intl/intl.dart';

class DetailMoviePage extends StatelessWidget {
  final int? index;
  final Movie movie;
  const DetailMoviePage({Key? key, required this.movie, this.index}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 800) {
        return DetailWebPage(movie: movie, index: index);
      }
      else {
        return DetailMobilePage(movie: movie, index: index);
      }
    });
  }
}

class DetailMobilePage extends StatelessWidget{
  final int? index;
  final Movie movie;
  const DetailMobilePage({Key? key, required this.movie, this.index}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    var mediumItalicTextStyle = const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, color: Colors.white,);
    var mediumTextStyle = const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Colors.white70,);
    var titleTextStyle = const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 24,);
    var regularTextStyle = const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500, color: Colors.black54,);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: "posterHero-$index",
                      transitionOnUserGestures: true,
                      child: Image.asset(movie.poster),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.pink,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.pink,
                padding: const EdgeInsets.fromLTRB(16, 3, 3, 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(movie.genre, style: mediumItalicTextStyle),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const Icon(Icons.access_time, color: Colors.white),
                              Text(movie.duration, style: mediumTextStyle)
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              const Icon(Icons.star_half_outlined, color: Colors.yellow),
                              Text('${movie.userScores}/100', style: mediumTextStyle)
                            ],
                          ),
                          const FavoriteButton()
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                    '${movie.title} (${movie.year}) (${movie.country})',
                    style: titleTextStyle,
                    textAlign: TextAlign.center
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(movie.overview, style: regularTextStyle, textAlign: TextAlign.justify),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Table(
                  columnWidths: const<int, TableColumnWidth>{
                    0: FixedColumnWidth(100),
                    1: FixedColumnWidth(200),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow( children: [
                      const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('Release Date'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(getFormattedDate(movie.releaseDate), style: regularTextStyle),
                      )
                    ]),
                    TableRow( children: [
                      const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('Story'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(movie.story, style: regularTextStyle),
                      )
                    ]),
                    TableRow( children: [
                      const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('Character'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(movie.character, style: regularTextStyle),
                      )
                    ]),
                    TableRow( children: [
                      const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('Screenplay'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(movie.screenplay, style: regularTextStyle),
                      )
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

}

class DetailWebPage extends StatelessWidget{
  final int? index;
  final Movie movie;
  const DetailWebPage({Key? key, required this.movie, this.index}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    var mediumItalicTextStyle = const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, color: Colors.white, fontSize: 22,);
    var mediumTextStyle = const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Colors.white70, fontSize: 22,);
    var titleTextStyle = const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 36,);
    var regularTextStyle = const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500, color: Colors.black54, fontSize: 22,);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Muplix', style: TextStyle(fontFamily: 'Nuvel'),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(64, 0, 64, 64),
          child: Center(
            child: SizedBox(
                width: 1200,
                child: Column(
                  children: [
                    Container(
                      color: Colors.pink,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Hero(
                              tag: "posterHero-$index",
                              transitionOnUserGestures: true,
                              child: Image.asset(movie.poster, height: 600),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(18),
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(movie.year, style: mediumTextStyle),
                                Text(movie.country, style: mediumTextStyle),
                                Text(movie.duration, style: mediumTextStyle)
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(movie.genre, style: mediumItalicTextStyle, textAlign: TextAlign.center),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${movie.userScores}/100", style: mediumTextStyle),
                                const Icon(Icons.star_half_outlined, color: Colors.yellow, size: 28)
                              ],
                            ),
                          ),
                          const FavoriteButton()
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(movie.title, style: titleTextStyle),
                    const SizedBox(height: 10),
                    Card(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                      movie.overview,
                                      textAlign: TextAlign.justify,
                                      style: regularTextStyle
                                  ),
                                ),
                                const SizedBox(width: 50),
                                Expanded(
                                  child: Table(
                                    columnWidths: const<int, TableColumnWidth>{
                                      0: FixedColumnWidth(100),
                                      1: FixedColumnWidth(200)
                                    },
                                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                    children: [
                                      TableRow( children: [
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text('Release Date', style: TextStyle(fontSize: 22)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(getFormattedDate(movie.releaseDate), style: regularTextStyle),
                                        )
                                      ]),
                                      TableRow( children: [
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text('Story', style: TextStyle(fontSize: 22)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(movie.story, style: regularTextStyle),
                                        )
                                      ]),
                                      TableRow( children: [
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text('Character', style: TextStyle(fontSize: 22)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(movie.character, style: regularTextStyle),
                                        )
                                      ]),
                                      TableRow( children: [
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text('Screenplay', style: TextStyle(fontSize: 22)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(movie.screenplay, style: regularTextStyle),
                                        )
                                      ]),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
        ),
      )
    );
  }

}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.white,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}

String getFormattedDate(String date) {
  var inputFormat = DateFormat('MM/dd/yyyy');
  var inputDate = inputFormat.parse(date);
  var outputFormat = DateFormat('dd MMM yyyy');

  return outputFormat.format(inputDate).toString();
}