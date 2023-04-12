import 'package:flutter/material.dart';

class WeatherLocation {
  final String city;
  final String dateTime;
  final String temparature;
  final String weatherType;
  final String iconUrl;
  final String bgImg;
  final int wind;
  final int rain;
  final int humidity;

  WeatherLocation({
    required this.city,
    required this.dateTime,
    required this.temparature,
    required this.weatherType,
    required this.iconUrl,
    required this.bgImg,
    required this.wind,
    required this.rain,
    required this.humidity,
  });
}

final locationList = [
  WeatherLocation(
    city: 'Kolkata',
    dateTime: '07:50 PM — Monday, 9 Nov 2020',
    temparature: '24\u2103',
    weatherType: 'Night',
    iconUrl: 'assets/moon.svg',
    bgImg: 'assets/night.jpg',
    wind: 10,
    rain: 2,
    humidity: 10,
  ),
  WeatherLocation(
    city: 'London',
    dateTime: '02:20 PM — Monday, 9 Nov 2020',
    temparature: '15\u2103',
    weatherType: 'Cloudy',
    iconUrl: 'assets/cloudy.svg',
    bgImg: 'assets/cloudy.jpeg',
    wind: 8,
    rain: 7,
    humidity: 82,
  ),
  WeatherLocation(
    city: 'New York',
    dateTime: '09:20 AM — Monday, 9 Nov 2020',
    temparature: '17\u2103',
    weatherType: 'Sunny',
    iconUrl: 'assets/sun.svg',
    bgImg: 'assets/sunny.jpg',
    wind: 5,
    rain: 15,
    humidity: 61,
  ),
  WeatherLocation(
    city: 'Sydney',
    dateTime: '01:20 AM — Tuesday, 10 Nov 2020',
    temparature: '10\u2103',
    weatherType: 'Rainy',
    iconUrl: 'assets/rain.svg',
    bgImg: 'assets/sunny.jpg',
    wind: 20,
    rain: 70,
    humidity: 91,
  ),
];
