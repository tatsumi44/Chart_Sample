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
    let numAraay = [41,23,34,44,5]
    let nameArray = ["自民党","民主党","共産党","公明党","社民党"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
                                     label: nameArray[i])
        }
        
        let set = PieChartDataSet(values: entries, label: "投票結果")
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
