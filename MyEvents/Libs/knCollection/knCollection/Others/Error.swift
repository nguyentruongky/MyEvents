//
//  Error.swift
//  Fixir
//
//  Created by Ky Nguyen on 4/6/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit


enum knErrorCode : String {
    case loginFail
    case invalidEmail
    case invalidPassword
    case emptyEmail
    case emptyPassword
    case notFound
    case timeOut
    case serverError
    case empty
    case emailExist
    case weakPassword
    case notSure
    case facebookCancel
    case cantGetUploadedUrl
    case uploadFail
}

struct knError {
    
    var code: knErrorCode?
    var message: String?
}
