# BasicImageViewer

A basic image viewer app that allows the user to find and view images from Flickr.

## App Requirements

* On launch, users should be taken to a home screen that automatically displays geographically- relevant results based on their current location (initial launch experience).
* Users should then be able to supply a search term to search all of Flickr (regardless of location) to receive results related to that search term.
* Users should be able to see a list of available tags for the current set of results and filter the results by tag.
* The app needs to asynchronously present the results as thumbnails on a grid.
* The user should be able to tap on a thumbnail to view the image in its entirety, with metadata
displayed on-screen (e.g., image name, size, resolution, date, etc.).

### Additional Requirements

* You have complete control over UX and UI. It is strongly recommended that your app conforms closely to the iOS Human Interface Guidelines, and is optimised for performance.
* The app should be a native app constructed in Xcode, leveraging what’s available in the iOS SDK. Creation of a web wrapper and executing on the aforementioned requirements in a web page is not permitted.
* Please ensure that the app is compatible with all sizes of iPhone and iPad, and both portrait and landscape orientations. It is acceptable for the app to only support iOS 10.
* Please use the Flickr API (https://www.flickr.com/services/api/) and make direct requests to the API.
* Usage of other third-party APIs/libraries/frameworks is not permitted.

```
Give examples
```

### App Requirements Comments

* On launch, users should be taken to a home screen that automatically displays geographically- relevant results based on their current location (initial launch experience).
```

// Get user's location
let locationManager = CLLocationManager()

func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
let location = locations[0]

latitudeUser  = location.coordinate.latitude
longitudeUser = location.coordinate.longitude

}

locationManager.delegate = self
locationManager.desiredAccuracy = kCLLocationAccuracyBest
locationManager.requestWhenInUseAuthorization()
locationManager.startUpdatingLocation()

```


* Users should then be able to supply a search term to search all of Flickr (regardless of location) to receive results related to that search term.
* Users should be able to see a list of available tags for the current set of results and filter the results by tag.
* The app needs to asynchronously present the results as thumbnails on a grid.
* The user should be able to tap on a thumbnail to view the image in its entirety, with metadata
displayed on-screen (e.g., image name, size, resolution, date, etc.).


A step by step series of examples that tell you have to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc
