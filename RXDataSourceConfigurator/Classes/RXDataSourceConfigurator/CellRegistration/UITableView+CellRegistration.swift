import UIKit
import ObjectiveC

public extension UITableView {
    
    static var associatedKey: NSString = "kTableViewRegistrationAssociatedKey"
    var setOfRegisteredClasses: NSMutableSet {
        var set = objc_getAssociatedObject(self, &UITableView.associatedKey) as? NSMutableSet
        if set == nil {
            set = NSMutableSet()
            objc_setAssociatedObject(self, &UITableView.associatedKey, set, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return set!
    }

    private func register(_ mClass: AnyClass, reuseIdentifier: String) {
        if !setOfRegisteredClasses.contains(reuseIdentifier) {
            setOfRegisteredClasses.add(reuseIdentifier)
            self.register(mClass, forCellReuseIdentifier: reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: AnyObject>(withClass mClass: T.Type, for indexPath: IndexPath, classSuffix: String? = nil) -> T {
        let reuseIdentifier = NSStringFromClass(mClass) + (classSuffix ?? "")
        register(mClass, reuseIdentifier: reuseIdentifier)
        return (self.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T)!
    }

    private func registerHeaderFooterViewClass(_ mClass: AnyClass) {
        let name = String(format: "HeaderFooter:%@", NSStringFromClass(mClass))
        if !setOfRegisteredClasses.contains(name) {
            setOfRegisteredClasses.add(name)
            self.register(mClass, forHeaderFooterViewReuseIdentifier: name)
        }
    }

    func dequeueReusableHeaderFooterView(withClass mClass: AnyClass) -> UITableViewHeaderFooterView? {
        registerHeaderFooterViewClass(mClass)
        return self.dequeueReusableHeaderFooterView(withIdentifier: String(format: "HeaderFooter:%@", NSStringFromClass(mClass)))
    }
}
