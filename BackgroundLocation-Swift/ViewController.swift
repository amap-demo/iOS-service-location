//
//  ViewController.swift
//  BackgroundLocation-swift
//
//  Created by hanxiaoming on 16/12/6.
//  Copyright © 2016年 AutoNavi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AMapLocationManagerDelegate {
    
    var locationManager: AMapLocationManager!
    var locateCount: Int = 0
    var locationgInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "后台定位"
        
        locationManager = AMapLocationManager()
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.locatingWithReGeocode = true
        
        configSubview()
        configToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setToolbarHidden(false, animated: false);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Init
    
    func configSubview() {
        locationgInfoLabel = UILabel(frame: CGRect(x: 40, y: 40, width: self.view.bounds.width - 80, height: self.view.bounds.height - 150))
        locationgInfoLabel.backgroundColor = UIColor.clear
        locationgInfoLabel.textColor = UIColor.black
        locationgInfoLabel.font = UIFont.systemFont(ofSize: 14)
        locationgInfoLabel.adjustsFontSizeToFitWidth = true
        locationgInfoLabel.textAlignment = .left
        locationgInfoLabel.numberOfLines = 0
        
        self.view.addSubview(locationgInfoLabel)
        
    }
    
    func configToolBar() {
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let segmentControl = UISegmentedControl(items: ["开始后台定位",
                                                        "停止后台定位"])
        segmentControl.addTarget(self, action:#selector(self.locateAction(sender:)), for: UIControlEvents.valueChanged)
        let segmentItem = UIBarButtonItem(customView: segmentControl)
        self.toolbarItems = [flexibleItem, segmentItem, flexibleItem]
        
        segmentControl.selectedSegmentIndex = 0
    }
    
    //MARK: - Helpers
    
    func locateAction(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            // stop locating
            locationManager.stopUpdatingLocation()
            self.locateCount = 0
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func updateLabelWithLocation(_ location: CLLocation!, regeocode: AMapLocationReGeocode?) {
        
        var infoString = String(format: "连续定位完成:%d\n\n回调时间:%@\n经 度:%.6f\n纬 度:%.6f\n精 度:%.3f米\n海 拔:%.3f米\n速 度:%.3f\n角 度:%.3f\n", self.locateCount, location.timestamp.description, location.coordinate.longitude, location.coordinate.latitude, location.horizontalAccuracy, location.altitude, location.speed, location.course)
        
//        var infoString = String(format: "连续定位完成:%d\n%@", self.locateCount, "aaaa")
        
        if regeocode != nil {
            let regeoString = String(format: "国 家:%@\n省:%@\n市:%@\n城市编码:%@\n区:%@\n区域编码:%@\n地 址:%@\n兴趣点:%@\n", regeocode!.country, regeocode!.province, regeocode!.city, regeocode!.citycode, regeocode!.district, regeocode!.adcode, regeocode!.formattedAddress, regeocode!.poiName)
            
            infoString = infoString + regeoString
        }
        
        self.locationgInfoLabel.text = infoString
    }
    
    //MARK: - AMapLocationManagerDelegate
    
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        print("Error:\(error)")
    }
        
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        print("Location:\(location)")
        
        self.locateCount += 1
        updateLabelWithLocation(location, regeocode: reGeocode)
        
    }


}

