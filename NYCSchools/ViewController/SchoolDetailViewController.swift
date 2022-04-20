//
//  SchoolDetailViewController.swift
//  NYCSchools
//

import UIKit
import MapKit

class SchoolDetailViewController: UIViewController {
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var satView: UIView!
    @IBOutlet weak var mathLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    @IBOutlet weak var totalTestTakers: UILabel!
    @IBOutlet weak var totalStudentsLabel: UILabel!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var websiteImage: UIImageView!
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    
    var satScores: [SatScores]? = [SatScores]()
    var school: School?
    var selectedSchoolSatScores: SatScores?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        getScores()
        satView.cardView()
        totalView.cardView()
        contactView.cardView()
        displaySchoolInfo()
        displayMap()
        tapEmail()
        tapWebsite()
        tapPhone()
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func getScores() {
        
        NetworkManager().fetchData(url: Environment.satResultURL) { [weak self] (response: [SatScores]?) in
            
            if response == nil {
                print("Error in getting the SAT scores")
                return
            }
            
            self?.satScores = response
            
            if let scores = self?.satScores?.first(where: { $0.dbn == self?.school?.dbn }) {
                print("School Found = \(String(describing: self?.school?.schoolName))")
                self?.displayScores(totalTestTakers: scores.totalTestTakers, math: scores.math, reading: scores.reading, writing: scores.writing)
            }
        }
    }
    
    private func displaySchoolInfo() {
        DispatchQueue.main.async { [weak self] in
            self?.schoolNameLabel.text = self?.school?.schoolName
            self?.totalStudentsLabel.text = self?.school?.totalStudents
            self?.locationLabel.text = self?.school?.location
        }
    }
    
    private func displayScores(totalTestTakers: String?, math: String?, reading: String?, writing: String?) {
        
        DispatchQueue.main.async { [weak self] in
            self?.totalTestTakers.text = totalTestTakers
            self?.mathLabel.text = math
            self?.readingLabel.text = reading
            self?.writingLabel.text = writing
        }
    }

    private func displayMap() {
        
        guard let latitude = Double(school?.latitude ?? "0"), let longitude = Double(school?.longitude ?? "0") else {
            return
        }

        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = self.school?.schoolName
        mapView.addAnnotation(annotation)
    }
    
    private func tapEmail() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openEmail(_:)))
        emailImage.isUserInteractionEnabled = true
        emailImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func openEmail(_ sender: AnyObject) {
        Utility.open(scheme: "mailto", string: "mailto:\(self.school?.email ?? "")".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), contoller: self)
    }
    
    private func tapWebsite() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openWebsite(_:)))
        websiteImage.isUserInteractionEnabled = true
        websiteImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func openWebsite(_ sender: AnyObject) {
        Utility.open(scheme: "https", string: self.school?.website, contoller: self)
    }
    
    private func tapPhone() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dialPhone(_:)))
        phoneImage.isUserInteractionEnabled = true
        phoneImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func dialPhone(_ sender: AnyObject) {
        Utility.open(scheme: "telprompt", string: self.school?.phone, contoller: self)
    }
}

