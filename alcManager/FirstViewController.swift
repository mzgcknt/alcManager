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
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var wOm: UISegmentedControl!
    
    //var days:[String] = []
    //var alcValue:[Double] = []
    var getAlcAmount:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        let user = User()
        var days:[String] = []
        var alcValue:[Double] = []

        print("realm.objects(User.self).last?.id",realm.objects(User.self).last?.id)    //最後はid=14

        for i in 0..<realm.objects(User.self).count {   //オブジェクト数を取得し、その回数分ループ
            let setObject = realm.object(ofType: User.self, forPrimaryKey: i)! //a?→a!でキャスト
            print("setObject = ",setObject)
            days.append(setObject.day)
            alcValue.append(round(setObject.value*10)/10)   //データベースに保存していた数値を格納
        }
        if getAlcAmount == nil && user.value == 0.0{ //消すのは最初だけ
            user.deleteUser(id: realm.objects(User.self).count-1)   // count-1 = id
        }
        
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
    
    func setChart(x:Int) { //Chartsの設定
        var dataEntries: [BarChartDataEntry] = []
        let realm = try! Realm()

        var days:[String] = []
        var alcValue:[Double] = []
        
        let predicate = realm.objects(User.self).filter("id >= 7")
        print("predicate = ",predicate)
        
        
        for i in predicate {   //オブジェクト数を取得し、その回数分ループ
            let setObject = i //a?→a!でキャスト
            print("setObject = ",setObject)
            days.append(setObject.day)
            alcValue.append(round(setObject.value*10)/10)   //データベースに保存していた数値を格納
        }
        /*if getAlcAmount == nil && user.value == 0.0{ //消すのは最初だけ
            user.deleteUser(id: realm.objects(User.self).count-1)   // count-1 = id
        }*/
        
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
        
        if getAlcAmount != nil{
            user.createNewUser(day: today, value: getAlcAmount!,id: realm.objects(User.self).count)
        }else{
            user.createNewUser(day: today, value: 0.0,id: realm.objects(User.self).count)   //初めにグラフのエラー吐かないために書いといたほうがいいかも
        }
    }
    
    @IBAction func weekOrMonth(_ sender: AnyObject) {
        switch sender.selectedSegmentIndex {
        case 0:
            setChart(x:sender.selectedSegmentIndex)
        case 1:
            setChart(x:sender.selectedSegmentIndex)
        default:
            break
        }
    }
    
}
