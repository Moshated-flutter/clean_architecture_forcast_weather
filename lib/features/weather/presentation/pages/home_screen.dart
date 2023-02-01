import 'dart:io';

import 'package:clean_architecture_forcast_weather/core/presentation/widgets/dot_loading.dart';
import 'package:clean_architecture_forcast_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../domain/entities/current_city_entity.dart';
import '../bloc/cw_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(LoadCwEvent('Sanandaj'));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final PageController _controller = PageController();
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state.cwStatus is CwLoading) {
                  return const Expanded(child: DotLoadingWidget());
                }
                if (state.cwStatus is CwComplited) {
                  final CwComplited cwComplited = state.cwStatus as CwComplited;
                  final CurrentCityEntity currentCityEntity =
                      cwComplited.currentCityEntity;

                  return Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        PageView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          allowImplicitScrolling: true,
                          controller: _controller,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: height * 0.05,
                                    ),
                                    child: Text(
                                      currentCityEntity.name.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.02),
                                    child: Text(
                                      currentCityEntity
                                          .weather![0].description!,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.02),
                                    child: Image.network(
                                      'http://openweathermap.org/img/wn/${currentCityEntity.weather![0].icon!}@2x.png',
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.03),
                                    child: Text(
                                      '${currentCityEntity.main!.temp!.round()}\u00b0',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * .02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //max temp
                                      Column(
                                        children: [
                                          const Text(
                                            'max',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${currentCityEntity.main!.tempMax!.round()}\u00b0',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      //divider
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 1,
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      //min temp
                                      Column(
                                        children: [
                                          const Text(
                                            'min',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${currentCityEntity.main!.tempMin!.round()}\u00b0',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              );
                            }
                            if (index == 1) {
                              return Container(
                                color: Colors.amber,
                                height: 40,
                                width: 40,
                              );
                            }
                            return Text('data');
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count: 2,
                            effect: ExpandingDotsEffect(
                              dotColor: Colors.white,
                              dotHeight: 10,
                              dotWidth: 10,
                              spacing: 5,
                            ),
                            onDotClicked: (index) => _controller.animateToPage(
                              index,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (state.cwStatus is CwError) {
                  const Center(
                    child: Text('error'),
                  );
                }
                return const Center(
                  child: Text(
                    'nothing',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
