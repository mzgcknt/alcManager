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
    
    var days:[String] = []  // []? = nil のどっちがいいのか？
    var alcValue:[Double] = []
    
    var daysCopy:[String] = []
    var valueCopy:[Double] = []
    var getAlcAmount:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //days = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月","11月","12月"]
        //alcValue = [50.3, 68.3, 113.3, 115.7, 160.8, 214.0, 220.4, 132.1, 176.2, 120.9,88.9,100.2]
        
        /*let a = getAlcAmount
        if a != nil{
            print("aの値は ",a)
            print("a!の値は ",a!)
            valueCopy.append(Double(a!)!)
            
            print("valueCopy",valueCopy)
        }*/
        barChartView.delegate = self    //ChartViewDelegate
        Contents()
        setChart(dataPoints: daysCopy,values: valueCopy)
        //Contents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be
    }
    
    func setChart(dataPoints: [String], values: [Double]) { //Chartsの設定
        
        var dataEntries: [BarChartDataEntry] = []
        
        let realm = try! Realm()
        
        print("はじめのdaysCopy setChart",daysCopy)
        print("はじめのvalueCopy setChart",valueCopy)
        for i in 0..<realm.objects(User.self).count {   //オブジェクト数を取得し、その回数分ループ
            let setObject = realm.object(ofType: User.self, forPrimaryKey: i)! //a?→a!でキャスト
            daysCopy.append(setObject.name)
            valueCopy.append(round(setObject.value*10)/10)   //データベースに保存していた数値を格納
        }

        print("daysCopy =" ,daysCopy)
        print("ValueCopy = ",valueCopy)
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [valueCopy[i]]) //values[i]をdouble型へ
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
        //performSegue(withIdentifier: "segue1", sender:valueCopy)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //遷移する前に何か値渡したかったら使う
        /*if segue.identifier == "segue1"{
            let vc = segue.destination as! alcSelectViewController
            vc.value = sender as? [Double]
        }*/
        
    }
    
    //MARK:: --ChartViewDelegate--
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        //print("entry.value",entry.value(forKey: ), "in days[entry.xIndex]",days[entry.xIndex])
    }
    
    func Contents(){        //初期化
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"  //取得するフォーマットの設定
        let now = Date()    //現在の日時を取得
        let today = formatter.string(from: now)     //今日の日付 MM/dd
        
        print("はじめのdaysCopy Contents",daysCopy)
        print("はじめのvalueCopy Contents",valueCopy)
        if getAlcAmount == nil{    //最初に必ず通る
         daysCopy.append(today) //daysCopy ["12/14"]
         valueCopy.append(0.0)  //valueCopy [0.0]
        }else{
            daysCopy.append(today)
            //let a = getAlcAmount
            print("getAlcAmount = ",getAlcAmount)
            //print("a = ",a)
            valueCopy.append(Double(getAlcAmount!)!)
        }
        
        print("append後のdaysCopy Contents",daysCopy)
        print("append後のvalueCopy Contents",valueCopy)
        
        let realm = try! Realm()    //デフォルトのrealmを取得
        for i in 0..<daysCopy.count{
            let user = User()   //インスタンス化
            user.id = i
            user.name = daysCopy[i]
            user.value = valueCopy[i]
            print("userの中身",user)
            try! realm.write {
                realm.add(user, update: true)   //同一キーの更新
            }
        }
        //save(user:user)
    }
}
