/************************************************************************************************************************************/
/** @file       Blog.swift
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
import UIKit


class Blog : NSObject, NSCoding {
    
    var blogName: String
    
    
    /********************************************************************************************************************************/
    /** @fcn        init(blogName: String)
     *  @brief      designated initializer
     *  @details    ensures you'll never create a Blog object without giving it a name unless you would need that for some reason?
     *  @note       I would not override the init method of NSObject
     */
    /********************************************************************************************************************************/
    init(blogName: String) {
        self.blogName = blogName;
        
        super.init();        // call NSObject's init method
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn      func encode(with aCoder: NSCoder)
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    func encode(with aCoder: NSCoder) {
        aCoder.encode(blogName, forKey: "blogName");
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn      func encodeWithCoder(aCoder: NSCoder)
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encode(blogName, forKey: "blogName");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn      required convenience init?(coder aDecoder: NSCoder)
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    required convenience init?(coder aDecoder: NSCoder) {
        // decoding could fail, for example when no Blog was saved before calling decode
        guard let unarchivedBlogName = aDecoder.decodeObject(forKey: "blogName") as? String
            else {
                // option 1 : return an default Blog
                self.init(blogName: "unnamed");
                return;
                
                // option 2 : return nil, and handle the error at higher level
        }
        
        // convenience init must call the designated init
        self.init(blogName: unarchivedBlogName);
    }
}
