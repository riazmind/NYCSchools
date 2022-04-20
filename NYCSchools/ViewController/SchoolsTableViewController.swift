//
//  SchoolsTableViewController.swift
//  NYCSchools
//

import UIKit

class SchoolsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var schools: [School]? = [School]()
    var filteredSchools: [School]? = [School]()
    var selectedSchool: School?
    let spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Search the NYC school name"
        getSchools()
    }
    
    private func getSchools() {

        startSpinner()
        
        NetworkManager().fetchData(url: Environment.schoolDirectoryURL) { [weak self] (response: [School]?) in
            
            if response == nil {
                self?.stopSpinner()
                print("Error in getting the school names")
                return
            }
            
            self?.schools = response
            self?.filteredSchools = self?.schools
     
            DispatchQueue.main.async { [weak self] in
                self?.stopSpinner()
                self?.tableView.reloadData()
            }
        }
    }
    
    private func startSpinner() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.startAnimating()
            self?.tableView.backgroundView = self?.spinner
        }
    }
    
    private func stopSpinner() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.stopAnimating()
            self?.spinner.hidesWhenStopped = true
        }
    }

    // MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredSchools = searchText.isEmpty ? schools : schools?.filter({ (school: School) -> Bool in
            return school.schoolName?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredSchools?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(filteredSchools?.count ?? 0) NYC Schools"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSchool", for: indexPath)

        cell.textLabel?.text = filteredSchools?[indexPath.row].schoolName
        cell.detailTextLabel?.text = filteredSchools?[indexPath.row].overviewParagraph

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedSchool = schools?[indexPath.row]
        return indexPath
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "schoolDetailIdentifier" {
            guard let schoolDetailViewController = segue.destination as? SchoolDetailViewController else {
                return
            }
            schoolDetailViewController.school = selectedSchool
        }
    }
}
