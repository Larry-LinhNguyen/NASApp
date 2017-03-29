//
//  EarthSearcherTableViewController.swift
//  NASApp
//
//  Created by Andrea Miotto on 27/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit
import MapKit

class EarthSearcherTableViewController: UITableViewController {
    
    //----------------------
    // MARK: - Variables
    //----------------------
    
    var searchController: UISearchController!
    let locationManager = LocationManager()
    var locations: [MKMapItem] = []
    var earthLocationData: EarthLocationData?
    
    //----------------------
    // MARK: - Outlets
    //----------------------
    
    @IBOutlet weak var mapView: MKMapView!
    
    //----------------------
    // MARK: - View Functions
    //----------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "CurrentLocation"), style: .plain, target: self, action: #selector(zoomToCurrentLocation))
        
        //Configure the search controller
        configureSearchController()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //----------------------
    // MARK: - Methods
    //----------------------
    
    
    func configureSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Search or Enter Address"
        searchController.searchBar.showsCancelButton = true
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        tableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
        
    }
    
    //----------------------
    // MARK: - Helpers
    //----------------------
    
    /**This func will display an Alert */
    func displayAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showDataUnaviableAlert() {
        displayAlert(title: "Fetching Data", message: "We are moving the satellites for you, retry in a moment!")
    }

    //----------------------
    // MARK: - Table view data source
    //----------------------

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let location = locations[indexPath.row].placemark
        cell.textLabel?.text = location.name
        cell.detailTextLabel?.text = locationManager.parseAddress(location: location)
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchController.searchBar.endEditing(true)
        
        let selectedLocation = locations[indexPath.row].placemark
        locationManager.dropPinZoomIn(placemark: selectedLocation, mapView: self.mapView)
        print(selectedLocation.coordinate)
        print(selectedLocation.name!)
        
    }

}

//----------------------
// MARK: - Extension UISearchResultsUpdating
//----------------------

extension EarthSearcherTableViewController : UISearchResultsUpdating {

    public func updateSearchResults(for searchController: UISearchController) {
        //Code
        guard let text = searchController.searchBar.text else { return }
        
        self.getLocations(forSearchString: text)
    }
    
    fileprivate func getLocations(forSearchString searchString: String) {
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchString
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard let response = response else { return }
            self.locations = response.mapItems
            self.tableView.reloadData()
        }
    }
    
    @objc func zoomToCurrentLocation() {
        
        
        //Clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapView.userLocation.coordinate
        mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegionMake(mapView.userLocation.coordinate, span)
        mapView.setRegion(region, animated: true)
        
        let location = CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)
        mapView.add(MKCircle(center: location.coordinate, radius: 50))
        
       
    }

}

//----------------------
// MARK: - Extension MKMapViewDelegate
//----------------------


extension EarthSearcherTableViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.lineWidth = 2.0
            circleRenderer.strokeColor = .purple
            circleRenderer.fillColor = UIColor.purple.withAlphaComponent(0.4)
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
}

//----------------------
// MARK: - Extension UISearchBarDelegate
//----------------------

extension EarthSearcherTableViewController: UISearchBarDelegate {}






