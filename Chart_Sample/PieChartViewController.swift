//
//  PieChartViewController.swift
//  Chart_Sample
//
//  Created by tatsumi kentaro on 2018/05/04.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Charts
class PieChartViewController: DemoBaseViewController {
    
    @IBOutlet weak var chartView: PieChartView!
    let a: Double = 41
    let b: Double = 23
    let c: Double = 34
    let d: Double = 44
    let e: Double = 5
    var numAraay = [Double]()
    let nameArray = ["自民党","民主党","共産党","公明党","社民党"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let sum = a + b + c + d + e
        numAraay = [(a/sum)*100,(b/sum)*100,(c/sum)*100,(d/sum)*100,(e/sum)*100]
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
