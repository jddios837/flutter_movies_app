import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/peliculas_providers.dart';
import 'package:movies_app/src/search/search_delegate.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_app/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: DataSearch(),
                // query: 'Hola'
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      ),
      // body: SafeArea(
      //   child: Text('Hola Mundo'),
      // ),
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return CardSwiper(peliculas: snapshot.data); 
        } else {
          return Container(
            height: 400.0,
            child: Center(child: CircularProgressIndicator())
          );
        }
      },
    );

    // peliculasProvider.getEnCines();

    // return CardSwiper(peliculas: [1,2,3,4,5],); 
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead,)
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){ 
                return MovieHorinzantal(
                    peliculas: snapshot.data,
                    siguientePagina: peliculasProvider.getPopulares,
                  ); 
              } else {
                return Container(
                  height: 160.0,
                  child: Center(child: CircularProgressIndicator())
                );
              }
            },
          ),
        ],
      ),
    );
  }
}