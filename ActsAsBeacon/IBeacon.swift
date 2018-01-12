//
//  IBeacon.swift
//  MactsAsBeacon
//
//  Created by Philipp Weiß on 10/03/2017.
//

import Foundation


struct IBeacon {
    static let advertisementKey = "kCBAdvDataAppleBeaconKey"
    
    // Beacon Foch Accueil
    
    static let defaultUUID = "8808EC6F-9771-405B-9229-6B82ABEC01F5"
    static let defaultMajor = "6"
    static let defaultMinor = "0"
    static let defaultPower = "-58"

    // Beacon Foch Elevator Principal 0
    
    //    static let defaultUUID = "8808EC6F-9771-405B-9229-6B82ABEC01F5"
    //    static let defaultMajor = "6"
    //    static let defaultMinor = "1"
    //    static let defaultPower = "-58"
    
    // Beacon Foch Elevator Principal 1
    
    //    static let defaultUUID = "8808EC6F-9771-405B-9229-6B82ABEC01F5"
    //    static let defaultMajor = "6"
    //    static let defaultMinor = "2"
    //    static let defaultPower = "-58"
    
    var uuid: String
    var major: String
    var minor: String
    var power: String
}
