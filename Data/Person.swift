/************************************************************************************************************************************/
/** @file       Person.swift
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Vioteq
 *  @created    12/30/17
 *  @last rev   12/31/17
 *
 *
 *  @notes      x
 *
 *  @section    Opens
 *      none current
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Vioteq related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
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
  
    
    /********************************************************************************************************************************/
    /** @fcn      int main(void)
     *  @brief    x
     *  @details  x
     *
     *  @section  Purpose
     *      x
     *
     *  @param    [in]  name    descrip
     *
     *  @param    [out] name    descrip
     *
     *  @return   (type) descrip
     *
     *  @pre      x
     *
     *  @post     x
     *
     *  @section  Operation
     *      x
     *
     *  @section  Opens
     *      x
     *
     *  @section  Hazards & Risks
     *      x
     *
     *  @section  Todo
     *      x
     *
     *  @section  Timing
     *      x
     *
     *  @note     x
     */
    /********************************************************************************************************************************/
  static func encode(person: Person) {
    let personClassObject = HelperClass(person: person)
    
    NSKeyedArchiver.archiveRootObject(personClassObject, toFile: HelperClass.path())
  }
  
    /********************************************************************************************************************************/
    /** @fcn      int main(void)
     *  @brief    x
     *  @details  x
     *
     *  @section  Purpose
     *      x
     *
     *  @param    [in]  name    descrip
     *
     *  @param    [out] name    descrip
     *
     *  @return   (type) descrip
     *
     *  @pre      x
     *
     *  @post     x
     *
     *  @section  Operation
     *      x
     *
     *  @section  Opens
     *      x
     *
     *  @section  Hazards & Risks
     *      x
     *
     *  @section  Todo
     *      x
     *
     *  @section  Timing
     *      x
     *
     *  @note     x
     */
    /********************************************************************************************************************************/
  static func decode() -> Person? {
    let personClassObject = NSKeyedUnarchiver.unarchiveObject(withFile: HelperClass.path()) as? HelperClass

    return personClassObject?.person
  }
}

//@todo     header
extension Person {
    @objc(personHelperClass) class HelperClass: NSObject, NSCoding {
    
    var person: Person?
    
    /********************************************************************************************************************************/
    /** @fcn      int main(void)
     *  @brief    x
     *  @details  x
     *
     *  @section  Purpose
     *      x
     *
     *  @param    [in]  name    descrip
     *
     *  @param    [out] name    descrip
     *
     *  @return   (type) descrip
     *
     *  @pre      x
     *
     *  @post     x
     *
     *  @section  Operation
     *      x
     *
     *  @section  Opens
     *      x
     *
     *  @section  Hazards & Risks
     *      x
     *
     *  @section  Todo
     *      x
     *
     *  @section  Timing
     *      x
     *
     *  @note     x
     */
    /********************************************************************************************************************************/
    init(person: Person) {
      self.person = person
      super.init()
    }
    
        
    /********************************************************************************************************************************/
    /** @fcn      int main(void)
     *  @brief    x
     *  @details  x
     *
     *  @section  Purpose
     *      x
     *
     *  @param    [in]  name    descrip
     *
     *  @param    [out] name    descrip
     *
     *  @return   (type) descrip
     *
     *  @pre      x
     *
     *  @post     x
     *
     *  @section  Operation
     *      x
     *
     *  @section  Opens
     *      x
     *
     *  @section  Hazards & Risks
     *      x
     *
     *  @section  Todo
     *      x
     *
     *  @section  Timing
     *      x
     *
     *  @note     x
     */
    /********************************************************************************************************************************/
    class func path() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let path = documentsPath?.appendingFormat("/Person")
      return path!
    }
    
        
    /********************************************************************************************************************************/
    /** @fcn      int main(void)
     *  @brief    x
     *  @details  x
     *
     *  @section  Purpose
     *      x
     *
     *  @param    [in]  name    descrip
     *
     *  @param    [out] name    descrip
     *
     *  @return   (type) descrip
     *
     *  @pre      x
     *
     *  @post     x
     *
     *  @section  Operation
     *      x
     *
     *  @section  Opens
     *      x
     *
     *  @section  Hazards & Risks
     *      x
     *
     *  @section  Todo
     *      x
     *
     *  @section  Timing
     *      x
     *
     *  @note     x
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) {
        guard let firstName = aDecoder.decodeObject(forKey: "firstName") as? String else { person = nil; super.init(); return nil }
        guard let lastName = aDecoder.decodeObject(forKey: "lastName") as? String else { person = nil; super.init(); return nil }
      
      person = Person(firstName: firstName, lastName: lastName)
      
      super.init()
    }
    
    
        
    /********************************************************************************************************************************/
    /** @fcn      int main(void)
     *  @brief    x
     *  @details  x
     *
     *  @section  Purpose
     *      x
     *
     *  @param    [in]  name    descrip
     *
     *  @param    [out] name    descrip
     *
     *  @return   (type) descrip
     *
     *  @pre      x
     *
     *  @post     x
     *
     *  @section  Operation
     *      x
     *
     *  @section  Opens
     *      x
     *
     *  @section  Hazards & Risks
     *      x
     *
     *  @section  Todo
     *      x
     *
     *  @section  Timing
     *      x
     *
     *  @note     x
     */
    /********************************************************************************************************************************/
    func encode(with aCoder: NSCoder) {
      aCoder.encode(person!.firstName, forKey: "firstName")
      aCoder.encode(person!.lastName, forKey: "lastName")
    }
  }
}
