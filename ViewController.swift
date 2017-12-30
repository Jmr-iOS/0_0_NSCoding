//
//  ViewController.swift
//  0_0 - NSCoding
//  @brief  a demo is given using the contents of the following url. the user is provided a set of fields which are either loaded 
//          from memory or are blank. the user is given the choice to 'Submit' the current field values to the memory stored value
//
//  @url    https://developer.apple.com/library/ios/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Lesson10.html
//
//  @section    Opens
//      File Headers
//      Fcn Headers
//      Project Folder Struct (e.g. Base/, Data/, etc.)
//      DataBackup Update, Fresh & Crisp
//      Strong DataBackup Examples
//      Update DataBackup in ALL ref projects
//
import UIKit

class ViewController: UIViewController, UITextFieldDelegate/*, NSCoding(already does)*/ {

    //temp - for now we are small, just these two fields and that's it!!! eventually we will be verbose and detailed, and even have
    //       NSCodingMeal as an example!
    @objc var nameField : UITextField = UITextField();
    @objc var numField  : UITextField = UITextField();
    

    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.translatesAutoresizingMaskIntoConstraints = false;

        self.genUI();                   //generate fields for user input
        
        self.loadData();                //called AFTER UI init

        print("ViewController.viewDidLoad():       viewDidLoad() complete");
        
        return;
    }

    
    func genUI() {
        
        //myName string
        self.nameField = UITextField(frame: CGRect(x: 20, y: 50, width: 300, height: 40));
        self.nameField.placeholder = "enter myName here";
        self.nameField.keyboardType = .default;
        self.nameField.delegate = self;
        
        self.view.addSubview(self.nameField);
        

        //myNum num
        self.numField = UITextField(frame: CGRect(x: 20, y: 80, width: 300, height: 40));
        self.numField.placeholder = "enter myNum here";
        self.numField.keyboardType = .decimalPad;
        self.numField.delegate = self;
        
        self.view.addSubview(self.numField);
        
        
        //(todo) myMeal struct


        //Return Button
        let returnButton : UIButton = UIButton(type: UIButtonType.roundedRect);
        
        returnButton.setTitle("Return",      for: UIControlState());
        returnButton.sizeToFit();
        returnButton.center = CGPoint(x: 45, y: 130);
        
        //actions
        returnButton.addTarget(self, action: #selector(ViewController.pressed(_:)), for:  .touchUpInside);
        
        //add
        self.view.addSubview(returnButton);
        
    }


    @objc func pressed(_ sender: UIButton!) {
        
        //return keyboard (assume it's up :)  )
        self.view.endEditing(true);
        sender.resignFirstResponder();           //not sure if this is required, but is often used so I'll use it too! not required though?
        
        self.saveData();
        
        return;
    }


    func saveData() {
        
        //@pre  safety nil check
        if((self.nameField.text==nil)||(self.numField.text==nil)) {
            print("ViewController.saveData():    aborting save due to nil data");
        }
        
        let nameVal : String = self.nameField.text!;
        let numVal  : Float  = Float(self.numField.text!)!;
        
        let my1_1 : DataLevel_1_1 = DataLevel_1_1(age: 108, color: "B?")!;
        
        let newBackup :DataBackup = DataBackup(num0: numVal, num1: numVal, str0: nameVal, str1: nameVal, my1_1:my1_1)!;
        
        let backupSaveStatus = NSKeyedArchiver.archiveRootObject(newBackup,      toFile: DataBackup.ArchiveURL.path);
        
        self.debugPrint(newBackup, dispStr: "saved as 'newBackup' in saveData() call");
        
        print("ViewController.saveData():    name save status is '\(backupSaveStatus)'");

        return;
    }


    func loadData() {

        let retrievedData : DataBackup? = NSKeyedUnarchiver.unarchiveObject(withFile: DataBackup.ArchiveURL.path) as? DataBackup;

        if(nil == retrievedData) {
            return;                                         /* abort if no data found                                               */
        }
        
        self.debugPrint(retrievedData, dispStr: "loaded as 'retrievedData' in loadData() call");
        
        print("ViewController.loadData():    name retrieved is '\(retrievedData!)'");

        if(retrievedData != nil) {
            self.nameField.text = retrievedData!.someString0;
            self.numField.text  = String(format: "%f", retrievedData!.someNumber0);
        }

        
        return;
    }


    /********************************************************************************************************************************/
    /* @fcn     debugPrint(data : DataBackup?)                                                                                      */
    /* @brief   print the data to console. used for validataion of NSCoding operations                                              */
    /********************************************************************************************************************************/
    func debugPrint(_ data : DataBackup?, dispStr : String) {
        
        print(" ");
        print(" ");
        print("//**********************************************************************************//");
        print("//DEBUG DATA VALUE FOR '\(dispStr)");
        
        if(data == nil) {
            print("//- DataBackup data is nil");
        } else {
            //print all fields
            print("//- DataBackup data was found");
            print("//- Top Level Data (DataBackup)");
            print("//    DataBackup.someNumber0 - '\(String(describing: data?.someNumber0))'");
            print("//    DataBackup.someNumber1 - '\(String(describing: data?.someNumber1))'");
            print("//    DataBackup.someString0 - '\(String(describing: data?.someString0))'");
            print("//    DataBackup.someString1 - '\(String(describing: data?.someString1))'");
            print("//");
            print("//- DataBackup Level 1_1 Data");
            print("//    DataBackup.DataLevel_1_1.age   - '\(String(describing: data?.my1_1.age))'");
            print("//    DataBackup.DataLevel_1_1.color - '\(String(describing: data?.my1_1.color))'");
            print("//");
            print("//- Data X");
            print("//- Data X.A");
            print("//- Data X.A");
            print("//- Data X.A");
            print("//- Data X.A");
            print("//- Data Y");
            print("//- Data Z");
        }
        
        print("//**********************************************************************************//");
        print(" ");
        print(" ");
        
        return;
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        
        return;
    }
}

