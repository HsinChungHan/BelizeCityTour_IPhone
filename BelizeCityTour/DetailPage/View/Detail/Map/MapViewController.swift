//
//  MapViewController.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/3.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    let locationManager = CLLocationManager()
    var currentPlaceMark: CLPlacemark?
    var place: Place? {
        didSet{
            guard let place = place else {return}
            showPlaceAnnotaion(place: place)
        }
    }
    
    lazy var dismissButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        btn.setImage(UIImage(named: IconsConstant.back.rawValue)?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.tintColor = UIColor.black
        return btn
    }()
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
    
    lazy var userLocationButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(showUserLocation), for: .touchUpInside)
        btn.setImage(UIImage(named: "Guides")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    @objc func showUserLocation(){
        let userLocation = mapView.userLocation
        let visibleRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1500, longitudinalMeters: 1500)
        self.mapView.setRegion(self.mapView.regionThatFits(visibleRegion), animated: true)
        
    }
    
    
    lazy var mapView: MKMapView = {
        var mapView = MKMapView()
        mapView.delegate = self
        if #available(iOS 9.0, *){
            mapView.showsCompass = true
            mapView.showsScale = true
            mapView.showsTraffic = true
        }
        mapView.isScrollEnabled = true
        mapView.isZoomEnabled = true
        mapView.isRotateEnabled = true
        mapView.showsUserLocation = true
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundRiceColor
        setupMapView()
        authorizedUserLocation(locationManager: locationManager)
        setupDismissButton()
        setupUserLocationButton()
    }
}

extension MapViewController{
    fileprivate func setupDismissButton(){
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 60, height: 60)
    }
    
    fileprivate func setupMapView(){
        view.addSubview(mapView)
        mapView.fullAnchor(superView: view)
    }
    
    fileprivate func setupUserLocationButton(){
        view.addSubview(userLocationButton)
        userLocationButton.anchor(top: view.topAnchor, bottom: nil, left: nil, right: view.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 10, width: 50, height: 50)
    }
    
    
    fileprivate func authorizedUserLocation(locationManager: CLLocationManager){
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.authorizedWhenInUse{
            mapView.showsUserLocation = true
        }
    }
    
    //只要access此function便可以在mapView上出現一個annotation view
    fileprivate func showPlaceAnnotaion(place: Place){
        convertAddress(place: place) { [weak self](placemark) in
            self?.currentPlaceMark = placemark
            guard let placemark = placemark else {return}
            guard let annotation = self?.addAnnotation(place: place, placemark: placemark) else {return}
            self?.showAnnotation(mapView: (self?.mapView)!, annotations: [annotation], selectedAnnotation: annotation)
        }
    }
    
    fileprivate func convertAddress(place: Place, completionHandler: @escaping (_ placemarK: CLPlacemark?) -> ()){
        var placemark: CLPlacemark?
        let geoCoder = CLGeocoder()
        //要改寫成直接用座標去抓，因為貝里斯無法用地址轉座標
        let latitude: CLLocationDegrees = CLLocationDegrees(place.coordinate.latitude)
        let longtitude: CLLocationDegrees = CLLocationDegrees(place.coordinate.longitude)
        let location = CLLocation(latitude: latitude, longitude: longtitude)
        geoCoder.reverseGeocodeLocation(location, preferredLocale: nil) { (placemarks, error) in
            if let error = error{
                print(error)
            }
            if let placemarks = placemarks{
                placemark = placemarks[0]
            }
            completionHandler(placemark)
        }
        
        
        
        //        geoCoder.geocodeAddressString(place.address) { (placemarks, error) in
        //            if let error = error{
        //                print(error)
        //            }
        //            if let placemarks = placemarks{
        //                placemark = placemarks[0]
        //            }
        //            completionHandler(placemark)
        //        }
    }
    
    fileprivate func addAnnotation(place: Place, placemark: CLPlacemark) -> MKPointAnnotation?{
        let annotation = MKPointAnnotation()
        annotation.title = place.englishName
        annotation.subtitle = place.type
        if let location = placemark.location{
            annotation.coordinate = location.coordinate
            return annotation
        }
        return nil
    }
    
    fileprivate func showAnnotation(mapView: MKMapView, annotations: [MKPointAnnotation], selectedAnnotation: MKAnnotation){
        //        let userLocation = mapView.userLocation
        //        let visibleRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 10, longitudinalMeters: 10)
        //        self.mapView.setRegion(self.mapView.regionThatFits(visibleRegion), animated: true)
        
        
        //        let visibleRegion = MKCoordinateRegion(center: selectedAnnotation.coordinate, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
        //        mapView.setRegion(visibleRegion, animated: true)
        mapView.showAnnotations(annotations, animated: true)
        //        mapView.selectAnnotation(selectedAnnotation, animated: true)
    }
    
    public func setupValues(place: Place){
        self.place = place
    }
}


extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinId = "PinID"
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        var annotationView: MKAnnotationView?
        //use system difault callOut
        
        if #available(iOS 11.0, *){
            //ios高於11的版本，可以使用markAnnotationView
            annotationView = markAnnotationViewOverIOS11(pinId: pinId, annotation: annotation)
        }else{
            //ios低於11的版本，可以使用pinAnnotationView
            annotationView = pinAnnotationViewDownBelowIOS11(pinId: pinId, annotation: annotation)
        }
        
        guard let place = place else {return annotationView}
        
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        leftIconView.image = UIImage(named: place.imgs[0])
        leftIconView.contentMode = .scaleAspectFit
        annotationView?.leftCalloutAccessoryView = leftIconView
        return annotationView
        
    }
    
    fileprivate func markAnnotationViewOverIOS11(pinId: String, annotation: MKAnnotation) -> MKAnnotationView?{
        var markerAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: pinId) as? MKMarkerAnnotationView
        
        if markerAnnotationView == nil{
            markerAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: pinId)
            markerAnnotationView?.canShowCallout = true
        }
        
        //因為目前的api中，想要在地圖出現title，必須使用MKMarkerAnnotationView
        //客製化的annotation好像無法出現
        //而且目前的api沒有讓glyphImage消失的方法，如果不給圖片，他會有一個difault的icon，所以這邊採用暫時給一個icon，但把它顏色調為clear的方法(用withRenderingMode也無法)
        markerAnnotationView?.glyphText = "🏛"
        markerAnnotationView?.markerTintColor = .orange
        //        markerAnnotationView?.glyphImage = UIImage(named: "mapPin")
        markerAnnotationView?.glyphTintColor = UIColor.red
        //        markerAnnotationView?.image = UIImage(named: "mapPin")
        
        return markerAnnotationView
    }
    
    fileprivate func pinAnnotationViewDownBelowIOS11(pinId: String, annotation: MKAnnotation) -> MKAnnotationView?{
        var pinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: pinId) as? MKPinAnnotationView
        if pinAnnotationView == nil{
            pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinId)
            pinAnnotationView?.canShowCallout = true
            pinAnnotationView?.pinTintColor = .orange
            pinAnnotationView?.accessibilityLabel = "hello"
        }
        return pinAnnotationView
    }
}
