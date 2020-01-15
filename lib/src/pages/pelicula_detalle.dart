import 'package:flutter/material.dart';
import 'package:movies_app/src/models/actores_model.dart';
import 'package:movies_app/src/models/pelicula_model.dart';
import 'package:movies_app/src/providers/peliculas_providers.dart';

class PeliculaDetalle extends StatelessWidget {
  // final Pelicula pelicula;

  // PeliculaDetalle(this.pelicula);


  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo(context, pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _crearCasting(pelicula)
              ]
            ),
          )
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      pinned: true,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/images/loading.gif'),
          fadeInDuration: Duration(milliseconds: 250),
          fit: BoxFit.cover,
        ),
      ),
    );
  }


  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    print(pelicula.uniqueId);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(children: <Widget>[
        Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage(pelicula.getPosterImg()),
                  height: 150.0,
                ),
            ),
        ),
        SizedBox(width: 20.0,),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(pelicula.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis),
              Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis),
              Row(
                children: <Widget>[
                  Icon( Icons.star_border ),
                  Text(pelicula.voteAverage.toString())
                ],
              )
            ],
          ),
        )
      ],),
    );
  }

  Widget _description(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(actores[i]),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
              image: NetworkImage(actor.getFoto()),
              placeholder: AssetImage('assets/images/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            )
        ],
      ),
    );
  }

}