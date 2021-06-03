import UIKit
import ObjectiveC

public extension UICollectionView {
    
    func dequeueReusableCell<T: AnyObject>(withClass mClass: T.Type, for indexPath: IndexPath, classSuffix: String? = nil) -> T {
        let reuseIdentifier = NSStringFromClass(mClass) + (classSuffix ?? "")
        register(mClass, reuseIdentifier: reuseIdentifier)
        return (self.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T)!
    }
    
    func dequeueReusableSupplementaryView(
        withClass mClass: AnyClass,
        ofKind kind: String,
        for indexPath: IndexPath
    ) -> UICollectionReusableView? {
        let reuseIdentifier = "SupplementaryView:\(NSStringFromClass(mClass))"
        register(viewClass: mClass, for: kind, with: reuseIdentifier)        
        return self.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        )
    }
    
}

private extension UICollectionView {
    
    static var associatedKey: NSString = "kCollectionViewRegistrationAssociatedKey"
    var setOfRegisteredClasses: NSMutableSet {
        var set = objc_getAssociatedObject(self, &UICollectionView.associatedKey) as? NSMutableSet
        if set == nil {
            set = NSMutableSet()
            objc_setAssociatedObject(self, &UICollectionView.associatedKey, set, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return set!
    }

    func register(_ mClass: AnyClass, reuseIdentifier: String) {
        if !setOfRegisteredClasses.contains(reuseIdentifier) {
            setOfRegisteredClasses.add(reuseIdentifier)
            self.register(mClass, forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
    
    func register(viewClass: AnyClass, for kind: String, with reuseIdentifier: String) {
        if !setOfRegisteredClasses.contains(reuseIdentifier) {
            setOfRegisteredClasses.add(reuseIdentifier)
            self.register(viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseIdentifier)
        }
    }

}
