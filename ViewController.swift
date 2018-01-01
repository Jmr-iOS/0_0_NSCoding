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
    
    //Array
    var arrayFields : [UITextField] = [UITextField]();
    
    //@todo     Blog

    //@todo     Struct

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
        someVals  = [0, 1, 2, 3];
        someBlog  = Blog(blogName:"my blog");
        somePers  = Person(firstName: "Justin", lastName: "Reina");
        
        //Init UI
        for i in 0...(someVals.count-1) {
            arrayFields.append(UITextField(frame:CGRect(x: (20 + (i*80)), y: 200, width: 50, height: 40)));
        }

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

        self.genUI();                                       /* generate fields for user input                                       */
        
        self.loadData();                                    /* called AFTER UI init                                                 */

        print("ViewController.viewDidLoad():       viewDidLoad() complete");
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn      genUI()
     *  @brief    x
     *  @details  x
     *
     *  @section    Opens
     *      Cleanup and complete italic headers
     *      Bring italic and bold fonts to UIText demo, bring subroutine helpers to Lib
     */
    /********************************************************************************************************************************/
    @objc func genUI() {
        
        //------------------------------------------------String--------------------------------------------------------------------//
        //String Label
        let nameLabel : UILabel = UILabel(frame: CGRect(x: 20, y: 30, width: 300, height: 40));
        nameLabel.font = FontUtils.italic();
        print(nameLabel.font.fontName);

        nameLabel.textColor = UIColor.darkGray;
        nameLabel.text = "String";
        
        //myName string
        nameField = UITextField(frame: CGRect(x: 20, y: 60, width: 300, height: 40));
        nameField.placeholder = "enter myName here";
        nameField.keyboardType = .default;
        nameField.borderStyle = UITextBorderStyle.roundedRect;
        nameField.delegate = self;
        
        view.addSubview(nameLabel);
        view.addSubview(self.nameField);

        
        //------------------------------------------------Int-----------------------------------------------------------------------//
        //Int Label
        let textLabel : UILabel = UILabel(frame: CGRect(x: 20, y: 95, width: 300, height: 40));
        textLabel.font = FontUtils.italic();
        textLabel.textColor = UIColor.darkGray;
        textLabel.text = "Int";

        //myNum num
        numField = UITextField(frame: CGRect(x: 20, y: 125, width: 300, height: 40));
        numField.placeholder = "enter myNum here";
        numField.keyboardType = .decimalPad;
        numField.borderStyle = UITextBorderStyle.roundedRect;
        numField.delegate = self;
        
        view.addSubview(textLabel);
        view.addSubview(self.numField);
        
        //------------------------------------------Array([Int])--------------------------------------------------------------------//
        //Int Label
        let arrayLabel : UILabel = UILabel(frame: CGRect(x: 20, y: 165, width: 300, height: 40));
        arrayLabel.font = FontUtils.italic();
        arrayLabel.textColor = UIColor.darkGray;
        arrayLabel.text = "Array(Int)";
        
        for i in 0...(someVals.count-1) {
            arrayFields[i].text = "\(someVals[i])";
            arrayFields[i].textAlignment = .center;
            arrayFields[i].keyboardType = .decimalPad;
            arrayFields[i].borderStyle = UITextBorderStyle.roundedRect;
            arrayFields[i].delegate = self;
        }
        
        //Add to view
        view.addSubview(arrayLabel);
        for i in 0...(someVals.count-1) {
            view.addSubview(arrayFields[i]);
        }
        
        
        //--------------------------------------------Apply Button------------------------------------------------------------------//
        let applyButton : UIButton = UIButton(type: UIButtonType.roundedRect);              /* save to backup                       */
        
        applyButton.setTitle("Apply",      for: UIControlState());
        applyButton.sizeToFit();
        applyButton.center = CGPoint(x: 65, y: 630);
        
        //actions
        applyButton.addTarget(self, action: #selector(ViewController.applyPressed(_:)), for:  .touchUpInside);
        
        //add
        self.view.addSubview(applyButton);

        
        //---------------------------------------------Clear Button-----------------------------------------------------------------//
        let clearButton : UIButton = UIButton(type: UIButtonType.roundedRect);          /* update UI to reflect backup value        */
        
        clearButton.setTitle("Clear",      for: UIControlState());
        clearButton.sizeToFit();
        clearButton.center = CGPoint(x: 170, y: 630);
        
        //actions
        clearButton.addTarget(self, action: #selector(ViewController.clearPressed(_:)), for:  .touchUpInside);
        
        //add
        self.view.addSubview(clearButton);
        
        
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
    /** @fcn      clearPressed()
     *  @brief    x
     *  @details  x
     *
     *  @param    [in] (UIButton!) sender - x
     */
    /********************************************************************************************************************************/
    @objc func clearPressed(_ sender: UIButton!) {
        
        self.view.endEditing(true);
        sender.resignFirstResponder();
        
        self.clearFields();
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn      saveData()
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    func saveData() {

        //Grab UI values
        someVal_0 = Int(self.numField.text!)!;
        
        someStr_0 = self.nameField.text!;

        print("I found \(someVals.count), \(arrayFields.count)");
        
        for i in 0...(arrayFields.count-1) {
            if(arrayFields[i].text != nil) {
                someVals[i] = Int(arrayFields[i].text!)!;
            } else {
                someVals[i] = 0;                                        /* empty field case, promote to '0'                         */
            }
        }
        
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
        
        print("ViewController.loadData():          load is complete");
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn      clearFields()
     *  @brief    clear contents of all fields
     *  @details  x
     */
    /********************************************************************************************************************************/
    func clearFields() {

        //String
        nameField.text = "";
        
        //Int
        numField.text = "";
        
        //Array
        for i in 0...(arrayFields.count-1) {
            arrayFields[i].text = "";
        }
        
        print("ViewController.clearFields():          fields were cleared");
        
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

