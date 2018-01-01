/************************************************************************************************************************************/
/** @file       ViewController.swift
 *  @project    0_0 - NSCoding
 *  @brief      a demo is given using the contents of the following url. the user is provided a set of fields which are either loaded
 *              from memory or are blank. the user is given the choice to 'Submit' the current field values to the memory stored value
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Vioteq
 *  @created    11/06/17
 *  @last rev   12/20/17
 *
 *  @url    https://developer.apple.com/library/ios/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Lesson10.html
 *
 *  @section    Opens
 *      DataBackup Update, Fresh & Crisp
 *          Subclass of ClassBackup & StructBackup to lib
 *      Strong DataBackup Examples
 *      Update DataBackup in ALL ref projects
 *
 *  @notes      x
 *
 *  @section    Opens
 *      none current
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Vioteq related source files are the explicit property on Vioteq
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ViewController: UIViewController, UITextFieldDelegate/*, NSCoding(already does)*/ {

    
    //Class Data
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!;
    static let ArchiveURL         = DocumentsDirectory.appendingPathComponent("ANote_Ref_Sw_Bak4a");
    
    static let verbose : Bool = true;                                       /* given a seperate backup declaration for verbosity    */
    
    //System value FOR backup
    static var vc : ViewController!;                                        /* for use and access to data during a backup store/load*/
    
    //Backup Data
    var someVal_0 : Int;
    var someStr_0 : String;
    var someVals  : [Int];
    var someBlog  : Blog;
    var somePers  : Person;

    //UI
    //Int
    var numField  : UITextField = UITextField();

    //String
    var nameField : UITextField = UITextField();
    
    //@todo     arrSize
    //@todo     arrayVal
    //@todo     Blog_1
    //@todo     Blog_2
    //@todo     Struct_1
    //@todo     Apply Button
    //@todo     Submit Button
    //@todo     Check Button
    
    

    /********************************************************************************************************************************/
    /** @fcn      init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
     *  @brief    x
     *  @details  x
     *
     *  @param    [in] (String?) nibNameOrNil - x
     *  @param    [in] (Bundle?) nibBundleOrNil - x
     */
    /********************************************************************************************************************************/
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        //Init Backups
        someVal_0 = -1;
        someStr_0 = "newStr";
        someVals  = [-1, -1, -1];
        someBlog  = Blog(blogName:"my blog");
        somePers  = Person(firstName: "Justin", lastName: "Reina");

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        //Init DataBackup
        DataBackup.storeViewController(self);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn      init?(coder aDecoder: NSCoder)
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
    
    
    /********************************************************************************************************************************/
    /** @fcn      viewDidLoad()
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        self.view.translatesAutoresizingMaskIntoConstraints = false;

        self.genUI();                   //generate fields for user input
        
        self.loadData();                //called AFTER UI init

        print("ViewController.viewDidLoad():       viewDidLoad() complete");
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn      genUI()
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
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
        
        
        //--------------------------------------------Apply Button------------------------------------------------------------------//
        let applyButton : UIButton = UIButton(type: UIButtonType.roundedRect);              /* save to backup                       */
        
        applyButton.setTitle("Apply",      for: UIControlState());
        applyButton.sizeToFit();
        applyButton.center = CGPoint(x: 65, y: 630);
        
        //actions
        applyButton.addTarget(self, action: #selector(ViewController.applyPressed(_:)), for:  .touchUpInside);
        
        //add
        self.view.addSubview(applyButton);

        
        //--------------------------------------------Retrieve Button---------------------------------------------------------------//
        let retrieveButton : UIButton = UIButton(type: UIButtonType.roundedRect);         /* update UI to reflect backup value      */
        
        retrieveButton.setTitle("Retrieve",      for: UIControlState());
        retrieveButton.sizeToFit();
        retrieveButton.center = CGPoint(x: 285, y: 630);
        
        //actions
        retrieveButton.addTarget(self, action: #selector(ViewController.retrievePressed(_:)), for:  .touchUpInside);
        
        //add
        self.view.addSubview(retrieveButton);

        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn      applyPressed()
     *  @brief    x
     *  @details  x
     *
     *  @section  Purpose
     *      x
     *
     *  @param    [in] (UIButton!) sender - x
     */
    /********************************************************************************************************************************/
    @objc func applyPressed(_ sender: UIButton!) {
        
        self.view.endEditing(true);
        sender.resignFirstResponder();
        
        self.saveData();
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn      retrievePressed()
     *  @brief    x
     *  @details  x
     *
     *  @param    [in] (UIButton!) sender - x
     */
    /********************************************************************************************************************************/
    @objc func retrievePressed(_ sender: UIButton!) {
        
        self.view.endEditing(true);
        sender.resignFirstResponder();
        
        self.loadData();
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn      saveData()
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    func saveData() {

        someVal_0 = Int(self.numField.text!)!;
        
        someStr_0 = self.nameField.text!;
        
        DataBackup.saveData();
        
        print("ViewController.saveData():    name save status is '\("?")'");

        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn      loadData()
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    func loadData() {

        DataBackup.loadData();
        
        print("ViewController.loadData():    load is complete");
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn      didReceiveMemoryWarning()
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        
        return;
    }
}

