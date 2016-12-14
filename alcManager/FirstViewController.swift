//
//  FirstViewController.swift
//  alcManager
//
//  Created by 溝口健太 on 2016/10/25.
//  Copyright © 2016年 溝口健太. All rights reserved.
//

import UIKit
import RealmSwift   //macを再起動後、cleanからclean build folderしてxcodeを開けばいける
import Charts

class FirstViewController: UIViewController,ChartViewDelegate{
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var days:[String] = []
    var alcValue:[Double] = []
    var getAlcAmount:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //days = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月","11月","12月"]
        //alcValue = [50.3, 68.3, 113.3, 115.7, 160.8, 214.0, 220.4, 132.1, 176.2, 120.9,88.9,100.2]
        barChartView.delegate = self    //ChartViewDelegate
        Contents()
        setChart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be
    }
    
    func setChart() { //Chartsの設定
        
        var dataEntries: [BarChartDataEntry] = []
        let realm = try! Realm()
        print("realm.objects(User.self)",realm.objects(User.self))
        for i in 0..<realm.objects(User.self).count {   //オブジェクト数を取得し、その回数分ループ
            let setObject = realm.object(ofType: User.self, forPrimaryKey: i)! //a?→a!でキャスト
            print("setObject = ",setObject)
            days.append(setObject.day)
            alcValue.append(round(setObject.value*10)/10)   //データベースに保存していた数値を格納
        }
        let user = User()
        user.deleteUser(id: realm.objects(User.self).count-1)   // count-1 = id
        print("realm.objects(User.self)",realm.objects(User.self))
        
        for i in 0..<days.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [alcValue[i]]) //values[i]をdouble型へ
            dataEntries.append(dataEntry)
        }
        
        let barchartDataSet = BarChartDataSet(values: dataEntries, label: "アルコール摂取量")
        let ChartData = BarChartData(dataSet: barchartDataSet)       //BarChartをセット
        
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        barChartView.xAxis.setLabelCount(days.count, force: false)
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
   
    }
    
    func Contents(){        //初期化
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"  //取得するフォーマットの設定
        let now = Date()    //現在の日時を取得
        let today = formatter.string(from: now)     //今日の日付 MM/dd
        let realm = try! Realm()    //デフォルトのrealmを取得
        let user = User()
        //let value = getAlcAmount
        print("getAlcAmount!",getAlcAmount)
        if getAlcAmount == nil{    //最初に必ず通る
            print("nilの時のrealm.objects(User.self).count",realm.objects(User.self).count)
            user.createNewUser(day: today, value: 0.0 ,id: realm.objects(User.self).count)  //idをrealm.objects(User.self).countにすればいける？
            
        }else{
                print("nilの時ではないrealm.objects(User.self).count",realm.objects(User.self).count)
                user.createNewUser(day: today, value: getAlcAmount!,id: realm.objects(User.self).count)
            }
    }
}
