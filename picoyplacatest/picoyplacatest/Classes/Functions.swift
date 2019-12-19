//
//  Functions.swift
//  picoyplacatest
//
//  Created by Diego Cando on 17/12/19.
//  Copyright © 2019 Diego Cando. All rights reserved.
//

import Foundation

let okMessage: String = "It's SAFE to go"
let restrictMessage: String = "NOT SAFE to go"

//MARK: Function to validate if the datetime passed is valid
func validateDateTime(dateTime: String)-> Bool {
    var result = false
    let myDate = getDateTime(dateTime: dateTime)
    if myDate.timeIntervalSince1970 > 0{
        result = true
    }
    return result
}

//MARK: Function to validate if the plate is valid
func validatePlate(plate: String)-> Bool{
    let workPlate = cleanPlate(plate: plate)
    let plateRegEx = "^[A-Za-z]{3}[0-9]{3,4}"
    let platePredicate = NSPredicate(format:"SELF MATCHES %@", plateRegEx)
    return platePredicate.evaluate(with: workPlate)
}

//MARK: Function to check if the car can go out by it's plate and datetime
func safe(plate: String, datetime: String)-> String{
    var message = ""
    
    if !validateDateTime(dateTime: datetime){
        message = "Invalid date"
    }
    
    if !validatePlate(plate: plate){
        message = "\(message) Invalid plate"
    }
    
    if message == "" {
        
        let date = getDateTime(dateTime: datetime)
        let calendar = Calendar.current
        let digit = plate.last
        
        switch calendar.component(.weekday, from: date) {
        case 2://Monday
            if (digit == "1" || digit == "2"){
                //Check hour
                message = restrictedTime(datetime: date)
            }
        case 3://Tuesday
            if (digit == "3" || digit == "4"){
                //Check hour
                message = restrictedTime(datetime: date)
            }
        case 4://Wednesday
            if (digit == "5" || digit == "6"){
                //Check hour
                message = restrictedTime(datetime: date)
            }
        case 5://Thursday
            if (digit == "7" || digit == "8"){
                //Check hour
                message = restrictedTime(datetime: date)
            }
        case 6://Friday
            if (digit == "9" || digit == "0"){
                //Check hour
                message = restrictedTime(datetime: date)
            }
        default://Saturday and sunday
            
            message = okMessage
        }
        
        if message == "" { //Week day but not corresponding to plate's last digit
            message = okMessage
        }
        
    }
    
    return message
}

//MARK: Function to clean the car plate into usable format
func cleanPlate(plate: String)->String{
    var workPlate = plate.trimmingCharacters(in: .whitespacesAndNewlines)
    workPlate = workPlate.replacingOccurrences(of: " ", with: "")
    workPlate = workPlate.replacingOccurrences(of: "-", with: "0")
    return workPlate
}

//MARK: Function to parse datetime from string
func getDateTime(dateTime: String)->Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //check if the date text is valid, else return date 0
    guard let date = dateFormatter.date(from:dateTime) else {
        return Date(timeIntervalSince1970: 0)
    }
    return date
}

//MARK: Function to complete numbers with 0 before
func zeroFill(data: Int, length: Int)->String{
    var myData = String(data)
    while (myData.count < length) {
        myData = "0\(myData)"
    }
    return myData
}

//MARK: Function to check if the provided time is within the restriction hours
func restrictedTime(datetime:Date)->String{
    let calendar = Calendar.current
    
    //Compare hours
    let dateA: Date = calendar.date(bySettingHour: 7, minute: 0, second: 0, of: datetime)!
    let dateB: Date = calendar.date(bySettingHour: 16, minute: 0, second: 0, of: datetime)!
    
    let amTime: Int = calendar.dateComponents([.second], from: dateA, to: datetime).second ?? 0
    let pmTime: Int = calendar.dateComponents([.second], from: dateB, to: datetime).second ?? 0
    
    if (amTime >= 0 && amTime <= 9000) || (pmTime >= 0 && pmTime <= 12600){ //Check if current time in the restriction zone
        return restrictMessage
    }else{
        return okMessage
    }
}
