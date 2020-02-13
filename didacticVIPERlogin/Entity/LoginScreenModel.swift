//
//  LoginScreenModel.swift
//
//  Created by Florin Adrian Odagiu on 22/01/2020.
//

import Foundation

struct LoginScreenModel {
    var emailBorderColor        : String //avoiding UIColor and inclusion of UIKit in model class
    var passwordBorderColor     : String //avoiding UIColor and inclusion of UIKit in model class
    var loginButtonText         : String
    var loginButtonEnabled      : Bool
    var activityIndicatorEnabled: Bool
    var errorText               : String
}
