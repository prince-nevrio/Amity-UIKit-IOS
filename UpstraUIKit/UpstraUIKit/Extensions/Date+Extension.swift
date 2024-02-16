//
//  Date+Extension.swift
//  AmityUIKit
//
//  Created by Sarawoot Khunsri on 30/8/2563 BE.
//  Copyright © 2563 Amity. All rights reserved.
//

import UIKit

extension Date {
    var yearsFromNow: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    
    var monthsFromNow: Int {
        return Calendar.current.dateComponents([.month], from: self, to: Date()).month!
    }
    
    var weeksFromNow: Int {
        return Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear!
    }
    
    var daysFromNow: Int {
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day!
    }
    
    var isInYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    var hoursFromNow: Int {
        return Calendar.current.dateComponents([.hour], from: self, to: Date()).hour!
    }
    
    var minutesFromNow: Int {
        return Calendar.current.dateComponents([.minute], from: self, to: Date()).minute!
    }
    
    var secondsFromNow: Int {
        return Calendar.current.dateComponents([.second], from: self, to: Date()).second!
    }
    
    var relativeTime: String {
        if yearsFromNow > 0 {
            return "\(yearsFromNow) " + (yearsFromNow > 1 ? "år" : "år") + " sedan"
        }
        if monthsFromNow > 0 {
            return "\(monthsFromNow) " + (monthsFromNow > 1 ? "månader" : "månad") + " sedan"
        }
        if weeksFromNow > 0 {
            return "\(weeksFromNow) " + (weeksFromNow > 1 ? "veckor" : "vecka") + " sedan"
        }
        if isInYesterday {
            return "I går"
        }
        if daysFromNow > 0 {
            return "\(daysFromNow) " + (daysFromNow > 1 ? "dagar" : "dag") + " sedan"
        }
        
        // Use the difference in hours directly
        if hoursFromNow > 0 {
            return "\(hoursFromNow) " + (hoursFromNow > 1 ? "timmar" : "timme") + " sedan"
        }
        
        if minutesFromNow > 0 {
            return "\(minutesFromNow) " + (minutesFromNow > 1 ? "minuter" : "min") + " sedan"
        }
        
        return "Alldeles nyss"
    }
}
