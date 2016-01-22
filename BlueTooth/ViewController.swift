//
//  ViewController.swift
//  BlueTooth
//  Learing from https://github.com/anas-imtiaz/SwiftSensorTag/blob/master/SwiftSensorTag/ViewController.swift
//  Created by shan jiang on 21/01/16.
//  Copyright © 2016 Shan Jiang. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var statusLabel: UILabel?
    @IBOutlet weak var temLabel: UILabel?
    
    // BLE
    var centralManager : CBCentralManager!
    var peripheralDevice : CBPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize central manager on load
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    // Check BLE status for centralManager
    func centralManagerDidUpdateState(central: CBCentralManager) {
        
        if central.state == CBCentralManagerState.PoweredOn{
            
            central.scanForPeripheralsWithServices(nil, options: nil)
            self.statusLabel?.text = "Searching for BLE Devices"
            
        }else if central.state == CBCentralManagerState.PoweredOff{
            
            self.statusLabel?.text = "Turn on bluetooth"
        
        }else{
            
            print("Bluetooth switched off or not initialized")
            
        }
    }
    
    // Check out the discovered peripherals to find the deviced you want to connect
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        
        let deviceName = "THERMSmart-Sensor"
        let nameOfDeviceFound = peripheral.name

       
        print("Found devices--------------------------")
        print(peripheral)
        print("Name Of Device Found ------------------")
        print(nameOfDeviceFound)
        print("---------------------------------------")
        print("---------------------------------------")
        print("---------------------------------------")
    
        if(deviceName == nameOfDeviceFound){
            
            // Update status label
            self.statusLabel?.text = "Device Found"
            // Stop scanning
            self.centralManager.stopScan()
            // Set the peripheral to use and establish connection
            self.peripheralDevice = peripheral
            self.peripheralDevice.delegate = self
            self.centralManager.connectPeripheral(peripheral, options: nil)
            print(peripheral)
            
        }else{
            sleep(15)
            self.statusLabel?.text = "Sensor Tag Not Found"
        }
        
    }

}

