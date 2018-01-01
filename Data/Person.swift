/************************************************************************************************************************************/
/** @file       Person.swift
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
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
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import Foundation


struct Person {

    var firstName : String;
    var lastName  : String;
  
    
    /********************************************************************************************************************************/
    /** @fcn      static func encode(person: Person)
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    @discardableResult
    static func encode(person: Person) -> Bool {
        let personClassObject = HelperClass(person: person);

        let rslt : Bool = NSKeyedArchiver.archiveRootObject(personClassObject, toFile: HelperClass.path())
        
        return rslt;
    }
  
    
    /********************************************************************************************************************************/
    /** @fcn      static func decode() -> Person?
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    static func decode() -> Person? {
        let personClassObject = NSKeyedUnarchiver.unarchiveObject(withFile: HelperClass.path()) as? HelperClass;

        return personClassObject?.person;
    }
}

//**********************************************************************************************************************************//
//  HELPER CLASS (PERSON)                                                                                                           //
//**********************************************************************************************************************************//
extension Person {
    @objc(personHelperClass) class HelperClass: NSObject, NSCoding {
    
    var person: Person?
    
        
    /********************************************************************************************************************************/
    /** @fcn      init(person: Person
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    init(person: Person) {
      self.person = person
      super.init()
    }
    
        
    /********************************************************************************************************************************/
    /** @fcn      class func path() -> String
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    class func path() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first;
        
        let path = documentsPath?.appendingFormat("/Person");
        
        return path!;
    }
    
        
    /********************************************************************************************************************************/
    /** @fcn      required init?(coder aDecoder: NSCoder)
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) {
        guard let firstName = aDecoder.decodeObject(forKey: "firstName") as? String else { person = nil; super.init(); return nil }
        guard let lastName = aDecoder.decodeObject(forKey: "lastName") as? String else { person = nil; super.init(); return nil }

        person = Person(firstName: firstName, lastName: lastName);

        super.init();
        
        return;
    }
    
    
        
    /********************************************************************************************************************************/
    /** @fcn      func encode(with aCoder: NSCoder)
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    func encode(with aCoder: NSCoder) {
        aCoder.encode(person!.firstName, forKey: "firstName");
        aCoder.encode(person!.lastName,  forKey: "lastName");

        return;
    }
  }
}

