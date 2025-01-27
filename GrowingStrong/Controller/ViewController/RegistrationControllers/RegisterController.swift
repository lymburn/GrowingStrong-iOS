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
        hideKeyboardWhenTappedAround()
        
        collectionView.register(RegisterStatsCell.self, forCellWithReuseIdentifier: registerStatsCellId)
        collectionView.register(CreateAccountCell.self, forCellWithReuseIdentifier: createAccountCellId)
        
        navigationItem.rightBarButtonItem = nextButton
        navigationItem.leftBarButtonItem = backButton
        
        
        let userNetworkManager = UserNetworkManager(persistentContainer: CoreDataManager.shared.persistentContainer,
                                                    managedObjectContext: CoreDataManager.shared.backgroundContext)
        let registrationNetworkHelper = RegistrationNetworkHelper(userNetworkManager: userNetworkManager, jwtTokenKey: KeyChainKeys.jwtToken)
        
        setupDependencies(registrationNetworkHelper: registrationNetworkHelper)
    }
    
    let registerStatsCellId = "registerStatsCell"
    let createAccountCellId = "createAccountCell"
    
    lazy var nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextPageTapped))
    lazy var backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
    lazy var submitButton = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitTapped))
    
    var registrationNetworkHelper: RegistrationNetworkHelperType!
    
    var userAccountInfo: UserAccountInfo?
    var userProfileAndTargetsInfo: UserProfileAndTargetsInfo?
    
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
        picker.preferredDatePickerStyle = .wheels
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
    
    fileprivate func setRegisterStatsHeightLabel(height: Double) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        let heightRounded = Int(height.rounded())
        let heightString = "Height: \(heightRounded) cm"
        cell.heightLabel.colorString(text: heightString, coloredText: "\(heightRounded) cm", color: .systemBlue)
    }
    
    fileprivate func setRegisterStatsWeightLabel(weight: Double) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        let weightRounded = Int(weight.rounded())
        let weightString = "Weight: \(weightRounded) kg"
        cell.weightLabel.colorString(text: weightString, coloredText: "\(weightRounded) kg", color: .systemBlue)
    }
    
    fileprivate func setRegisterStatsWeightGoalLabel(for goal: WeightGoal) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        cell.goalLabel.colorString(text: "I want to \(goal.rawValue.lowercased()) weight", coloredText: goal.rawValue.lowercased(), color: .systemBlue)
    }
    
    fileprivate func setRegisterStatsActivityLevelLabel(for level: ActivityLevel) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        cell.activityLevelLabel.colorString(text: "My activity level is \(level.rawValue.lowercased())", coloredText: level.rawValue.lowercased(), color: .systemBlue)
    }
    
    fileprivate func navigateToMainPage() {
        DispatchQueue.main.async {
            let mainController = MainTabBarController()
            mainController.modalPresentationStyle = .fullScreen
            self.present(mainController, animated: true)
        }
    }
    
    fileprivate func setUserProfileAndTargetsInfo() {
        let indexPath = IndexPath(item: 0, section: 0)
        let registerStatsCell = collectionView.cellForItem(at: indexPath) as? RegisterStatsCell
        
        if let registerStatsCell = registerStatsCell {
            let birthDate = datePicker.date
            let sex = registerStatsCell.genderSelector.selectedSegmentIndex == 0 ? Gender.male.rawValue : Gender.female.rawValue
            let height = registerStatsCell.heightSlider.value
            let weight = registerStatsCell.weightSlider.value
            
            let activityLevelSelector = registerStatsCell.activityLevelSelector
            var activityLevel: String
            if activityLevelSelector.selectedSegmentIndex == 0 {
                activityLevel = ActivityLevel.sedentary.rawValue
            } else if activityLevelSelector.selectedSegmentIndex == 1 {
                activityLevel = ActivityLevel.light.rawValue
            } else if activityLevelSelector.selectedSegmentIndex == 2 {
                activityLevel = ActivityLevel.moderate.rawValue
            } else {
                activityLevel = ActivityLevel.extreme.rawValue
            }
            
            let goalSelector = registerStatsCell.goalSelector
            var weightGoalTimeline: String
            if goalSelector.selectedSegmentIndex == 0 {
                weightGoalTimeline = getWeightGoalTimeline(from: .gain).rawValue
            } else if goalSelector.selectedSegmentIndex == 1 {
                weightGoalTimeline = getWeightGoalTimeline(from: .maintain).rawValue
            } else {
                weightGoalTimeline = getWeightGoalTimeline(from: .lose).rawValue
            }
            
            userProfileAndTargetsInfo = UserProfileAndTargetsInfo(birthDate: birthDate, sex: sex, height: height, weight: weight, activityLevel: activityLevel, weightGoalTimeline: weightGoalTimeline)
        }
    }
    
    fileprivate func setUserAccountInfo() {
        let indexPath = IndexPath(item: 1, section: 0)
        let createAccountCell = collectionView.cellForItem(at: indexPath) as? CreateAccountCell
        
        if let createAccountCell = createAccountCell {
            let email = createAccountCell.emailTextField.text!
            let password = createAccountCell.passwordTextField.text!
            
            userAccountInfo = UserAccountInfo(email: email, password: password)
        }
    }
    
    fileprivate func passwordsMatch() -> Bool {
        let indexPath = IndexPath(item: 1, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! CreateAccountCell
        let password = cell.passwordTextField.text!
        let confirmPassword = cell.confirmPasswordTextField.text!
        return password == confirmPassword
    }
    
    fileprivate func getWeightGoalTimeline(from weightGoal: WeightGoal) -> WeightGoalTimeline {
        if weightGoal == .gain {
            return .gainWeightWithSmallSurplus
        } else if weightGoal == .maintain {
            return .maintainWeight
        } else {
            return .loseWeightWithSmallDeficit
        }
    }
    
    fileprivate func createRegisterRequest() -> RegisterRequest? {
        if let userAccountInfo = userAccountInfo, let userProfileAndTargetsInfo = userProfileAndTargetsInfo {
            let request = RegisterRequest(userAccountInfo: userAccountInfo, userProfileAndTargetsInfo: userProfileAndTargetsInfo)
            return request
        }

        return nil
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
                saveUserIdToUserDefaults(userId: userId)
                self.navigateToMainPage()
            }
            
        }
    }
    
    fileprivate func saveUserIdToUserDefaults(userId: Int) {
        UserDefaults.standard.set(userId, forKey: UserDefaultsKeys.currentUserIdKey)
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
        setUserProfileAndTargetsInfo()
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
        //TODO: Handle unmatched password
        if !passwordsMatch() {
            print ("Passwords do not match")
        } else {
            setUserAccountInfo()
            if let request = createRegisterRequest() {
                registrationNetworkHelper.register(registerRequest: request) { response, userId in
                    self.handleRegisterResponse(response, userId)
                }
            }
        }
    }
}

//MARK: Register data controller delegate
extension RegisterController : RegisterDataControllerDelegate {
    func heightValueDidChange(to height: Double) {
        setRegisterStatsHeightLabel(height: height)
    }
    
    func weightValueDidChange(to weight: Double) {
        setRegisterStatsWeightLabel(weight: weight)
    }
    
    func weightGoalDidChange(to goal: WeightGoal) {
        setRegisterStatsWeightGoalLabel(for: goal)
    }
    
    func birthdayFieldSelected() {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        cell.birthdayTextField.inputView = datePicker
        cell.birthdayTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func activityLevelDidChange(to level: ActivityLevel) {
        setRegisterStatsActivityLevelLabel(for: level)
    }
}
