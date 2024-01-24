import 'package:covid19_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  String image;
  String name;
  int totalcases, totaldeaths, todayCases ,todayDeaths, totalrecovered, todayRecovered,active,critical,population ;

  DetailScreen({super.key,
    required this.totalcases,
    required this.totaldeaths,
    required this.todayCases,
    required this.todayDeaths,
    required this.todayRecovered,
    required this.totalrecovered,
    required this.active,
    required this.critical,
    required this.population,
    required this. image,
    required this. name,

  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(widget.name!),
        centerTitle: true,
      ),
      body: Column(
       // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height* .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height* .06,),
                      ReuseableRow(title: 'Total Cases', value: widget.totalcases.toString()),
                      ReuseableRow(title: 'Total Recovered', value: widget.totalrecovered.toString()),
                      ReuseableRow(title: 'Total Deaths', value: widget.totaldeaths.toString()),
                      ReuseableRow(title: 'Today Cases', value: widget.todayCases.toString()),
                      ReuseableRow(title: 'Today Deaths', value: widget.todayDeaths.toString()),
                      ReuseableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                      ReuseableRow(title: 'Active', value: widget.active.toString()),
                      ReuseableRow(title: 'Critical', value: widget.critical.toString()),
                      ReuseableRow(title: 'Population', value: widget.population.toString())
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
