//
//  DistractionsController.swift
//  DistractionJournal WatchKit Extension
//
//  Created by nag on 30/05/2019.
//  Copyright © 2019 Anton Novoselov. All rights reserved.
//

import WatchKit
import WatchConnectivity

class DistractionsController: WKInterfaceController {

    @IBOutlet weak var table: WKInterfaceTable!
    
    var distractions = ["Facebook", "Youtube", "Twitter"]

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        table.setNumberOfRows(distractions.count, withRowType: "distractionRow")
        
        for index in 0..<distractions.count {
            if let row = table.rowController(at: index) as? DistractionsRowController {
                row.label.setText(distractions[index])
            }
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let distraction = distractions[rowIndex]
        let date = Date()
        
        WCSession.default.transferUserInfo(["distraction": distraction, "date": date])
    }
}
