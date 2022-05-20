import 'package:flutter/material.dart';
import 'package:peliculas/widgets/card_swiper.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        elevation: 0,
        actions: [
          IconButton(onPressed:() {
            
          },
          icon: const Icon(Icons.search_outlined))
        ],

      ),
      body: Column(
        children: const [
          
          CardSwiper()

          // Listado horizontal de peliculas
        ],
      )
    );
  }
}