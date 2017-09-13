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


## App Requirements Commented

* On launch, users should be taken to a home screen that automatically displays geographically- relevant results based on their current location (initial launch experience).

```
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
```
if let results = results {
// The results get logged and added to the front of the searches array
print("Found \(results.searchResults.count) matching \(results.searchTerm)")
self.searches.insert(results, at: 0)

// Have new data and need to refresh the UI
self.collectionView?.reloadData()
}

```
* Users should be able to see a list of available tags for the current set of results and filter the results by tag.

```
I am currently working on this requiremnt, but I am having issues with getting Flickr Tags.
```
* The app needs to asynchronously present the results as thumbnails on a grid.

```
DispatchQueue.main.async {

self.searches.insert(results, at: 0)

// Have new data and need to refresh the UI
self.collectionView?.reloadData()

}

```
* The user should be able to tap on a thumbnail to view the image in its entirety, with metadata
displayed on-screen (e.g., image name, size, resolution, date, etc.).

```

// At the moment I am only getting the Photo and Title from Flickr

// MARK - Segue
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
if segue.identifier == "showDetails" {

if let indexPaths = collectionView?.indexPathsForSelectedItems {
let destinationViewController = segue.destination as! PhotoViewController


let flickrPhoto = photoForIndexPath(indexPath: indexPaths[0])

destinationViewController.img = flickrPhoto.thumbnail!

print(flickrPhoto.title)

destinationViewController.txt = flickrPhoto.title

}
}
```

## Screenshots

### Running on device
![img_2623](https://user-images.githubusercontent.com/8085864/30360473-2986cb60-9884-11e7-8ad0-265aebf0c077.jpg)

### Requesting user's permission
![img_2629](https://user-images.githubusercontent.com/8085864/30360748-bca0984e-9885-11e7-9f80-6952d4bbb640.jpg)

### Initial launch experience, search based on user's location
![img_2628](https://user-images.githubusercontent.com/8085864/30360745-b905b610-9885-11e7-8852-bc8329534306.jpg)

### Search for term "puppy"
![img_2624](https://user-images.githubusercontent.com/8085864/30360475-2be40ee0-9884-11e7-944a-e2a81bb304f7.jpg)

### Photo detail view
![img_2625](https://user-images.githubusercontent.com/8085864/30360479-2eaca72c-9884-11e7-887c-a8e63301fa9b.jpg)

### Landscape view
![img_2627](https://user-images.githubusercontent.com/8085864/30360752-bf4336ce-9885-11e7-90c5-4fd58f9fa4a4.jpg)


## Deployment

iOS deployment target 10.3 - iPhone/iPad

## Built With

* Swift


## Versioning

Version 1.0 on 12/September/2017. 


## Acknowledgments

* @BPJohnson823 - Author of Flickr helper classes

