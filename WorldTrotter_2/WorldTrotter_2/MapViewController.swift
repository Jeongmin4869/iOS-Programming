//import Foundation

import UIKit
import MapKit

class MapViewController: UIViewController{
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        //print("MapViewController loaded its view")
        
        view = MKMapView()
        
        //UISegmentedControl생성.
        let segmentedControl = UISegmentedControl(items: ["Standard","Hybird","Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false // true인 경우 오토레이아웃을 하려고 한다. 이 경우 코딩으로 제약조건을 할 때 충돌하는 문제가 발생
        view.addSubview(segmentedControl)
        
        //제약조건
        //let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.topAnchor)
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        
        //let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        //let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        
        //제약조건 활성화
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        //명시적 제약조건
        //let aspectConstraint = NSLayoutConstraint(item: segmentedControl, attribute: .width, relatedBy: .equal, toItem: segmentedControl, attribute: .height, multiplier: 1.5, constant: 0.0)
        //aspectConstraint.isActive = true
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false;
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        view.addSubview(segmentedControl)
    }
    
    @objc func mapTypeChanged(segControl: UISegmentedControl){
        let mapView = view as! MKMapView
        
        switch segControl.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
}

