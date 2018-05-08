//
//  PieChartViewController.swift
//  Chart_Sample
//
//  Created by tatsumi kentaro on 2018/05/04.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Charts
import Firebase
class PieChartViewController: DemoBaseViewController {
    
    @IBOutlet weak var chartView: PieChartView!
    var db : Firestore!
    var a: Double!
    var b: Double!
    var c: Double!
    var d: Double!
    var e: Double!
    var numAraay = [Double]()
    var date : Date!
    let nameArray = ["自民党","民主党","共産党","公明党","社民党"]
    var sDate: String!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.a = 1
        self.b = 1
        self.c = 1
        self.d = 1
        self.e = 1
        let sum = a + b + c + d + e
        numAraay = [(a/sum)*100,(b/sum)*100,(c/sum)*100,(d/sum)*100,(e/sum)*100]
        date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        sDate = format.string(from: date)
        print(sDate)
        db = Firestore.firestore()
        db.collection("election").document(sDate).getDocument { (snap, error) in
            if let error = error{
                print(error.localizedDescription)
            }else{
//                if let data = snap?.data(){
//                    self.a = data["自民党"] as! Double
//                    self.b = data["民主党"] as! Double
//                    self.c = data["公明党"] as! Double
//                    self.d = data["共産党"] as! Double
//                    self.e = data["社民党"] as! Double
//                    let sum = a + b + c + d + e
//                    numAraay = [(a/sum)*100,(b/sum)*100,(c/sum)*100,(d/sum)*100,(e/sum)*100]
//                }else{
//                    self.a = 1
//                    self.b = 1
//                    self.c = 1
//                    self.d = 1
//                    self.e = 1
//                    let sum = a + b + c + d + e
//                    numAraay = [(a/sum)*100,(b/sum)*100,(c/sum)*100,(d/sum)*100,(e/sum)*100]
//                }
            }
        }
        
        
        
        self.options = [.toggleValues,
                        .toggleXValues,
                        .togglePercent,
                        .toggleHole,
                        .toggleIcons,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .spin,
                        .drawCenter,
                        .saveToGallery,
                        .toggleData]
        
        self.setup(pieChartView: chartView)
        
        chartView.delegate = self
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
        setDataCount(5, range: 100)
        
        
        // Do any additional setup after loading the view.
    }
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        //        self.setDataCount(Int(sliderX.value), range: UInt32(sliderY.value))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        
        var array : [PieChartDataEntry] = [PieChartDataEntry]()
        for i in 0 ..< numAraay.count {
            let entries = PieChartDataEntry(value: Double(numAraay[i]) ,
                                            label: nameArray[i])
            array.append(entries)
        }
        
        let set = PieChartDataSet(values: array, label: "投票結果")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        
        
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        //チャートの表示内容のフォントサイズやフォントカラー
        data.setValueFont(.systemFont(ofSize: 15, weight: .light))
        data.setValueTextColor(.black)
        
        chartView.data = data
        chartView.highlightValues(nil)
    }
    
    @IBAction func push(_ sender: UIButton) {
        db = Firestore.firestore()
        db.collection("election").document(sDate).getDocument(completion: { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                print("へいへい")
                if let data = snap?.data(){
                    switch sender.tag {
                    case 1:
                        self.db.collection("election").document(self.sDate).updateData(["自民党" : self.a + 1])
                    case 2:
                        self.db.collection("election").document(self.sDate).updateData(["民主党" : self.b + 1])
                    case 3:
                        self.db.collection("election").document(self.sDate).updateData(["公明党" : self.c + 1])
                    case 4:
                        self.db.collection("election").document(self.sDate).updateData(["共産党" : self.d + 1])
                    case 5:
                        self.db.collection("election").document(self.sDate).updateData(["社民党" : self.e + 1])
                    default:
                        return
                    }
                }else{
                    switch sender.tag {
                    case 1:
                        self.db.collection("election").document(self.sDate).setData(["自民党" : self.a + 1])
                    case 2:
                        self.db.collection("election").document(self.sDate).setData(["民主党" : self.b + 1])
                    case 3:
                        self.db.collection("election").document(self.sDate).setData(["公明党" : self.c + 1])
                    case 4:
                        self.db.collection("election").document(self.sDate).setData(["共産党" : self.d + 1])
                    case 5:
                        self.db.collection("election").document(self.sDate).setData(["共産党" : self.e + 1])
                        
                    default:
                        return
                    }

                }
                
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
