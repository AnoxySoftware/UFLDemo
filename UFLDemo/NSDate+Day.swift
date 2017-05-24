//
//  NSDate+Day.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 24/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import Foundation

extension NSDate {
    var day:Int {return NSCalendar.currentCalendar().components(.Day, fromDate: self).day}
    var month:Int {return NSCalendar.currentCalendar().components(.Month, fromDate: self).month}
    var year:Int {return NSCalendar.currentCalendar().components(.Year, fromDate: self).year}
}
