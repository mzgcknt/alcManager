//
//  alcSelectViewController.swift
//  
//
//  Created by 溝口健太 on 2016/12/08.
//
//

import UIKit

class alcSelectViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    let imageNames = ["beer.png","sake.png","wine.png","cocktail.png"]   //画像のファイル名
    let alcoholType = ["ビール","日本酒","ワイン","カクテル類"]           //画像の名前
    let alcAmount = ["350","180","120","180"]       //アルコール量
    let alcCotent = [0.05,0.15,0.14,0.05]       //アルコール度数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self   //SB上でもやってもいいけどとりあえず書く
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alcFormura(abc:[Double], row:Int) -> Double{  //お酒の量（ml）×[アルコール度数（%）÷100]×0.8
        let sum = abc[row]*(alcCotent[row]*0.8)
        return sum
    }
    
    @IBAction func backBarButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)    //前のViewへ
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueID"{
            let vc = segue.destination as! FirstViewController
            vc.getAlcAmount = sender as? Double
        }
    }
    
    //MARK: -UITableViewDelegate- 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        //セルの選択が可能
        let abc = alcAmount.map{Double($0)!}    //String → Double
        performSegue(withIdentifier: "segueID", sender:alcFormura(abc:abc, row:indexPath.row))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {   //セクションの数を決める
        return 1
    }
    
    //MARK: -UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {   //各セクションのセル数を決める
        return alcoholType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! alcTypeCell    //セルの再利用ができたらする alcTypeCellにキャスト
        let altCellColor = UIColor(red:255/255, green:243.0/255, blue:243.0/255, alpha:1.0)     //偶数セルの色変化 後で調節すること
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = altCellColor;
        } else {
            cell.backgroundColor = UIColor.white;
        }
        
        cell.setCell(imageNames: imageNames[indexPath.row], alcoholType: alcoholType[indexPath.row],alcAmount: alcAmount[indexPath.row])        //セルに値を設定
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
