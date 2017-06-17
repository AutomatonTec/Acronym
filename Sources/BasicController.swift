import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// 

class BasicController : ControllerProtocol {
    
    var routes: [Route] {
        return [
            Route(method: .get,     uri: "/test",           handler: self.test),
            Route(method: .post,    uri: "/new",            handler: self.new),
            Route(method: .get,     uri: "/all",            handler: self.all),
            Route(method: .get,     uri: "/first",          handler: self.first),
            Route(method: .get,     uri: "/afks",           handler: self.afks),
            Route(method: .get,     uri: "/non-afks",       handler: self.nonAfks),
            Route(method: .post,    uri: "/update",         handler: self.update),
            Route(method: .get,     uri: "/delete-first",   handler: self.deleteFirst)
        ]
    }
    
    func test(request: HTTPRequest, response: HTTPResponse) {
        do {
            let json = try AcronymAPI.test()
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    
    func new(request: HTTPRequest, response: HTTPResponse) {
        do {
            let json = try AcronymAPI.newAcronym(withJSONRequest: request.postBodyString)
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    
    func all(request: HTTPRequest, response: HTTPResponse) {
        do {
            let json = try AcronymAPI.all()
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    
    func first(request: HTTPRequest, response: HTTPResponse) {
        do {
            let json = try AcronymAPI.first()
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    
    func afks(request: HTTPRequest, response: HTTPResponse) {
        do {
            let json = try AcronymAPI.matchingAbbreviation("AFK")
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    
    func nonAfks(request: HTTPRequest, response: HTTPResponse) {
        do {
            let json = try AcronymAPI.notMatchingAbbreviation("AFK")
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    
    func update(request: HTTPRequest, response: HTTPResponse) {
        do {
            let json = try AcronymAPI.updateAcronym(withJSONRequest: request.postBodyString)
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    
    func deleteFirst(request: HTTPRequest, response: HTTPResponse) {
        do {
            let json = try AcronymAPI.deleteFirst()
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    
}
