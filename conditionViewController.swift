//
//  conditionViewController.swift
//  
//
//  Created by 溝口健太 on 2016/12/15.
//
//

import UIKit

class conditionViewController: UIViewController {
    
    @IBOutlet weak var navigationBar:UINavigationBar!
    

    var getValue:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("getValue",getValue)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func btn1(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn2(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
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
