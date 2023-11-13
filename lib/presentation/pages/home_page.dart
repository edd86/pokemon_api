import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokemon_api/api/connection.dart';
import 'package:pokemon_api/models/pokemon.dart';
import 'package:pokemon_api/models/result.dart';
import 'package:pokemon_api/presentation/pages/next_prev_page.dart';
import 'package:pokemon_api/presentation/pages/pokemon_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

//Pokemon? pokemon;
Result? result;
ApiConnection api = ApiConnection();
ScrollController scroll = ScrollController();
bool isFloatingVisible = true;
//final TextEditingController _tfPokemonNameController = TextEditingController();

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    scroll;
    super.dispose();
  }

  @override
  void initState() {
    /* getPokemons(); */
    getResults();
    super.initState();

    scroll.addListener(() {
      if (scroll.position.userScrollDirection == ScrollDirection.reverse) {
        if (isFloatingVisible) {
          setState(() {
            isFloatingVisible = false;
          });
        }
      } else if (scroll.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!isFloatingVisible) {
          setState(() {
            isFloatingVisible = true;
          });
        }
      }
    });
  }

  void getResults() async {
    result = await api.getElements();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon API'),
      ),
      body: result == null
          ? const Center(child: Text('Vacío'))
          : ListView.builder(
              controller: scroll,
              itemCount: result!.results.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: const Icon(Icons.arrow_circle_right_outlined),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FutureBuilder(
                        future: api.getPokemon(result!.results[index].name),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            Pokemon pokemon = snapshot.data!;
                            return Image.network(pokemon.sprites.frontDefault);
                          }
                        },
                      ),
                      Text(
                        result!.results[index].name,
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    //Obtenemos un pokémon
                    Pokemon pokemon =
                        await api.getPokemon(result!.results[index].name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonPage(pokemon),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedBuilder(
        animation: scroll,
        builder: (context, child) {
          return Visibility(
            visible: isFloatingVisible,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  child: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    if (result!.previous.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NextPrevPage(result!.previous),
                        ),
                      );
                    }
                  },
                ),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    if (result!.next.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NextPrevPage(result!.next),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
