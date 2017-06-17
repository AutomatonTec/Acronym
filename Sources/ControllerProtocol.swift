//
//  ControllerProtocol.swift
//
//  Created by Mark Morrill on 2017/06/17.
//
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

protocol ControllerProtocol {
    var routes : [Route] { get }
}
