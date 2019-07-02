//
//  Configurator.swift
//  Tabibakum
//
//  Created by osvinuser on 31/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class Configurator: NSObject {
    
 static let baseURL = "http://18.224.27.255:8000/api/"
 static let imageBaseUrl = "http://18.224.27.255:8000/storage/avatars/"
}

class indexingValue : NSObject{
    static var indexValue = Int()
    static var questionType = [String]()
    static var updateQuestionNaire = Int()
    static var complaintQuestionIndexValue = Int()
    static var complaintQuestionNaireType = [String]()
    static var questionNaireType = String()
    static var logOutViewString = String()
}
