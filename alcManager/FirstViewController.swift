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
    
    @IBOutlet weak var combinedChartView: CombinedChartView!
    
    var days:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        days = ["1d","2d","3d"]
        let unitSold = [5.0,4.0,3.0]
        setChart(dataPoints: days, values: unitSold)
        Contents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be
    }
    
    func setChart(dataPoints: [String], values: [Double]) { //Chartsの設定
        let combinedChartData = CombinedChartData()     //()内に引数が必要なのかはよく分からん
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: values)
            dataEntries.append(dataEntry)
        }
        let barchartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        barchartDataSet.colors = ChartColorTemplates.colorful()    //色のテンプレ変更ぽい
        let barchartData = BarChartData(dataSet: barchartDataSet)
        combinedChartData.barData = barchartData       //BarChartをセット
        combinedChartView.data = combinedChartData      //Viewへ追加
        combinedChartView.noDataText = "You need to provide data for the chart."
    }
        
    let realmDB = RealmDB() //インスタンス化
    
    func Contents(){        //初期化
        realmDB.name = "kenta"
        realmDB.age = 2
    }
}
