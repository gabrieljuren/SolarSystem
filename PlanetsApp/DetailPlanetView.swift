//
//  DetailPlanetView.swift
//  PlanetsApp
//
//  Created by Gabriel Juren on 04/12/21.
//

import Foundation
import UIKit

class DetailPlanetView : UIViewController {
    
    private var EnglishName: String = ""
    private var DiscoveredBy: String? = ""
    private var DiscoveredDate: String? = ""
    private var Gravity: Float = 0.0
    private var IsPlanet: Bool = true
    
    init (englishName: String?, discoveredBy: String?, discoveredDate: String?, gravity: Float?, isPlanet: Bool) {
        self.EnglishName = englishName!
        self.DiscoveredBy = discoveredBy!
        self.DiscoveredDate = discoveredDate!
        self.Gravity = gravity!
        self.IsPlanet = isPlanet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private lazy var discoveredByStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private lazy var labelDiscoveredBy: UILabel = {
        let label = UILabel()
        label.text = "Discovered by"
        label.textColor = .white
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var labelDiscoveredByValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "", size: 15.0)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var discoveredDateStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private lazy var labelGravity: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var labelGravityValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "", size: 15.0)
        label.textColor = .white
        return label
    }()
    
    private lazy var gravityStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private lazy var labelDiscovereDate: UILabel = {
        let label = UILabel()
        label.text = "Discovered Date"
        label.textColor = .white
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var labelDiscoveredDateValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "", size: 15.0)
        label.textColor = .white
        return label
    }()
    
    private lazy var stackHeader: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = UIColor(patternImage: UIImage(named: "galaxy2")!)
        return stack
    }()
    
    private lazy var lablePlanetName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"Times New Roman", size: 50)
        return label
    }()
    
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.text = "Planet Info"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 22.0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1.0)
        view.addSubview(stackHeader)
        stackHeader.addArrangedSubview(lablePlanetName)
        
        view.addSubview(discoveredByStack)
        discoveredByStack.addArrangedSubview(labelDiscoveredBy)
        discoveredByStack.addArrangedSubview(labelDiscoveredByValue)
        
        view.addSubview(discoveredDateStack)
        discoveredDateStack.addArrangedSubview(labelDiscovereDate)
        discoveredDateStack.addArrangedSubview(labelDiscoveredDateValue)
        
        view.addSubview(gravityStack)
        gravityStack.addArrangedSubview(labelGravity)
        gravityStack.addArrangedSubview(labelGravityValue)
        
        setLayout()
    }
    
    func setLayout() {
        stackHeader.translatesAutoresizingMaskIntoConstraints = false
        stackHeader.heightAnchor.constraint(equalToConstant: 300).isActive = true
        stackHeader.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        discoveredDateStack.axis = .vertical
        discoveredDateStack.spacing = 10
        discoveredDateStack.translatesAutoresizingMaskIntoConstraints = false
        discoveredDateStack.topAnchor.constraint(equalTo: gravityStack.bottomAnchor, constant: 20).isActive = true
        discoveredDateStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        discoveredDateStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        gravityStack.axis = .vertical
        gravityStack.spacing = 10
        gravityStack.translatesAutoresizingMaskIntoConstraints = false
        gravityStack.topAnchor.constraint(equalTo: stackHeader.bottomAnchor, constant: 50).isActive = true
        gravityStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        gravityStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        discoveredByStack.axis = .vertical
        discoveredByStack.spacing = 10
        discoveredByStack.translatesAutoresizingMaskIntoConstraints = false
        discoveredByStack.topAnchor.constraint(equalTo: discoveredDateStack.bottomAnchor, constant: 30).isActive = true
        discoveredByStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        discoveredByStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        labelGravity.text = IsPlanet ? "Planet Gravity" : "Moon Gravity"
        
        lablePlanetName.text = EnglishName
        labelDiscoveredByValue.text = DiscoveredBy == "" || DiscoveredBy == nil ? "God" : DiscoveredBy
        labelDiscoveredDateValue.text = DiscoveredDate == "" || DiscoveredDate == nil ? "Only God knows" : DiscoveredDate
        labelGravityValue.text = String(Gravity)
    }
}
