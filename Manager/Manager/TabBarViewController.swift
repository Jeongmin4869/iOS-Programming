import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let managingGroupVC = ManagingGroupViewController()
        
        print("....")
        
        managingGroupVC.title = "Group"
        
        
    }
    
}
