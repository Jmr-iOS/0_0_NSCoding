/************************************************************************************************************************************/
/** @file		DataBackup.swift
 *	@project    0_0 - aNoteTable
 * 	@brief		x
 * 	@details	x
 *
 * 	@notes		x
 *
 * 	@section	Opens
 *          implemented backup & validated
 *          changed to global use of 'verbose'
 *          define a rows data to save and document or store
 *          store VC automatically (M)
 *
 *  @section    Data Definition
 *          UI    - none at present
 *          Table - [Cell Data] (one per row, non-volatile cell data)
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class DataBackup : NSObject, NSCoding {

    //Class Data
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL         = DocumentsDirectory.appendingPathComponent("ANote_Ref_Sw_Bak4a");

    static let verbose : Bool = true;                                       /* given a seperate backup declaration for verbosity    */
    
    //System value FOR backup
    static var vc : ViewController!;                                        /* for use and access to data during a backup store/load*/

    //Backup Data
    var someVal_0 : Int?;
    var someStr_0 : String?;
    var someVals  : [Int]?;
    var someBlog  : Blog?;
    var somePers  : Person?;

    
//MARK: Initialization
    /********************************************************************************************************************************/
    /** @fcn        init?(someVal_0 : Int?, someStr_0 : String?)
     *  @brief      initialization from backup
     *  @details    used by convienence init
     *
     *  @param      [in] (Int?)    someVal_0 - x
     *  @param      [in] (String?) someStr_0 - x
     *  @param      [in] ([String]?) someVals - test array
     */
    /********************************************************************************************************************************/
    init?(someVal_0 : Int?, someStr_0 : String?, someVals : [Int]?, someBlog : Blog?, somePers : Person?) {
        
        if(DataBackup.verbose) { print("DataBackup.init?():                 initialization from backup begin (\(someVal_0!))"); }

        self.someVal_0 = someVal_0;
        self.someStr_0 = someStr_0;
        self.someVals  = someVals;
        self.someBlog = someBlog;
        self.somePers = somePers;

        super.init();
        
        if(DataBackup.verbose) { print("DataBackup.init?():                 initialization from backup complete"); }
        
        return;
    }


// MARK: NSCoding
    //Store
    /********************************************************************************************************************************/
    /** @fcn        encode()
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (NSCoder) aCoder - x
     */
    /********************************************************************************************************************************/
    func encode(with aCoder: NSCoder) {

        if(DataBackup.verbose) { print("DataBackup.encodeWithCoder():       storage init"); }

        aCoder.encode(self.someVal_0, forKey:DataBackupKeys.someVal_0);
        aCoder.encode(self.someStr_0, forKey:DataBackupKeys.someStr_0);
        aCoder.encode(self.someVals, forKey: DataBackupKeys.someArr);
        aCoder.encode(self.someBlog, forKey: DataBackupKeys.someBlog);
        Person.encode(person: self.somePers!);
        if(DataBackup.verbose) { print("DataBackup.encodeWithCoder():       storage complete"); }

        return;
    }
    
    
    //Retrieve
    /********************************************************************************************************************************/
    /** @fcn        convenience init?()
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (NSCoder) coder - x
     */
    /********************************************************************************************************************************/
    required convenience init?(coder aDecoder: NSCoder) {

        let someVal_0Backup : Int?    = aDecoder.decodeObject(forKey: DataBackupKeys.someVal_0) as? Int;
        let someStr_0Backup : String? = aDecoder.decodeObject(forKey: DataBackupKeys.someStr_0) as? String;
        let someValsBackup  : [Int]?  = aDecoder.decodeObject(forKey: DataBackupKeys.someArr) as? [Int];
        let someBlogBackup  : Blog?   = aDecoder.decodeObject(forKey: DataBackupKeys.someBlog) as? Blog;
        let somePersBackup  : Person? = Person.decode();

        
        if(DataBackup.verbose) { print("DataBackup.convience.init?():       retrieved \(someVal_0Backup!) for dummyData"); }
        
        self.init(someVal_0: someVal_0Backup, someStr_0: someStr_0Backup, someVals: someValsBackup, someBlog : someBlogBackup, somePers: somePersBackup);
        
        if(DataBackup.verbose) { print("DataBackup.convience.init?():       initialization complete"); }
        
        return;
    }


// MARK: Code Interface
    /********************************************************************************************************************************/
    /*	@fcn		class func loadData()                                                                                           */
    /*  @brief      retrieve the App data & state to from file backup                                                               */
    /*  @details    calls convienence init() on backup retrieval                                                                    */
    /*  @pre        vc is stored                                                                                                    */
    /********************************************************************************************************************************/
    class func loadData() {

        let vc : ViewController;
        
        //@pre
        if(!DataBackup.exists()) {
            print("DataBackup.loadData():             warning, vc not stored on call, aborting load");
            return;
        } else {
            vc = DataBackup.vc!;                                /* grab vc                                                          */
        }
        
        if(DataBackup.verbose) { print("DataBackup.loadData():              entering NSKeyedUnarchiver search"); }
        let retrievedData : DataBackup? = NSKeyedUnarchiver.unarchiveObject(withFile: DataBackup.ArchiveURL.path) as? DataBackup;
        if(DataBackup.verbose) { print("DataBackup.loadData():              exiting NSKeyedUnarchiver search with '\(retrievedData!.hash)'"); }

        //Apply the loaded data to vc
        vc.someVal_0 = (retrievedData?.someVal_0)!;
        vc.someStr_0 = (retrievedData?.someStr_0)!;
        vc.someVals  = (retrievedData?.someVals)!;
        vc.someBlog  = (retrievedData?.someBlog)!;
        vc.somePers  = (retrievedData?.somePers)!;
        
        return;
    }


    /********************************************************************************************************************************/
    /*	@fcn		class func saveData()                                                                                           */
    /*  @brief      save the App data & state from the view controller access to file for later retrieval                           */
    /*  @pre        vc is stored                                                                                                    */
    /*  @assum      bak is valid data                                                                                               */
    /********************************************************************************************************************************/
    class func saveData() {

        let vc : ViewController = DataBackup.vc;                            /* grab vc                                              */
        
        //**************************************************************************************************************************//
        //                                          GEN BACKUP FOR STORAGE                                                          //
        //**************************************************************************************************************************//
        let currVal_0 : Int    = vc.someVal_0;                                              /* Grab State                           */
        let currStr_0 : String = vc.someStr_0;                                              /* Grab State                           */
        let currVals  : [Int]  = vc.someVals;                                               /* Grab State                           */
        let currBlog  : Blog   = vc.someBlog;
        let currPers  : Person = vc.somePers;

        let backup : DataBackup = DataBackup(someVal_0: currVal_0, someStr_0: currStr_0, someVals: currVals, someBlog: currBlog, somePers: currPers)!;  /* Gen Backup            */

        
        //**************************************************************************************************************************//
        //                                             STORE BACKUP                                                                 //
        //**************************************************************************************************************************//
        let backupSaveStatus = NSKeyedArchiver.archiveRootObject(backup,      toFile: DataBackup.ArchiveURL.path);        
        Person.encode(person: vc.somePers);
        
        if(verbose) { print("DataBackup.saveData():              name save status is '\(backupSaveStatus)' "); }

        return;
    }
    
    
    /********************************************************************************************************************************/
    /*	@fcn		class func updateBackup()                                                                                       */
    /*  @brief      a clean wrapper for simple and clear code architecture communication                                            */
    /********************************************************************************************************************************/
    class func updateBackup() {
        DataBackup.saveData();
        return;
    }
    
    
    /********************************************************************************************************************************/
    /*	@fcn		class func storeViewController(vc : ViewController)                                                             */
    /*  @brief      x                                                                                                               */
    /*                                                                                                                              */
    /*  @param      [in] (ViewController) vc - x                                                                                    */
    /********************************************************************************************************************************/
    class func storeViewController(_ vc : ViewController) {
        DataBackup.vc = vc;
        return;
    }
    
    
    /********************************************************************************************************************************/
    /*  @fcn        class func storeViewController(vc : ViewController)                                                             */
    /*  @brief      x                                                                                                               */
    /*  @details    calls convienence init() on backup retrieval                                                                    */
    /*                                                                                                                              */
    /*  @return     (Bool) if backup present                                                                                        */
    /********************************************************************************************************************************/
    class func exists() -> Bool {
        let retrievedData : DataBackup? = NSKeyedUnarchiver.unarchiveObject(withFile: DataBackup.ArchiveURL.path) as? DataBackup;
        return (retrievedData != nil);
    }
}


/************************************************************************************************************************************/
/*																  KEYS                                                              */
/************************************************************************************************************************************/
struct DataBackupKeys {
    static let someVal_0 : String = "someVal_0";
    static let someStr_0 : String = "someStr_0";
    static let someArr   : String = "someArr";
    static let someBlog  : String = "someBlog";
}

