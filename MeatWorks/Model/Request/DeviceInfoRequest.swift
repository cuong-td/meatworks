//
//  DeviceInfoRequest.swift
//  MeatWorks
//
//  Created by Cuong Thai on 6/6/21.
//  Copyright © 2021 Bzb. All rights reserved.
//

import Foundation

import UIKit
import CoreTelephony


///public
class DeviceInfo: NSObject {
   
   ///Get the system version
   class func zz_getDeviceSystemVersion() -> String {
       return UIDevice.current.systemVersion
   }
   
        ///Get the system name
   class func zz_getDeviceSystemName() -> String {
       return UIDevice.current.systemName
   }
   
        ///Get the system name iPhone", "iPod touch"
   class func zz_getDeviceModel() -> String {
       return UIDevice.current.model
   }
   
        ///Get the system name localized version of model
   class func zz_getDeviceLocalizedModel() -> String {
       return UIDevice.current.localizedModel
   }
   
        ///Get the device name, such as XXX's iPhone
   class func zz_getDeviceUserName() -> String {
       return UIDevice.current.name
   }
        ///Get the total memory
   class func zz_getDeviceDiskTotalSize() -> String {
       return fileSizeToString(fileSize: zz_getTotalDiskSize())
   }
   
        ///Get available memory
   class func zz_getDeviceAvalibleDiskSize() -> String {
       return fileSizeToString(fileSize: zz_getAvailableDiskSize())
   }
   
        ///Get the carrier
   class func zz_getDeviceSupplier() -> String {
       return zz_deviceSupplier()
   }
   
        /// Get the current device IP
   class func zz_getDeviceIP() -> String {
     return zz_deviceIP()
   }

        ///Get the cpu core type
   class func zz_getDeviceCpuCount() -> Int {
       return zz_deviceCpuCount()
   }
   
        ///Get the cpu type
   class func zz_getDeviceCpuType() -> String {
       return zz_deviceCpuType()
   }

        ///Get the device name
   class func zz_getDeviceName() -> String {
       return zz_deviceName()
   }
}
