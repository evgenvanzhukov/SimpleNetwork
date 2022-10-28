
import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var dataSource = [User]()
    

    @IBOutlet weak var tableView: UITableView!
    
    var netManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        netManager.getUsers { (result) in
            switch result {

            case .success(let users):
                DispatchQueue.main.async {
                    self.dataSource = users
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }

        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = dataSource[indexPath.row]
        cell.textLabel?.text = "\(user.userId). \(user.name)"
        cell.detailTextLabel?.text = "\(user.address.city) \(user.address.street)"
        return cell
    }
}

