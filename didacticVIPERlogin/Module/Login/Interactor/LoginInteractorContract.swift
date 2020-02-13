//
//  LoginInteractorContract.swift
//
//  Created by Florin Adrian Odagiu on 22/01/2020.
//

import Foundation

protocol LoginInteractorContract: class {
    func loginProcessState() -> LoginProcessModel
    func loginActionRequested(for email: String, and password: String)
}
