import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

//

class FilesController : ControllerProtocol {
    let files = StaticFileHandler(documentRoot: Environment.documentRoot)
    var routes: [Route] {
        return [
            Route(method: .get, uri: "/**", handler: self.files.handleRequest)
        ]
    }
}
