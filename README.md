# NASApp
Twelfth iOS Techdegree project - An iOS app that uses NASA API to let you do cool stuff


## Snapshots

<img width="180" alt="daily" src="https://cloud.githubusercontent.com/assets/11211914/24452241/910b5624-1482-11e7-9894-3801435af925.gif"> <img width="180" alt="collision" src="https://cloud.githubusercontent.com/assets/11211914/24452242/91138678-1482-11e7-8f4f-b7aaf3409635.gif"> <img width="180" alt="earth" src="https://cloud.githubusercontent.com/assets/11211914/24452243/9113c3f4-1482-11e7-8746-7d4b525d66b4.gif"> <img width="180" alt="mars" src="https://cloud.githubusercontent.com/assets/11211914/24452244/9115b8a8-1482-11e7-9990-ae6ad6d4b7cc.gif">

## Explanation
The NASApp is a Swift app builded during the Techdegree at <a href="https://teamtreehouse.com">Treehouse</a>

The goal was to develop an app based on the <a href="https://api.nasa.gov">NASA API</a>.
Along side the NASA API, the following technologies have been used in the app:

- <a href="https://github.com/Alamofire/Alamofire">Alamofire</a>
- <a href="https://github.com/SwiftyJSON/SwiftyJSON">SwiftyJSON</a>
- <a href="https://github.com/Alamofire/AlamofireImage">AlamofireImage</a>
- iOS MApKit
- iOS CoreLocation


## Features

This is a list of the features:

1- It is possible to see the "Astronomy Picture of the Day".

2- It is possible to see a list of the "near earth asteroids" for the next 7 days.

3- It is possible to see satellite images for a specifc location and for current location, using MapKit.

4- It is possible to see Mars' images from the rovers.

5- App is based on a Master-Detail style TableView.

6- AlamofireImage's cache is used to cache images.

7- The code is pretty commented

## How To Use

Download the repo, open the terminal and navigate through the root folder.

Execute `Carthage Update`, than in Xcode play the app in the simulator.

Make sure that the geolocation is active in the simulator.


-----

Anyone is free to download and use this app for their projects.
It is strictly forbidden to use this base to create something for marketing purposes.
In addition anyone who decides to download this app is invited to create a new branch and share their code.

For any questions or problems, please contact me.
If you find bugs or problems, please report them.

## Techdegree's Instruction Project

>Your mission, should you choose to accept it, is to build an iOS app in Swift using the the NASA API. You need to implement two required features, and an optional one. We expect you to use different skills in different ways and encourage you to go above and beyond the requirements stated in terms of usage of APIs and iOS capabilities. This is the opportunity to make a really nice portfolio piece, and we hope you make it your own! While mockups are provided, they represent just one of the many possible ways the finished app could look. We hope you will get creative and base your layouts and design on the particular functionalities of your app.

>Rover Postcard Maker: Access the Mars Rover Imagery API and display a selected, filtered, or randomized image from the Mars Rover.

>Eye-In-the-Sky: Build a tool to access the Earth Imagery API and display a photo of a user specified area.

>Optional Custom Feature: Create your own app feature using the NASA API! Get creative and showcase everything that you are able to do!
