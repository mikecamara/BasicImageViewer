//  BasicImageViewer
//
//  Created by Admin on 11/9/17.
//  Copyright © 2017 mikecamara.github.io. All rights reserved.
//


import UIKit
import CoreLocation
import MapKit

final class BasicImageViewerViewController: UICollectionViewController, CLLocationManagerDelegate {
    
    
    
    // MARK: - Properties
    fileprivate let reuseIdentifier = "AppCell"
    
    var emptyString = ""
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    fileprivate var searches = [FlickrSearchResults]()
    
    //store clicked picture
    var selectedIndex = 0
    
    
    fileprivate let flickr = Flickr()
    
    var photoDetail:FlickrPhoto!
    
    fileprivate var longitudeUser:Double = 0
    fileprivate var latitudeUser:Double = 0
    
    fileprivate let itemsPerRow: CGFloat = 3
    fileprivate var selectedPhotos = [FlickrPhoto]()
    
    
    // Get user's location
    let locationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        latitudeUser  = location.coordinate.latitude
        longitudeUser = location.coordinate.longitude
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        // Load pictures according to user location
        
        flickr.searchFlickrForTerm(emptyString, lat: latitudeUser, lon: longitudeUser) {
            results, error in
            
            
            if let error = error {
                // Log any errors to the console.
                print("Error searching : \(error)")
                return
            }
            
            if let results = results {
                // The results get logged and added to the front of the searches array
                print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                
                DispatchQueue.main.async {
                    
                    self.searches.insert(results, at: 0)
                    
                    // Have new data and need to refresh the UI
                    self.collectionView?.reloadData()
                    
                }
            }
        }
    }
}






// MARK: - Private
private extension BasicImageViewerViewController {
    func photoForIndexPath(indexPath: IndexPath) -> FlickrPhoto {
        return searches[(indexPath as NSIndexPath).section].searchResults[(indexPath as IndexPath).row]
    }
}


// Add an extension to hold the text field delegate methods
extension BasicImageViewerViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Match the given search term asynchronously. When the search completes, the completion block will be called with a the result set of FlickrPhoto objects, and an error (if there was one).
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        flickr.searchFlickrForTerm(textField.text!, lat: latitudeUser, lon: longitudeUser) {
            results, error in
            
            activityIndicator.removeFromSuperview()
            
            if let error = error {
                // Log any errors to the console.
                print("Error searching : \(error)")
                return
            }
            
            if let results = results {
                // The results get logged and added to the front of the searches array
                print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                
                DispatchQueue.main.async {
                    self.searches.insert(results, at: 0)
                
                    // Have new data and need to refresh the UI
                    self.collectionView?.reloadData()
                }
            }
        }
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}



// MARK: - UICollectionViewDataSource
extension BasicImageViewerViewController {
    //1  the number of sections is the count of the searches array
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        
        return searches.count
        
    }
    
    // The number of items in a section is the count of the searchResults
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        
        
        
        return searches[section].searchResults.count
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        self.performSegue(withIdentifier: "showDetails", sender: self)
        
        
        
        photoDetail = photoForIndexPath(indexPath: indexPath)
        
        
    }
    
    
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
    }
    
    // This is a placeholder method just to return a blank cell – you’ll be populating it later.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // The cell coming back is now a FlickrPhotoCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! FlickrPhotoCell
        // Get the FlickrPhoto representing the photo to display
        let flickrPhoto = photoForIndexPath(indexPath: indexPath)
        
        cell.backgroundColor = UIColor.white
        // Populate the image view with the thumbnail
        cell.imageView.image = flickrPhoto.thumbnail
        
        
        return cell
    }
}



extension BasicImageViewerViewController : UICollectionViewDelegateFlowLayout {
    
    // Is responsible for telling the layout the size of a given cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Here, you work out the total amount of space taken up by padding
        let screenWidth = self.view.frame.width
        let cellWidth = (screenWidth/2.0)
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    
    // This method controls the spacing between each line in the layout.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    // This method controls the spacing between each line in the layout.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    
}




