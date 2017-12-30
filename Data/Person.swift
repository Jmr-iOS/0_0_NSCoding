//
//  Person.swift
//  EncodeExperiments
//
//  Created by dasdom on 16.08.15.
//  Copyright © 2015 Dominik Hauser. All rights reserved.
//

import Foundation

struct Person {
  var firstName: String
  var lastName: String
  
  static func encode(person: Person) {
    let personClassObject = HelperClass(person: person)
    
    NSKeyedArchiver.archiveRootObject(personClassObject, toFile: HelperClass.path())
  }
  
  static func decode() -> Person? {
    let personClassObject = NSKeyedUnarchiver.unarchiveObject(withFile: HelperClass.path()) as? HelperClass

    return personClassObject?.person
  }
}

extension Person {
    @objc(personHelperClass) class HelperClass: NSObject, NSCoding {
    
    var person: Person?
    
    init(person: Person) {
      self.person = person
      super.init()
    }
    
    class func path() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let path = documentsPath?.appendingFormat("/Person")
      return path!
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let firstName = aDecoder.decodeObject(forKey: "firstName") as? String else { person = nil; super.init(); return nil }
        guard let lastName = aDecoder.decodeObject(forKey: "lastName") as? String else { person = nil; super.init(); return nil }
      
      person = Person(firstName: firstName, lastName: lastName)
      
      super.init()
    }
    
    
    func encode(with aCoder: NSCoder) {
      aCoder.encode(person!.firstName, forKey: "firstName")
      aCoder.encode(person!.lastName, forKey: "lastName")
    }
  }
}
