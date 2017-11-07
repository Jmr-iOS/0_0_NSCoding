/************************************************************************************************************************************/
/** @file		DataBackup.swift
 *	@project    0_0 - NSCoding
 * 	@brief		x
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Vioteq
 * 	@created	1/23/16
 * 	@last rev	x
 *
 *
 * 	@notes		x
 *
 * 	@section	Opens
 * 			none current
 *
 * 	@section	Legal Disclaimer
* 			All contents of this source file and/or any other Vioteq related source files are the explicit property on Vioteq
* 			Corporation. Do not distribute. Do not copy.   Copyright © 2016 Jaostech. All rights reserved.
 */
/************************************************************************************************************************************/
import UIKit


struct DataBackupKeys {
    static let num0  : String = "num0";
    static let num1  : String = "num1";
    static let str0  : String = "str0";
    static let str1  : String = "str1";
    static let my1_1 : String = "my1_1";
}


class DataBackup : NSObject, NSCoding {
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("name_of_app");

    var someNumber0 : Float;
    var someNumber1 : Float;
    var someString0 : String;
    var someString1 : String;
    
    var my1_1 : DataLevel_1_1;
 
//MARK: Initialization
    init?(num0 : Float, num1 : Float, str0 : String, str1: String, my1_1 : DataLevel_1_1) {

        print("DataBackup.init?");

        self.someNumber0 = num0;
        self.someNumber1 = num1;
        self.someString0 = str0;
        self.someString1 = str1;

        self.my1_1 = my1_1;

        super.init();
        
        return;
    }


// MARK: NSCoding
    //store
    func encode(with aCoder: NSCoder) {

        aCoder.encode(self.someNumber0,  forKey: DataBackupKeys.num0);
        aCoder.encode(self.someNumber1,  forKey: DataBackupKeys.num1);
        aCoder.encode(self.someString0, forKey: DataBackupKeys.str0);
        aCoder.encode(self.someString1, forKey: DataBackupKeys.str1);
        aCoder.encode(self.my1_1,       forKey: DataBackupKeys.my1_1);

        print("DataBackup.encodeWithCoder");
        
        return;
    }


    //retrieve
    required convenience init?(coder aDecoder: NSCoder) {

        let num0 : Float?  = aDecoder.decodeFloat(forKey: DataBackupKeys.num0);
        let num1 : Float?  = aDecoder.decodeFloat(forKey: DataBackupKeys.num1);
        let str0 : String? = aDecoder.decodeObject(forKey: DataBackupKeys.str0) as? String;
        let str1 : String? = aDecoder.decodeObject(forKey: DataBackupKeys.str1) as? String;

        let my1_1 : DataLevel_1_1? = aDecoder.decodeObject(forKey: DataBackupKeys.my1_1) as? DataLevel_1_1;

        print("DataBackup.convenience.init?");
        
//        if(my1_1 != nil) {
            self.init(num0:num0!, num1:num1!, str0:str0!, str1:str1!, my1_1:my1_1!);
//        } else {
//            self.init(num0:0, num1:0, str0: "", str1:"", my1_1:DataLevel_1_1(age: 0, color: "")!);
//        }
        
        return;
    }


}

