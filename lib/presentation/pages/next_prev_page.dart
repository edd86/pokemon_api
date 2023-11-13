// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokemon_api/api/connection.dart';
import 'package:pokemon_api/models/pokemon.dart';
import 'package:pokemon_api/models/result.dart';
import 'package:pokemon_api/presentation/pages/home_page.dart';
import 'package:pokemon_api/presentation/pages/pokemon_page.dart';

class NextPrevPage extends StatefulWidget {
  String routeUrl;
  NextPrevPage(this.routeUrl, {super.key});

  @override
  State<NextPrevPage> createState() => _NextPrevPageState();
}

Result? result;
ApiConnection api = ApiConnection();
ScrollController scrollPages = ScrollController();
bool isFloatingVisible = true;

class _NextPrevPageState extends State<NextPrevPage> {
  @override
  void dispose() {
    scrollPages;
    super.dispose();
  }

  @override
  void initState() {
    /* getPokemons(); */
    getResults(widget.routeUrl);
    super.initState();

    scrollPages.addListener(() {
      if (scrollPages.position.userScrollDirection == ScrollDirection.reverse) {
        if (isFloatingVisible) {
          setState(() {
            isFloatingVisible = false;
          });
        }
      } else if (scrollPages.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!isFloatingVisible) {
          setState(() {
            isFloatingVisible = true;
          });
        }
      }
    });
  }

  void getResults(String route) async {
    result = await api.getElementsByRoute(route);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon API'),
      ),
      body: result == null
          ? const Text('Vacío')
          : ListView.builder(
              controller: scrollPages,
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
        animation: scrollPages,
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
                      setState(() {
                        getResults(result!.previous);
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  },
                ),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    if (result!.next.isNotEmpty) {
                      setState(() {
                        getResults(result!.next);
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
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
