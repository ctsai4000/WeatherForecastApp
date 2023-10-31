# WeatherForecastApp
    This repository conatins the source code for a Weather Forecast App developed by using SwiftUI and Swift. The app fetched weather data from a REST API and presents it in an interactive and visually appealing user interface. 
    The app is built up in MVVM architecture. 

## Project Description
    This app can show current weather and 5-day forcast for the current location or searching location. By using CoreLocation to access users' location, it displays the weather condition, and provided the pull-to-refresh feature for the list. 

## Project structure
    The project contains: Model, View, ViewModel, Enum, Error, Utilities, Service(api & CoreLocation). 

## Unit Tests
    In this MVVM architeture app, ViewModel contains all the key funtions. Those functions are tested by the unit tests. And both success and failure cases are covered. 

# Installation
    Compatible with iPhone with minimum iOS version 16.0

# Acknowledgements
    The weather data is provided by tomorrow.io (https://www.tomorrow.io)
    The weather condition icon is provided by AMCharts (https://www.amcharts.com/free-animated-svg-weather-icons/)

# UI Design
    In order to keep the UI as simple as possible, both realtime weather condition and forecast weather information are displayed in the one page. The design took Apple Weather App as a reference, which showing realtime weather condition at the top and forecast weather information at the bottom. By using only three colors to make the UI look simple and readable. 
    Also the searching feature is implemented in the same view, which let users don't need to switch between views to review all the weather information. 

# Challenge encountered
## api calls limitation
    The api has strict limitation for free account, which is a challenge for developing. Developer needs over hundreds times to test the app and make sure the data is well-parsed, the seaching feature works fine, and all the weather information are displayed correctly. Hence, I use mock JSON data, which is one of the way to do the test. In this way, we can test the app by using local data. Also, to avoid too many api calls, I use a search submit button to submit the query, not onChange() function to trigger the api calls thousand times. 

# Screenshots