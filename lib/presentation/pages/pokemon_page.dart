// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pokemon_api/models/pokemon.dart';

class PokemonPage extends StatelessWidget {
  Pokemon pokemon;
  PokemonPage(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              pokemon.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                pokemon.sprites.frontDefault,
                height: MediaQuery.of(context).size.height * .40,
                width: MediaQuery.of(context).size.width * .50,
                fit: BoxFit.fill,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300]),
                child: Column(
                  children: [
                    const Text("Altura: "),
                    Text(
                      pokemon.height.toString(),
                    ),
                    const Divider(),
                    const Text("Peso: "),
                    Text(
                      pokemon.weight.toString(),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
