//
//  MapViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController {
     
    private let mapView = MKMapView()
    private let restaurants = RestaurantList.restaurantArray
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMapView()
        filterAnnotation(categorys: nil)
    }
     
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "지도"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "메뉴",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
         
        view.addSubview(mapView)
         
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
         
        let seoulStationCoordinate = CLLocationCoordinate2D(latitude: 37.5547, longitude: 126.9706)
        let region = MKCoordinateRegion(
            center: seoulStationCoordinate,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
        mapView.setRegion(region, animated: true)
    }
    
    private func addStationAnnotation(restaurants: [Restaurant]?) {
        mapView.removeAnnotations(mapView.annotations)
        if let lists = restaurants {
            for restaurant in lists {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
                annotation.title = restaurant.name
                annotation.subtitle = restaurant.address
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    func filterAnnotation(categorys: [String]?) {
        guard let categorys else {
            self.addStationAnnotation(restaurants: restaurants)
            return
        }
        for category in categorys {
            let filterRestaurants = self.restaurants.filter { $0.category == category }
            self.addStationAnnotation(restaurants: filterRestaurants)
        }
    }
     
    @objc private func rightBarButtonTapped() {
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let alert1Action = UIAlertAction(title: "한식", style: .default) { _ in
            self.filterAnnotation(categorys: ["한식"])
        }
        
        let alert2Action = UIAlertAction(title: "양식, 경양식", style: .default) { _ in
            self.filterAnnotation(categorys: ["양식", "경양식"])
        }
        
        let alert3Action = UIAlertAction(title: "일식", style: .default) { _ in
            self.filterAnnotation(categorys: ["일식"])
        }
        
        let alert4Action = UIAlertAction(title: "중식", style: .default) { _ in
            self.filterAnnotation(categorys: ["중식"])
        }
        
        let alert5Action = UIAlertAction(title: "분식", style: .default) { _ in
            self.filterAnnotation(categorys: ["분식"])
        }
        
        let alert6Action = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.filterAnnotation(categorys: nil)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소가 선택되었습니다.")
        }
        
        alertController.addAction(alert1Action)
        alertController.addAction(alert2Action)
        alertController.addAction(alert3Action)
        alertController.addAction(alert4Action)
        alertController.addAction(alert5Action)
        alertController.addAction(alert6Action)
        alertController.addAction(cancelAction)
         
        present(alertController, animated: true, completion: nil)
    }
}
 
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        print("어노테이션이 선택되었습니다.")
        print("제목: \(String(describing: annotation.title ?? "제목 없음"))")
        print("부제목: \(String(describing: annotation.subtitle ?? "부제목 없음"))")
        print("좌표: \(annotation.coordinate.latitude), \(annotation.coordinate.longitude)")
        
        // 선택된 어노테이션으로 지도 중심 이동
        let region = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("어노테이션 선택이 해제되었습니다.")
    }
}
