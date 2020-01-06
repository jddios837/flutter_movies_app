import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_app/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;  

  CardSwiper({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.only(top: 10.0),
        // width: double.infinity,
        // height: 300.0,
        child: Swiper(
            itemBuilder: (BuildContext context,int index){
              return ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  placeholder: AssetImage('assets/images/loading.gif'),
                ),
                // child: Image.network("http://via.placeholder.com/350x150",fit: BoxFit.cover),
              );
            },
            itemCount: 3,
            itemWidth: _screenSize.width * 0.7,
            itemHeight: _screenSize.height * 0.5,
            layout: SwiperLayout.STACK,
            // pagination: new SwiperPagination(),
            // control: new SwiperControl(),
          ),
    );
  } 
}