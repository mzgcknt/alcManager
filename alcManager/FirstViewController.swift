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

class FirstViewController: UIViewController,ChartViewDelegate{
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var days:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        days = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月","11月","12月"]
        let unitsSold = [50.3, 68.3, 113.3, 115.7, 160.8, 214.0, 220.4, 132.1, 176.2, 120.9,88.9,100.2]
        barChartView.delegate = self    //ChartViewDelegate
        
        setChart(dataPoints: days,values: unitsSold)
        Contents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be
    }
    
    func setChart(dataPoints: [String], values: [Double]) { //Chartsの設定
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]]) //values[i]をdouble型へ
            dataEntries.append(dataEntry)
        }
        
        let barchartDataSet = BarChartDataSet(values: dataEntries, label: "alcAmount")
        let ChartData = BarChartData(dataSet: barchartDataSet)       //BarChartをセット
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        barChartView.scaleXEnabled = false
         //https://github.com/danielgindi/Charts/issues/19092

        let ll = ChartLimitLine(limit: 10.0, label: "Target")
        barChartView.rightAxis.addLimitLine(ll) //Limit lineの設定

        barChartView.data = ChartData      //Viewへ追加
        barChartView.xAxis.labelPosition = .bottom //x軸を下側に設定
        barChartView.chartDescription?.text = ""    //descriptionのテキストを消す
        barChartView.xAxis.drawGridLinesEnabled = false //x軸の方眼を非表示
        barChartView.pinchZoomEnabled = false       //ピンチした際のズームを無効
        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)  //背景色の設定
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)   //アニメーション
        barChartView.noDataText = "You need to provide data for the chart."
    }
    
    
    @IBAction func alcSelectBtn(_ sender: AnyObject) {  //とりあえずボタン押した時の処理
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //遷移する前に何か値渡したかったら使う
        
    }
    
    //MARK:: --ChartViewDelegate--
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        //print("entry.value",entry.value(forKey: ), "in days[entry.xIndex]",days[entry.xIndex])
        print("うんち！")
    }
    
    //let realmDB = RealmDB() //インスタンス化
    let user = User()
    
    func Contents(){        //初期化
        user.name = "kenta"
        user.age = 2
        print("user.name = ",user.name)
        print("user.age = ",user.age)
        
        let realm = try! Realm()    //デフォルトのrealmを取得
        try! realm.write {
            realm.add(user)
        }
    }
}
