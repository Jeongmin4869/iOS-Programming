import UIKit

class ManagingGroupViewController: UITableViewController, DatabaseDelegate, saveGNameDelegate{
    
    var databaseBroker : DatabaseBroker!
    var addGroupName: String!
    var groupDatabase: [String]!
    
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBOutlet weak var plusBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        databaseBroker = DatabaseObject.createDatabase(rootPath: "test")
        databaseBroker.setGroupDataDelegate(dataDelegate: self)
        
        groupDatabase = databaseBroker.loadGroupDatabase()
        
        setEditing(true, animated: true)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupDatabase.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "GroupCell")
        let group = groupDatabase[indexPath.row]
        cell.textLabel?.text = group
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            groupDatabase.remove(at: indexPath.row)
            databaseBroker.saveGroupDatabase(groupDatabase: groupDatabase)
        }
    }
    
    func onChange(groupDatabaseStr: String) {
        groupDatabase = databaseBroker.loadGroupDatabase()
        tableView.reloadData()
    }

    
    func dataSend(data: String){
        print(data)
        addGroupName = data
        groupDatabase.append(data)
        databaseBroker.saveGroupDatabase(groupDatabase: groupDatabase)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if segue.identifier == "AddGroup"{
        guard let viewController: AddGroupVC = segue.destination as? AddGroupVC else {return}
        viewController.delegate = self
    }
    
    
}
