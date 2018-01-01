/************************************************************************************************************************************/
/** @file       Blog.swift
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
import UIKit


class Blog : NSObject, NSCoding {
    
    var blogName: String
    
    
    
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
    // designated initializer
    //
    // ensures you'll never create a Blog object without giving it a name
    // unless you would need that for some reason?
    //
    // also : I would not override the init method of NSObject
    init(blogName: String) {
        self.blogName = blogName
        
        super.init()        // call NSObject's init method
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
        aCoder.encode(blogName, forKey: "blogName");
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
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encode(blogName, forKey: "blogName")
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
    required convenience init?(coder aDecoder: NSCoder) {
        // decoding could fail, for example when no Blog was saved before calling decode
        guard let unarchivedBlogName = aDecoder.decodeObject(forKey: "blogName") as? String
            else {
                // option 1 : return an default Blog
                self.init(blogName: "unnamed")
                return
                
                // option 2 : return nil, and handle the error at higher level
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
        // convenience init must call the designated init
        self.init(blogName: unarchivedBlogName)
    }
}
