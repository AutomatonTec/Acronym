import Foundation

// Responsibility: Convert to/from JSON, interact w/ Acronym class
class AcronymAPI {
    
    static func acronymsToDictionary(_ acronyms: [Acronym]) -> [[String: Any]] {
        var acronymsJson: [[String: Any]] = []
        for row in acronyms {
            acronymsJson.append(row.asDictionary())
        }
        return acronymsJson
    }
    
    static func allAsDictionary() throws -> [[String: Any]] {
        let acronyms = try Acronym.all()
        return acronymsToDictionary(acronyms)
    }
    
    static func all() throws -> String {
        return try allAsDictionary().jsonEncodedString()
    }
    
    static func first() throws -> String {
        if let acronym = try Acronym.first() {
            return try acronym.asDictionary().jsonEncodedString()
        } else {
            return try [].jsonEncodedString()
        }
    }
    
    static func matchingAbbreviation(_ str: String) throws -> String {
        let acronyms = try Acronym.getAcronyms(matchingAbbreviation: str)
        return try acronymsToDictionary(acronyms).jsonEncodedString()
    }
    
    static func notMatchingAbbreviation(_ str: String) throws -> String {
        let acronyms = try Acronym.getAcronyms(notMatchingAbbreviation: str)
        return try acronymsToDictionary(acronyms).jsonEncodedString()
    }
    
    static func delete(id: Int) throws {
        let acronym = try Acronym.getAcronym(matchingId: id)
        try acronym.delete()
    }
    
    static func deleteFirst() throws -> String {
        guard let acronym = try Acronym.first() else {
            return "No acronym to update"
        }
        
        try acronym.delete()
        return try all()
    }
    
    static func test() throws -> String {
        let acronym = Acronym()
        acronym.abbreviation = "AFK"
        acronym.definition = "Away From Keyboard"
        try acronym.save { id in
            acronym.id(from: id)
            //acronym.id = id as! Int
        }
        
        return try all()
    }
    
    static func newAcronym(withAbbreviation abbreviation: String, definition: String) throws -> [String: Any] {
        let acronym = Acronym()
        acronym.abbreviation = abbreviation
        acronym.definition = definition
        try acronym.save { id in
            acronym.id = id as! Int
        }
        return acronym.asDictionary()
    }
    
    static func newAcronym(withJSONRequest json: String?) throws -> String {
        guard let json = json,
            let dict = try json.jsonDecode() as? [String: String],
            let abbreviation = dict["abbreviation"],
            let definition = dict["definition"] else {
                return "Invalid parameters"
        }
        
        return try newAcronym(withAbbreviation: abbreviation, definition: definition).jsonEncodedString()
    }
    
    static func updateAcronym(withJSONRequest json: String?) throws -> String {
        guard let json = json,
            let dict = try json.jsonDecode() as? [String: Any],
            let id = Acronym.id(from: dict["id"]),   //dict["id"] as? Int,
            let abbreviation = dict["abbreviation"] as? String,
            let definition = dict["definition"] as? String else {
                return "Invalid parameters"
        }
        
        let acronym = try Acronym.getAcronym(matchingId: id)
        acronym.abbreviation = abbreviation
        acronym.definition = definition
        try acronym.save()
        
        return try acronym.asDictionary().jsonEncodedString()
    }
    
}
