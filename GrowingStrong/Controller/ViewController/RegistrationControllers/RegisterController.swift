//
//  File.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-11.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit
import CoreData

class RegisterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        collectionView.register(RegisterStatsCell.self, forCellWithReuseIdentifier: registerStatsCellId)
        collectionView.register(CreateAccountCell.self, forCellWithReuseIdentifier: createAccountCellId)
        
        navigationItem.rightBarButtonItem = nextButton
        navigationItem.leftBarButtonItem = backButton
        
        
        let userNetworkManager = UserNetworkManager(persistentContainer: CoreDataManager.shared.persistentContainer)
        let registrationNetworkHelper = RegistrationNetworkHelper(userNetworkManager: userNetworkManager, jwtTokenKey: KeyChainKeys.jwtToken)
        
        setupDependencies(registrationNetworkHelper: registrationNetworkHelper)
    }
    
    let registerStatsCellId = "registerStatsCell"
    let createAccountCellId = "createAccountCell"
    lazy var nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextPageTapped))
    lazy var backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
    lazy var submitButton = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitTapped))
    
    var registrationNetworkHelper: RegistrationNetworkHelperType!
    
    lazy var dataController: RegisterDataController = {
        let dataController = RegisterDataController(registerStatsCellId: registerStatsCellId,
                                                    createAccountCellId: createAccountCellId,
                                                    dateFormatter: dateFormatter)
        dataController.delegate = self
        return dataController
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = dataController
        cv.delegate = dataController
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .white
        return cv
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.date = Date()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(dateValueChanged), for: .valueChanged)
        return picker
    }()
    
    lazy var dateFormatter: DateFormatter = DateFormatterHelper.generateDateFormatter(withFormat: DateFormatConstants.longMonthDefault)
}

//MARK: Setup
extension RegisterController {
    func setupDependencies(registrationNetworkHelper: RegistrationNetworkHelperType) {
        
        self.registrationNetworkHelper = registrationNetworkHelper
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: Helpers
extension RegisterController {
    fileprivate func changeMeasurementUnit(to unit: MeasurementUnit) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        let heightInCm: Double = Double(cell.heightSlider.value)
        let weightInKg: Double = Double(cell.weightSlider.value)
        
        setRegisterStatsHeightLabel(heightInCm: heightInCm, unit: unit)
        setRegisterStatsWeightLabel(weightInKg: weightInKg, unit: unit)
    }
    
    fileprivate func setRegisterStatsHeightLabel(heightInCm: Double, unit: MeasurementUnit) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        if unit == .imperial {
            let feetInches: String = MeasurementUnitHelper.centimetersToFeetInches(heightInCm)
            let imperialHeightString = "Height: \(feetInches)"
            cell.heightLabel.colorString(text: imperialHeightString, coloredText: feetInches, color: .green)
        } else {
            let heightRounded = Int(heightInCm.rounded())
            let metricHeightString = "Height: \(heightRounded) cm"
            cell.heightLabel.colorString(text: metricHeightString, coloredText: "\(heightRounded) cm", color: .green)
        }
    }
    
    fileprivate func setRegisterStatsWeightLabel(weightInKg: Double, unit: MeasurementUnit) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        if unit == .imperial {
            let imperialWeight: Double = MeasurementUnitHelper.kilogramsToPounds(weightInKg)
            let weightRounded = Int(imperialWeight.rounded())
            let imperialWeightString = "Weight: \(weightRounded) lbs"
            cell.weightLabel.colorString(text: imperialWeightString, coloredText: "\(weightRounded) lbs", color: .green)
        } else {
            let metricWeight = Int(weightInKg.rounded())
            let metricWeightString = "Weight: \(metricWeight) kg"
            cell.weightLabel.colorString(text: metricWeightString, coloredText: "\(metricWeight) kg", color: .green)
        }
    }
    
    fileprivate func setRegisterStatsWeightGoalLabel(for goal: WeightGoal) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        cell.goalLabel.colorString(text: "I want to \(goal.rawValue.lowercased()) weight", coloredText: goal.rawValue.lowercased(), color: .green)
    }
    
    fileprivate func setRegisterStatsActivityLevelLabel(for level: ActivityLevel) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        cell.activityLevelLabel.colorString(text: "My activity level is \(level.rawValue.lowercased())", coloredText: level.rawValue.lowercased(), color: .green)
    }
    
    fileprivate func navigateToMainPage() {
        DispatchQueue.main.async {
            let mainController = MainTabBarController()
            mainController.modalPresentationStyle = .fullScreen
            self.present(mainController, animated: true)
        }
    }
    
    fileprivate func passwordsMatch() -> Bool {
        let indexPath = IndexPath(item: 1, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! CreateAccountCell
        let password = cell.passwordTextField.text!
        let confirmPassword = cell.confirmPasswordTextField.text!
        
        return password == confirmPassword
    }
    
    fileprivate func handleRegisterResponse(_ response: RegistrationNetworkHelperResponse,
                                            _ user: User?) {
        
        switch response {
        case .invalidEmailFormat:
            print ("Invalid email format")
        case .invalidPasswordFormat:
            print ("Invalid password format")
        case .userAlreadyExists:
            print ("Email address taken")
        case .networkError:
            print ("Network error")
        case .savingTokenError:
            print ("Error saving token")
        case .success:
            if let user = user {
                let userId = Int(user.userId)
                self.createUser(userId: userId, emailAddress: user.emailAddress)
                self.navigateToMainPage()
            }
            
        }
    }
    
    fileprivate func createUser(userId: Int, emailAddress: String) {
        UserDataManager.createUser(userId: userId, emailAddress: emailAddress)
    }
}

//MARK: Events
extension RegisterController {
    @objc func dateValueChanged() {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        cell.birthdayTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func nextPageTapped() {
        let indexPath = IndexPath(item: 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        navigationItem.rightBarButtonItem = submitButton
    }
    
    @objc func backTapped() {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        
        if let indexPath = visibleIndexPath {
            if indexPath.item == 0 {
                navigationController?.popViewController(animated: true)
            } else {
                let registerStatsIndexPath = IndexPath(item: 0, section: 0)
                collectionView.scrollToItem(at: registerStatsIndexPath, at: .left, animated: true)
                navigationItem.rightBarButtonItem = nextButton
            }
        }
    }
    
    @objc func submitTapped() {
        //TODO:
        let indexPath = IndexPath(item: 1, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! CreateAccountCell
        let email = cell.emailTextField.text!
        let password = cell.passwordTextField.text!
        
        if !passwordsMatch() {
            print ("Passwords do not match")
        } else {
            registrationNetworkHelper.register(email: email, password: password) { response, userId in
                self.handleRegisterResponse(response, userId)
            }
        }
    }
}

//MARK: Register data controller delegate
extension RegisterController : RegisterDataControllerDelegate {
    func measurementUnitDidChange(to unit: MeasurementUnit) {
        changeMeasurementUnit(to: unit)
    }
    
    func heightValueDidChange(to heightInCm: Double, unit: MeasurementUnit) {
        setRegisterStatsHeightLabel(heightInCm: heightInCm, unit: unit)
    }
    
    func weightValueDidChange(to weightInKg: Double, unit: MeasurementUnit) {
        setRegisterStatsWeightLabel(weightInKg: weightInKg, unit: unit)
    }
    
    func weightGoalDidChange(to goal: WeightGoal) {
        setRegisterStatsWeightGoalLabel(for: goal)
    }
    
    func birthdayFieldSelected() {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        cell.birthdayTextField.inputView = UIView()
        cell.birthdayTextField.inputAccessoryView = datePicker
        cell.birthdayTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func activityLevelDidChange(to level: ActivityLevel) {
        setRegisterStatsActivityLevelLabel(for: level)
    }
}
