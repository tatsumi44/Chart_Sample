//
//  ViewController.swift
//  Chart_Sample
//
//  Created by tatsumi kentaro on 2018/05/03.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Charts
//import Firebase

class ViewController: DemoBaseViewController {
    
    @IBOutlet var chartView: LineChartView!
    
    let months = ["Jan", "Feb", "Mar",
                  "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep",
                  "Oct", "Nov", "Dec"]
    let apple1 = [100,110,120,130,140,150,160,170,180,190,200,150]
    let apple2 = [110,130,160,200,160,120,160,110,120,140,130,180]
    let apple3 = [120,120,180,110,180,100,160,130,140,110,150,130]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.options = [.toggleValues,
                        .toggleFilled,
                        .toggleCircles,
                        .toggleCubic,
                        .toggleHorizontalCubic,
                        .toggleStepped,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData]
        chartView.delegate = self
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        //下の属性一覧
        let l = chartView.legend
        //属性表示のタイプ
        l.form = .line
        //属性表示のフォント
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        //属性表示の文字色
        l.textColor = .orange
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        
        //上の文字
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelCount = months.count - 1
        xAxis.labelFont = .systemFont(ofSize: 11)
        xAxis.labelTextColor = .orange
        //xAxisの文字をいじるためにはこれが必要
        xAxis.valueFormatter = self
        xAxis.drawAxisLineEnabled = false
        
        //グラフの左
//        let leftAxis = chartView.leftAxis
//        leftAxis.labelTextColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
//        leftAxis.axisMaximum = 200
//        leftAxis.axisMinimum = 0
//        leftAxis.drawGridLinesEnabled = true
//        leftAxis.granularityEnabled = true
//
        //グラフの右
        let rightAxis = chartView.rightAxis
        rightAxis.labelTextColor = .red
        rightAxis.axisMaximum = 200
        rightAxis.axisMinimum = 0
        rightAxis.granularityEnabled = false
        
        //アニメーションの速度
        chartView.animate(xAxisDuration: 2.5)
        
         self.setDataCount(xValArr: months, y1ValArr: apple1, y2ValArr: apple2, y3ValArr: apple3)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
//        self.setDataCount(Int(20 + 1), range: UInt32(30))
    }
    //実際のデータを扱い表示するところ
    func setDataCount(xValArr: [String], y1ValArr: [Int],y2ValArr: [Int],y3ValArr: [Int]) {
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        var yVals2 : [ChartDataEntry] = [ChartDataEntry]()
        var yVals3 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0 ..< xValArr.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(y1ValArr[i]))
            yVals1.append(dataEntry) //(ChartDataEntry(x: Double(i), y: dollars1[i]))
        }
        for i in 0 ..< xValArr.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(y2ValArr[i]))
            yVals2.append(dataEntry) //(ChartDataEntry(x: Double(i), y: dollars1[i]))
        }
        for i in 0 ..< xValArr.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(y3ValArr[i]))
            yVals3.append(dataEntry) //(ChartDataEntry(x: Double(i), y: dollars1[i]))
        }

        let set1 = LineChartDataSet(values: yVals1, label: "支持政党推移")
        set1.axisDependency = .left
        set1.setColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
        set1.setCircleColor(.white)
        set1.lineWidth = 2
        set1.circleRadius = 3
        set1.fillAlpha = 65/255
        set1.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        
        let set2 = LineChartDataSet(values: yVals2, label: "DataSet 2")
        set2.axisDependency = .right
        set2.setColor(.red)
        set2.setCircleColor(.white)
        set2.lineWidth = 2
        set2.circleRadius = 3
        set2.fillAlpha = 65/255
        set2.fillColor = .red
        set2.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set2.drawCircleHoleEnabled = false

        let set3 = LineChartDataSet(values: yVals3, label: "DataSet 3")
        set3.axisDependency = .right
        set3.setColor(.yellow)
        set3.setCircleColor(.white)
        set3.lineWidth = 2
        set3.circleRadius = 3
        set3.fillAlpha = 65/255
        set3.fillColor = UIColor.yellow.withAlphaComponent(200/255)
        set3.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set3.drawCircleHoleEnabled = false
        
        let data = LineChartData(dataSets: [set1, set2, set3])
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 9))
        
        chartView.data = data
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value) % months.count]
    }
}


