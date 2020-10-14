//
//  ViewController.swift
//  autoConectionWifiApp
//
//  Created by 柿沼儀揚 on 2020/10/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        autoConnectWifi()
        
    }

    func autoConnectWifi(){
        
        let options = [kNEHotspotHelperOptionDisplayName : "好きな Wifi name"]
        let queue = DispatchQueue.main
        _ = NEHotspotHelper.register(options: options as [String : NSObject], queue: queue, handler: { cmd in
            var hotspotList: [AnyHashable] = []

            if cmd.commandType == .evaluate || cmd.commandType == .filterScanList {
                for network in cmd.networkList ?? [] {
                    print(">\(network.ssid)")
                    if network.ssid == "欲しいSSIDの情報" {
                        network.setConfidence(.high)
                        network.setPassword("パスワード")
                        hotspotList.append(network)
                    }
                }
                let response = cmd.createResponse(.success)
                if let hotspotList = hotspotList as? [NEHotspotNetwork] {
                    response.setNetworkList(hotspotList)
                }
                response.deliver()
            }
        })

    }
}

