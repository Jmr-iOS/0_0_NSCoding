import UIKit


class Blog : NSObject, NSCoding {
    
    var blogName: String
    
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

    func encode(with aCoder: NSCoder) {
        aCoder.encode(blogName, forKey: "blogName");
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encode(blogName, forKey: "blogName")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // decoding could fail, for example when no Blog was saved before calling decode
        guard let unarchivedBlogName = aDecoder.decodeObject(forKey: "blogName") as? String
            else {
                // option 1 : return an default Blog
                self.init(blogName: "unnamed")
                return
                
                // option 2 : return nil, and handle the error at higher level
        }
        
        // convenience init must call the designated init
        self.init(blogName: unarchivedBlogName)
    }
}
