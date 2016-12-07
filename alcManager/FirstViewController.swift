//
//  FirstViewController.swift
//  alcManager
//
//  Created by 溝口健太 on 2016/10/25.
//  Copyright © 2016年 溝口健太. All rights reserved.
//

import UIKit
import RealmSwift
import Charts

class FirstViewController: UIViewController {
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var days:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        days = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月","11月"]
        let unitsSold = [50.3, 68.3, 113.3, 115.7, 160.8, 214.0, 220.4, 132.1, 176.2, 120.9,88.9]
        
        setChart(dataPoints: days,values: unitsSold)
        Contents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be
    }
    
    func setChart(dataPoints: [String], values: [Double]) { //Chartsの設定
        //let barChartData = barChartData()   //()内に引数が必要なのかはよく分からん
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]]) //values[i]をdouble型へ
            dataEntries.append(dataEntry)
        }
        let barchartDataSet = BarChartDataSet(values: dataEntries, label: "hoge")
        let ChartData = BarChartData(dataSet: barchartDataSet)       //BarChartをセット .barData
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        barChartView.scaleXEnabled = false
         //https://github.com/danielgindi/Charts/issues/1909
        
        barChartView.data = ChartData      //Viewへ追加
        barChartView.xAxis.labelPosition = .bottom //x軸を下側に設定
        /*barChartView.pinchZoomEnabled = false
        barChartView.drawBarShadowEnabled = false
        barChartView.drawBordersEnabled = true*/
        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)  //背景色の設定
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)   //アニメーション
        barChartView.noDataText = "You need to provide data for the chart."
    }
        
    let realmDB = RealmDB() //インスタンス化
    
    func Contents(){        //初期化
        realmDB.name = "kenta"
        realmDB.age = 2
    }
}
