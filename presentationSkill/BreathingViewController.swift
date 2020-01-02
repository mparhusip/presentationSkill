//
//  BreathingViewController.swift
//  presentationSkill
//
//  Created by Marilyn Martha Yusnita Devi Parhusip on 19/09/19.
//  Copyright © 2019 Apple Academy. All rights reserved.
//

import UIKit
import HealthKit

class BreathingViewController: UIViewController {
    
    var healthStore = HKHealthStore()
    
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    var isFirstAnimationRunning = false
    var isSecondAnimationRunning = false
    
    //bool untuk break alert
    var bool = true

    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var circleBreathing: UIView!
    @IBOutlet weak var heartRateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionLabel.text = "Exhale"
        
        // untuk HealthKit
        
        circleBreathing.layer.cornerRadius = 187
    
        if HKHealthStore.isHealthDataAvailable() {
            
        }
        
        let allTypes = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!,
                            HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
                            HKObjectType.quantityType(forIdentifier: .restingHeartRate)!])
        
        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if !success {
                fatalError("You are not allowed to the Health Data")
            } else {
                print("You are allowed")
            }
        }
        
        //        getHeartRateData()
        //        getHeartRateVariabilityData()
        //        getRestingHeartRateData()
        
//        subscribeToHeartBeatChanges()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(readHealthData), userInfo: nil, repeats: true)
//
//       readHealthData()
        
    }

    
   @objc func readHealthData()
    
   {
        
        
        
        //sample type
//        guard let sampleType = HKSampleType.quantityType(forIdentifier: .heartRate) else { return }
//
//        //predicate boleh nil
//
//        //limit
//        let limit = 1
//
//        //sortDescriptor bisa nil
//        let sortDescriptors = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
//
//        //query
//        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: limit, sortDescriptors: [sortDescriptors]) { (sampleQuery, results, error) in
//
//            guard let samples = results as? [HKQuantitySample] else { return }
//
//            for sample in samples {
                self.fetchTheLatestHeartRateSample(completion: { (sample) in
                    guard let sample = sample else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        
                        let heartRateUnit = HKUnit(from: "count/min")
                        let heartRate = sample.quantity.doubleValue(for: heartRateUnit)
                        self.heartRateLabel.text = String("\(Int(heartRate))")

//                        let heartRate = 80
//                        let heartRate = 120
//                        self.heartRateLabel.text = "120"
//
                        print(heartRate)
                        
                        if heartRate >= 70 {
                            self.bool = true
                            
                            self.runTimer()
                            
                            self.circleBreathing.isHidden = false
                        // circle breathing Application
//                            self.circleBreathing.layer.cornerRadius = 187
                            //                    self!.circleBreathing.layer.position = self!.view.center
                            
                        //      Animation Circle Brathing
                            
//                            print(self.circleBreathing.frame.width)
                            
                            if !self.isFirstAnimationRunning && !self.isSecondAnimationRunning{
                                self.isFirstAnimationRunning = true
                                self.isSecondAnimationRunning = true
                                UIView.animate(withDuration: 3, delay: 0, animations: {
        //                            self.circleBreathing.layer.cornerRadius = self.circleBreathing.frame.width/2
                                    
                                    self.circleBreathing.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
//                                    print(self.circleBreathing.frame.width)
                                    
        //                            if self.circleBreathing.frame.width == 93.5 {
                                        self.actionLabel.text = "Exhale"
        //                            } else if self.circleBreathing.frame.width == 187 {
        //                                self.actionLabel.text = "Exhale"
        //                            }
                                   
        //                            if self.circleBreathing.transform.scaledBy(x: >0.5, y: ){
        //                                print("inhale")
        //                            }
        //
                                }, completion: {(true) in
                                    self.isFirstAnimationRunning = false
                                })
                                
                                
                                 self.timerSecondAnimation()
                                
                            }
                            
//                        UIView.animate(withDuration: 7, delay: 3, animations: {
//                            self.circleBreathing.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
//                            self.actionLabel.text = "Inhale"
//
//                        }, completion: nil)
                            
                       
                            
                        } else {
//                            self.isTimerRunning = false
                            self.circleBreathing.isHidden = true
                            
                            if self.bool == true {
                                let alert = UIAlertController(title: "Are you ready?", message: "You can do it! Go for it!", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alert, animated: true)
                                self.bool = false
                            }
                            
                        }
                    }
                })
                
//            }
//        }
//        
//        healthStore.execute(sampleQuery)
    }
    
    @objc func inhaleAnimation(){
        UIView.animate(withDuration: 3, delay: 0, animations: {
            self.circleBreathing.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            self.actionLabel.text = "Inhale"
        }, completion: {(true) in
            self.isSecondAnimationRunning = false
        })
    }
    
    @objc func exhaleAnimation(){
        UIView.animate(withDuration: 3, delay: 0, animations: {
            self.circleBreathing.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
            print(self.circleBreathing.frame.width)
            self.actionLabel.text = "Exhale"
        }, completion: nil)
    }
    
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        seconds -= 1
    }
    
    var secondAnimationDelay = Timer()
    
    func timerSecondAnimation(){
        secondAnimationDelay = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(inhaleAnimation), userInfo: nil, repeats: false)
    }

    
    func fetchTheLatestHeartRateSample(completion: @escaping (_ sample: HKQuantitySample?) -> Void ) {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            completion (nil)
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { (_, results, error) in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            completion(results?[0] as? HKQuantitySample)
        }
        
        self.healthStore.execute(query)
        
    }
    

    
    
    
//    func subscribeToHeartBeatChanges() {
//
//        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else {return}
//
//        //A long-running query that monitors the HealthKit store and updates your app whenever a matching sample is saved to or deleted from the HealthKit store.
//        let query = HKObserverQuery(sampleType: sampleType, predicate: nil) { [weak self] (query, completionHandler, error) in
//
//            //            debugPrint("HKObserverQuery handler called for \(sampleType) - query: \(query), error: \(error)")
//
//            if error != nil {
//                print("An error occur when setting up the Heart Rate Observer")
//                abort()
//            }
//
//            //            self?.fetchThelatestHeartRateSample(completion: { (sample) in
//            //                guard let sample = sample else {
//            //                    return
//            //                }
//            //            })
//
//            //            self.fetchThelatestHeartRateSample(completion: sample in
//            //            guard let sample = sample else {
//            //                return
//            //            })
//            //            print("nano")
//            //            completionHandler()
//            //
//
//            self?.fetchThelatestHeartRateSample(completion: { sample in
//                guard let sample = sample else {
//                    return}
//
//                DispatchQueue.main.async {
//
//                    let heartRateUnit = HKUnit(from: "count/min")
////                    let heartRate = sample.quantity.doubleValue(for: heartRateUnit)
////                    self?.heartRateLabel.text = String("\(Int(heartRate))")
//                    let heartRate = 120
//
//                    print(heartRate)
//
//                    if heartRate >= 101 {
//                    // circle breathing Application
//                    self!.circleBreathing.layer.cornerRadius = self!.circleBreathing.frame.width/2
////                    self!.circleBreathing.layer.position = self!.view.center
//
//                    //      Animation Circle Brathing
//                    UIView.animate(withDuration: 3, delay: 0.5, options: [.repeat,.autoreverse], animations: {
//
//                        self!.circleBreathing.layer.cornerRadius = self!.circleBreathing.frame.width/2
//
//                        self!.circleBreathing.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
//
//                    }, completion:  nil)
//
//                    }
//
//
//                }
//            })
//
//        }
//
//        self.healthStore.execute(query)
//        //        self.healthStore.enableBackgroundDelivery(for: sampleType, frequency: .immediate) { (success, error) in
//        //            debugPrint("enableBackgroundDeliveryForType handler called for \(sampleType) - success: \(success), error: \(error)")
//
//
//        ////        guard let sampleType: HKSampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
//        //            return
//        //        }
//        //
//        //        let heartRateQuery = HKObserverQuery.init(sampleType: sampleType, predicate: nil) { [weak self] _, _, error in
//        //            guard error == nil else {
//        //
//        //                return
//        //            }
//        //        }
//    }
//
//    func fetchThelatestHeartRateSample(completion: @escaping (_ sample: HKQuantitySample?) -> Void) {
//        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
//            completion (nil)
//            return
//        }
//
//        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
//
//        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
//
//        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { (_, results, error) in
//            guard error == nil else {
//                print("Error: \(error!.localizedDescription)")
//                return
//            }
//
//            completion(results?[0] as? HKQuantitySample)
//        }
//
//        self.healthStore.execute(query)
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */

}
