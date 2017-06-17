//
//  Acronym.swift
//
//  Created by Mark Morrill on 2017/06/16.
//
//

import StORM
import MySQLStORM

class Acronym: MySQLStORM {
    override func table() -> String {
        return "kpr_test"
    }
    
    var id: Int = 0
    var abbreviation:String = ""
    var definition:String = ""
    
    override func to(_ this: StORMRow) {
        self.id(from: this.data["id"]) //self.id             =  Int(this.data["id"] as? Int64 ?? 0)
        self.abbreviation   = this.data["abbreviation"] as? String ?? ""
        self.definition     = this.data["definition"] as? String ?? ""
    }
    
    func rows() -> [Acronym] {
        var rows = [Acronym]()
        
        for i in 0 ..< self.results.rows.count {
            let row = Acronym()
            row.to(self.results.rows[i])
            rows.append(row)
        }
        
        return rows
    }
    
    func asDictionary() -> [String:Any] {
        return [
            "id" : self.id,
            "abbreviation" : self.abbreviation,
            "definition" : self.definition
        ]
    }
    
    func id(from it:Any?) {
        self.id = Acronym.id(from: it) ?? 0
    }
    static func id(from it:Any?) -> Int? {
        if let it = it as? Int32 {
            return Int(it)
        }
        return nil
    }
    
    static func all() throws -> [Acronym] {
        let getObj = Acronym()
        try getObj.findAll()
        return getObj.rows()
    }
    
    static func first() throws -> Acronym? {
        let getObj = Acronym()
        let cursor = StORMCursor(limit: 1, offset: 0)
        try getObj.select(whereclause: "true", params: [], orderby: [], cursor: cursor)
        return getObj.rows().first
    }
    
    static func getAcronym(matchingId id:Int) throws -> Acronym {
        let getObj = Acronym()
        var findObj = [String: Any]()
        findObj["id"] = "\(id)"
        try getObj.find(findObj)
        return getObj
    }
    
    static func getAcronyms(matchingAbbreviation abbreviation:String) throws -> [Acronym] {
        let getObj = Acronym()
        var findObj = [String: Any]()
        findObj["abbreviation"] = abbreviation
        try getObj.find(findObj)
        return getObj.rows()
    }
    
    static func getAcronyms(notMatchingAbbreviation abbreviation:String) throws -> [Acronym] {
        let getObj = Acronym()
        try getObj.select(whereclause: "abbreviation != ?", params: [abbreviation], orderby: ["id"])
        return getObj.rows()
    }
    
}

