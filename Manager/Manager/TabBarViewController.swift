import UIKit

class TabBarViewController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let managingGroupVC = ManagingGroupViewController()

        
        managingGroupVC.title = "Group"
        
        
    }
    
}
