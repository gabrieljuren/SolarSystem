//
//  ViewController.swift
//  PlanetsApp
//
//  Created by Gabriel Juren on 03/12/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var planets = [Planets]()
    var arroundPlanetArray = [AroundPlanetArr]()
    var planesResult = [Planets]()
    var moons = [Planets]() // moon planets
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1.0)
        return table
    }()
    
    private lazy var actInd: UIActivityIndicatorView = {
        let actvityIndicator =  UIActivityIndicatorView(style: .medium)
        actvityIndicator.color = .white
        return actvityIndicator
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        actInd.startAnimating()
        getAllPlanets()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "space-background")!)
        overrideUserInterfaceStyle = .dark
        view.addSubview(tableView)
        view.addSubview(actInd)
        setLayout()
    }
    
    func setLayout() {
        actInd.translatesAutoresizingMaskIntoConstraints = false
        actInd.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        actInd.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return planets.count
        }
        
        return moons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        cell.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1.0)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = planets[indexPath.row].englishName
        } else if indexPath.section == 1 {
            cell.textLabel?.text = moons[indexPath.row].englishName
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let planetOrMoon: Planets = indexPath.section == 0 ? planets[indexPath.row] : moons[indexPath.row]
        
        let detailPlanetView = DetailPlanetView(englishName: planetOrMoon.englishName,
                                                discoveredBy: planetOrMoon.discoveredBy,
                                                discoveredDate: planetOrMoon.discoveryDate,
                                                gravity: planetOrMoon.gravity,
                                                isPlanet: planetOrMoon.isPlanet)
        
        self.present(UINavigationController(rootViewController: detailPlanetView), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Planets"
        }
        
        return "Moons"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    struct AroundPlanetArr: Codable {
        let planet: String?
        let rel: String?
    }
    
    func getAllPlanets() {
        URLSession.shared.dataTask(with: URL(string: "https://api.le-systeme-solaire.net/rest/bodies/")!, completionHandler: {data, response, error in
            guard let data = data else {
                return
            }
            
            var result: PlanetResult?
            do {
                result = try JSONDecoder().decode(PlanetResult.self, from: data)
            }
            catch {
                print(error)
            }
            
            guard let finalResult = result else {
                return
            }
            
            self.planesResult.append(contentsOf: finalResult.bodies)
            
            self.planets = self.planesResult.filter{ (planet: Planets)  -> Bool in
                return planet.isPlanet
            }
            
            self.moons = self.planesResult.filter{ (moon: Planets) -> Bool in
                return !moon.isPlanet
            }
            
            DispatchQueue.main.async {
                print(self.moons.count)
                self.tableView.reloadData()
                self.actInd.stopAnimating()
            }
            
        }).resume()
    }
    
    struct PlanetResult: Decodable {
        let bodies: [Planets]
    }
    
    struct Planets: Codable {
        let id: String?
        let name: String?
        let englishName: String?
        let isPlanet: Bool
        let semimajorAxis: Float?
        let perihelion: Int?
        let aphelion: Int?
        let eccentricity: Float?
        let inclination: Float?
        let density: Float?
        let gravity: Float?
        let escape: Float?
        let meanRadius: Float?
        let equaRadius: Float?
        let polarRadius: Float?
        let flattening: Float?
        let dimension: String?
        let sideralOrbit: Float?
        let sideralRotation: Float?
        let discoveredBy: String?
        let discoveryDate: String?
        let alternativeName: String?
        let axialTilt: Float?
        let avgTemp: Float?
        let mainAnomaly: Float?
        let argPeriapsis: Float?
        let longAscNode: Float?
        let rel: String?
    }
}

