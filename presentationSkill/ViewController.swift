//
//  ViewController.swift
//  presentationSkill
//
//  Created by Marilyn Martha Yusnita Devi Parhusip on 18/09/19.
//  Copyright © 2019 Apple Academy. All rights reserved.
//

import UIKit
import HealthKit
import LocalAuthentication

class ViewController: UIViewController {
    
//    @IBOutlet weak var heartRateLabel: UILabel!
    
    let myContext: LAContext = LAContext()
    
    

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var labelSatu: UILabel!
    @IBOutlet weak var labelDua: UILabel!
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var labelFaceID: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//
       
        
    }
    
    
    
    @IBAction func tapLogin(_ sender: UIButton) {
        
        labelSatu.isHidden = true
        labelDua.isHidden = true
        logoImage.isHidden = true
        
        if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            
            myContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Your Face ID") { (bener, error) in
                if bener{
                    
                    DispatchQueue.main.async{
                        print("Mantap")
                        self.performSegue(withIdentifier: "pindahView", sender: nil)
                    }
                    
                } else {
                    print("Salah")
                }
            }
            
        }
        
    }
    
    
    
    
    
//    func getHeartRateData() {
//
//        guard  let sampleHeartRateData = HKSampleType.quantityType(forIdentifier: .heartRate) else {
//
//            return
//        }
//
//        let startDate = Date.distantPast
//        let endDate = Date()
//
//        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
//
//        let limit = HKObjectQueryNoLimit
//
//        let sampleQueryHeartRate = HKSampleQuery(sampleType: sampleHeartRateData, predicate: predicate, limit: limit, sortDescriptors: nil) { (sampleQueryHeartRate, resultHeartRate, error) in
//
//            guard let samplesHeartRate = resultHeartRate as? [HKQuantitySample] else {return}
//
//            DispatchQueue.main.async {
//                for sampleHeartRate in samplesHeartRate {
//                    let heartRateUnit = HKUnit(from: "count/min")
//                    let heartRate = sampleHeartRate.quantity.doubleValue(for: heartRateUnit)
//                    print("Heart Rate: \(heartRate)")
//                }
//            }
//        }
//
//        healthStore.execute(sampleQueryHeartRate)
//    }
//
//
//    func getHeartRateVariabilityData() {
//
//        guard  let sampleHeartRateVariabilityData = HKSampleType.quantityType(forIdentifier: .heartRateVariabilitySDNN) else {
//
//            return
//        }
//
//        let startDate = Date.distantPast
//        let endDate = Date()
//
//        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
//
//        let limit = HKObjectQueryNoLimit
//
//        let sampleQueryHeartVariabilityRate = HKSampleQuery(sampleType: sampleHeartRateVariabilityData, predicate: predicate, limit: limit, sortDescriptors: nil) { (sampleQueryHeartVariabilityRate, resultHeartRateVariability, error) in
//
//            guard let samplesHeartRateVariability = resultHeartRateVariability as? [HKQuantitySample] else {return}
//
//            DispatchQueue.main.async {
//                for sampleHeartRateVariability in samplesHeartRateVariability {
//                    let heartVariabilityRate = sampleHeartRateVariability.quantity.doubleValue(for: .secondUnit(with: .milli))
//                    print("Heart Variability: \(heartVariabilityRate)")
//                }
//            }
//        }
//
//        healthStore.execute(sampleQueryHeartVariabilityRate)
//
//    }
//
//
//
//    func getRestingHeartRateData() {
//
//        guard  let sampleRestingHeartRateData = HKSampleType.quantityType(forIdentifier: .restingHeartRate) else {
//
//            return
//        }
//
//        let startDate = Date.distantPast
//        let endDate = Date()
//
//        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
//
//        let limit = HKObjectQueryNoLimit
//
//        let sampleQueryRestingHeartRate = HKSampleQuery(sampleType: sampleRestingHeartRateData, predicate: predicate, limit: limit, sortDescriptors: nil) { (sampleQueryRestingHeartRate, resultRestingHeartRate, error) in
//
//            guard let samplesRestingHeartRate = resultRestingHeartRate as? [HKQuantitySample] else {return}
//
//            DispatchQueue.main.async {
//                for sampleRestingHeartRate in samplesRestingHeartRate {
//                    let restingHeartRate = sampleRestingHeartRate.quantity.doubleValue(for: .init(from: "count/min"))
//                    print(restingHeartRate)
//                }
//            }
//        }
//
//        healthStore.execute(sampleQueryRestingHeartRate)
//
//    }
//
    
}

