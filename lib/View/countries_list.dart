import 'package:covid19_tracker/Services/states_%20services.dart';
import 'package:covid19_tracker/View/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  @override
  Widget build(BuildContext context) {

    TextEditingController searchController = TextEditingController();
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar:  AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10,top: 8,left: 10),
              child: TextFormField(
                // onChanged: (value){
                //   setState(() {
                //
                // });},
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search With Country Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  )
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: statesServices.countriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

                    if(!snapshot.hasData){
                      return ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(height: 10,width: 89, color: Colors.white,),
                                      subtitle: Container(height: 10,width: 89, color: Colors.white,),
                                      leading: Container(height: 50,width: 50, color: Colors.white,),
                                      ),

                                  ],
                                )
                            );
                          });
                    }else{
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                          String name = snapshot.data![index]['country'];

                          if(searchController.text.isEmpty){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(

                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalcases: snapshot.data![index]['cases'],
                                      totaldeaths: snapshot.data![index]['deaths'],
                                      todayCases: snapshot.data![index]['todayCases'],
                                      todayDeaths: snapshot.data![index]['todayDeaths'],
                                      totalrecovered: snapshot.data![index]['recovered'],
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]['critical'],
                                      population: snapshot.data![index]['population'],
                                    )));
                                  },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Column(
                              children: [
                               InkWell(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(

                                     image: snapshot.data![index]['countryInfo']['flag'],
                                     name: snapshot.data![index]['country'],
                                     totalcases: snapshot.data![index]['cases'],
                                     totaldeaths: snapshot.data![index]['deaths'],
                                     todayCases: snapshot.data![index]['todayCases'],
                                     todayDeaths: snapshot.data![index]['todayDeaths'],
                                     totalrecovered: snapshot.data![index]['recovered'],
                                     todayRecovered: snapshot.data![index]['todayRecovered'],
                                     active: snapshot.data![index]['active'],
                                     critical: snapshot.data![index]['critical'],
                                     population: snapshot.data![index]['population'],
                                   )));
                                 },
                                 child: ListTile(
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                      ),
                                    ),
                               ),
                              ],
                            );
                          }else{
                            return Container();
                          }
                          }
                      );
                    }
                  },
                )
            )
          ],
        )
      ),
    );
  }
}
