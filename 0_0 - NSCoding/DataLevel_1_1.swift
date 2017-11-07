/************************************************************************************************************************************/
/** @file		DataLevel_1_1.swift
 *	@project    0_0 - NSCoding
 * 	@brief		x
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Vioteq
 * 	@created	1/25/16
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

struct DataLvl_1_1_Keys {
    static let age   : String = "age";
    static let color : String = "color";
}


class DataLevel_1_1 : NSObject, NSCoding {
 
    static let myClass : String = "DataLevel_1_1";
    var myName         : String = "unfilled";
    
    var age   : Float;
    var color : String;


//MARK: Initialization
    init?(age : Float, color: String) {
        
        self.age   = age;
        self.color = color;
        
        super.init();
        
        return;
    }

// MARK: NSCoding
    //store
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeFloat(self.age,    forKey: DataLvl_1_1_Keys.age);
        aCoder.encodeObject(self.color, forKey: DataLvl_1_1_Keys.color);
        
        return;
    }
    
    
    //retrieve
    required convenience init?(coder aDecoder: NSCoder) {
        
        let age : Float?  = aDecoder.decodeFloatForKey(DataLvl_1_1_Keys.age);
        let color : String? = aDecoder.decodeObjectForKey(DataLvl_1_1_Keys.color) as? String;

        if(age != nil) {
            self.init(age:age!, color:color!);
        } else {
            self.init(age:0, color:"no color");
        }
        
        return;
    }

}

