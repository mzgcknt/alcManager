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
    
    let imageNames = ["beer-jar.png","drink.png"]   //画像のファイル名
    let alcoholType = ["ビール","ワイン"]           //画像の名前
    let alcAmount = ["350","120"]
    
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
    
    @IBAction func backBarButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)    //とリあえずこれでやってみる
    }
    
    //MARK: -UITableViewDelegate- 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択が可能
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {   //セクションの数を決める
        return 1
    }
    
    //MARK: -UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {   //各セクションのセル数を決める
        return alcoholType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! alcTypeCell    //セルの再利用ができたらする
        /*if cell == nil{ //セルの再利用ができない場合
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }*/
        
        //cell?.textLabel?.text = alcoholType[indexPath.row]      //各セルのtextに追加
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
