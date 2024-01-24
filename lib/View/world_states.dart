import 'package:covid19_tracker/Model/WorldStatesModel.dart';
import 'package:covid19_tracker/Services/states_%20services.dart';
import 'package:covid19_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices= StatesServices();
    return  Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height* .01,),
                 FutureBuilder(
                     future: statesServices.fetchWorldStateRecord(),
                     builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){
                       if(!snapshot.hasData){
                         return Expanded(
                           flex: 1,
                           child: SpinKitFadingCircle(
                                 size: 50,
                                 color: Colors.white,
                                 controller: _controller,
                               ),
                         );

                       }else{
                         return Column(
                           children: [
                             PieChart(
                               dataMap: {
                                 "Total": double.parse(snapshot.data!.cases.toString()),
                                 "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                 "Death": double.parse(snapshot.data!.deaths.toString()),
                               },
                               chartValuesOptions: const ChartValuesOptions(
                                 showChartValuesInPercentage: true
                               ),
                               chartRadius: MediaQuery.of(context).size.width/3.2,
                               legendOptions: const LegendOptions(
                                   legendPosition: LegendPosition.left
                               ),
                               animationDuration: const Duration(milliseconds: 1200),
                               chartType: ChartType.ring,
                               colorList: colorList,
                             ),
                             Padding(
                               padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.02),
                               child: Card(
                                 child: Column(
                                   children: [
                                     ReuseableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                                     ReuseableRow(title: 'Total Recovered', value: snapshot.data!.recovered.toString()),
                                     ReuseableRow(title: 'Total Death', value: snapshot.data!.deaths.toString()),
                                     ReuseableRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                                     ReuseableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                                     ReuseableRow(title: 'Today Death', value: snapshot.data!.todayDeaths.toString()),
                                     ReuseableRow(title: 'Active Cases', value: snapshot.data!.active.toString()),
                                     ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                     ReuseableRow(title: 'Affected Countries', value: snapshot.data!.affectedCountries.toString())
                                   ],
                                 ),
                               ),
                             ),
                             GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesListScreen()));
                              },
                               child: Container(
                                 height: 50,
                                 decoration: BoxDecoration(
                                     color: const Color(0xff1aa260),
                                     borderRadius: BorderRadius.circular(10)
                                 ),
                                 child: const Center(child: Text('Track Countries',style: TextStyle(fontWeight: FontWeight.bold),)),
                               ),
                             )
                           ],
                         );
                       }
                     }),
              ],
            ),
          )
      ),
    );
  }
}


class ReuseableRow extends StatelessWidget {
  String title , value;
   ReuseableRow({super.key, required this.title,required this.value });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
         // const SizedBox(height: 5,),
          const Divider()
        ],
      ),
    );
  }
}
