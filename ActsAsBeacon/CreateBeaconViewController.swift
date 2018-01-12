//
//  CreateBeacopnViewController.swift
//  MactsAsBeacon
//
//  Created by Philipp Weiß on 10/03/2017.
//

import Cocoa

class CreateBeaconViewController: NSViewController{
    
    static let identifier = "CreateBeaconVC"
    
    @IBOutlet weak var uuidTextField: NSTextField!
    @IBOutlet weak var majorTextField: NSTextField!
    @IBOutlet weak var minorTextField: NSTextField!
    @IBOutlet weak var powerTextField: NSTextField!
    @IBOutlet weak var headerLabel: NSTextField!
    @IBOutlet weak var startStopButton: NSButton!
    
    private var viewModel: CreateBeaconViewControllerVMProtocol?
    
    var arrBeacon: Array<Dictionary<String, Any>>!
    
    var accueilBeacon: IBeacon!
    var elevator0Beacon: IBeacon!
    var elevator1Beacon: IBeacon!
    
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uuidTextField.stringValue = viewModel?.uuid ?? ""
        majorTextField.stringValue = viewModel?.major ?? ""
        minorTextField.stringValue = viewModel?.minor ?? ""
        powerTextField.stringValue = viewModel?.power ?? ""
        
        accueilBeacon = IBeacon(uuid: "8808EC6F-9771-405B-9229-6B82ABEC01F5", major: "6", minor: "0", power: "-58")
        
        elevator0Beacon = IBeacon(uuid: "8808EC6F-9771-405B-9229-6B82ABEC01F5", major: "6", minor: "1", power: "-58")
        
        elevator1Beacon = IBeacon(uuid: "8808EC6F-9771-405B-9229-6B82ABEC01F5", major: "6", minor: "2", power: "-58")
        
        arrBeacon = [
            [
                "beacon":IBeacon(uuid: "8808EC6F-9771-405B-9229-6B82ABEC01F5", major: "6", minor: "0", power: "-58"),
                "displayName":"Accueil"
            ],
            [
                "beacon":IBeacon(uuid: "8808EC6F-9771-405B-9229-6B82ABEC01F5", major: "6", minor: "1", power: "-58"),
                "displayName":"Elevator 0"
            ],
            [
                "beacon":IBeacon(uuid: "8808EC6F-9771-405B-9229-6B82ABEC01F5", major: "6", minor: "2", power: "-58"),
                "displayName":"Elevator 1"
            ],
            [
                "beacon":IBeacon(uuid: "8808EC6F-9771-405B-9229-6B82ABEC01F5", major: "10001", minor: "19641", power: "-58"),
                "displayName":"Appointment 90m"
            ],
        ]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        updateActiveState()
    }
    
    func setViewModel(viewModel: CreateBeaconViewControllerVMProtocol) {
        self.viewModel = viewModel
    }
    
    func updateActiveState() {
        if viewModel?.isActive == true {
            headerLabel.stringValue = NSLocalizedString("title_broadcasting", comment: "If broadcasting")
            startStopButton.title = NSLocalizedString("button_stop", comment: "Show the stop label")
        } else {
            headerLabel.stringValue = NSLocalizedString("title_not_broadcasting", comment: "If not broadcasting")
            startStopButton.title = NSLocalizedString("button_start", comment: "Show the start label")
        }
    }
    
    @IBAction func didCickStartButton(_ sender: NSButton) {
        viewModel?.minor = minorTextField.stringValue
        viewModel?.major = majorTextField.stringValue
        viewModel?.power = powerTextField.stringValue
        viewModel?.uuid = uuidTextField.stringValue
        
        viewModel?.pressedAdvertiseButton()
        
        updateActiveState()
    }
    
}

extension CreateBeaconViewController:NSTableViewDelegate, NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return arrBeacon.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        guard let item = arrBeacon?[row] else {
            return nil
        }
        
        return item["displayName"] as! String
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        var result:NSTableCellView
        result  = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as! NSTableCellView
        
        var text = ""
        
        guard let item = arrBeacon?[row] else {
            return nil
        }
        
        if tableColumn == tableView.tableColumns[0] {
            text = item["displayName"] as! String
        }
        
        result.textField?.stringValue = text
        return result
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let item = arrBeacon?[tableView.selectedRow]
        
        let beacon = item!["beacon"] as! IBeacon
        
        uuidTextField.stringValue = beacon.uuid
        majorTextField.stringValue = beacon.major
        minorTextField.stringValue = beacon.minor
        
    }
}

