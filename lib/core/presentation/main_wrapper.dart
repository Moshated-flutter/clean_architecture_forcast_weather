import 'package:clean_architecture_forcast_weather/core/presentation/app_background.dart';
import 'package:clean_architecture_forcast_weather/core/presentation/widgets/bottom_nav.dart';
import 'package:clean_architecture_forcast_weather/features/bookmark/presentation/pages/bookmark_screen.dart';
import 'package:clean_architecture_forcast_weather/features/weather/domain/entities/current_city_entity.dart';
import 'package:clean_architecture_forcast_weather/features/weather/presentation/pages/home_screen.dart';

import '../../features/weather/presentation/bloc/cw_status.dart';
import '../../features/weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/weather/data/datasources/remote/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});
  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    List<Widget> pageViewWidget = [
      HomeScreen(),
      BookmarkScreen(),
    ];

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNav(Controller: pageController),
      body: Container(
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AppBackground.getBackGroundImage(),
          fit: BoxFit.cover,
        )),
        child: PageView(
          controller: pageController,
          children: pageViewWidget,
        ),
      ),
    );
  }
}

// class MainWrapper extends StatefulWidget {
//   @override
//   State<MainWrapper> createState() => _MainWrapperState();
// }

// class _MainWrapperState extends State<MainWrapper> {
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<WeatherBloc>(context).add(LoadCwEvent("Tehran"));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: BlocBuilder<WeatherBloc, WeatherState>(
//         builder: (context, state) {
//           if (state.cwStatus is CwLoading) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (state.cwStatus is CwComplited) {
//             final CwComplited cwComplited = state.cwStatus as CwComplited;
//             final CurrentCityEntity currentCityEntity =
//                 cwComplited.currentCityEntity;
//             print(currentCityEntity.name);
//             return Center(
//               child: Text(currentCityEntity.name.toString()),
//             );
//           }
//           if (state.cwStatus is CwError) {
//             Center(
//               child: Text('error'),
//             );
//           }
//           return Center(
//             child: Text('nothing'),
//           );
//         },
//       ),
//     );
//   }
// }
