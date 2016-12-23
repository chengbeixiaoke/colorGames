//
//  ViewController.swift
//  tableviewGames
//
//  Created by WangYangyang on 2016/12/6.
//  Copyright © 2016年 com.WYY. All rights reserved.
//

import UIKit

var V_W = UIScreen.main.bounds.width
var V_H = UIScreen.main.bounds.height

func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor{
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

class ViewController: UIViewController {

    var myTableView: UITableView! = nil
    
    //cell个数
    var cellNumber = 2
    //选中的button
    var number: Int = 0
    //控制色差
    var colornumberint = 255
    //控制提示
    var isBool = true
    //常规颜色
    var color1: UIColor = RGBA(r: 120, g: 130, b: 140, a: 1)
    //有色差的颜色
    var color2: UIColor = RGBA(r: 110, g: 120, b: 130, a: 1)
    
    var cellnumberLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
        self.foundTableView()
        self.foundResetBut()
        self.foundTiShiBut()
        self.foundLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func foundTableView() {
        self.myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: V_W, height: V_W), style: .plain)
        self.myTableView.center = self.view.center
        self.myTableView.backgroundColor = UIColor.clear
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.view.addSubview(self.myTableView)
    }
    
    func foundLabel() {
        self.cellnumberLabel = UILabel.init(frame: CGRect(x: 30, y: V_H - 70, width: V_W - 60, height: 40))
        self.cellnumberLabel.text = "第\(self.cellNumber - 1)关"
        self.cellnumberLabel.textColor = UIColor.white
        self.cellnumberLabel.backgroundColor = UIColor.green
        self.cellnumberLabel.layer.cornerRadius = 5
        self.cellnumberLabel.layer.masksToBounds = true
        self.cellnumberLabel.textAlignment = .center
        self.view.addSubview(self.cellnumberLabel)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idString = "ssdd"
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: idString)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let aa = cell.subviews
        
        for vv in aa {
            vv.removeFromSuperview()
        }
        
        cell.backgroundColor = self.color1
        
        for i: Int in 0...cellNumber {
            let cellnumber = CGFloat.init(self.cellNumber)
            let h = V_W / cellnumber
            let ii = CGFloat.init(i)
            
            let but = UIButton(frame: CGRect(x: h * ii, y: 0, width: h, height: h))
//            but.layer.borderColor = UIColor.white.cgColor
//            but.layer.borderWidth = 0.5
            but.tag = indexPath.row * self.cellNumber + i + 100
            
            if self.number + 100 == but.tag {
                
                but.backgroundColor = self.color2
                    
                but.isUserInteractionEnabled = true
            }else{
                but.isUserInteractionEnabled = false
            }
            
            but.addTarget(self, action: #selector(ViewController.cellNumberAdd), for: .touchDown)
            
            cell.addSubview(but)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellnumber = CGFloat.init(self.cellNumber)
        let h = V_W / cellnumber
        return h
    }
    
    func cellNumberAdd() {
        self.cellNumber += 1
        self.cellnumberLabel.text = "第\(self.cellNumber - 1)关"
        if self.colornumberint < 56  {
            if self.colornumberint < 16 {
                if self.colornumberint < 6 {
                    if self.colornumberint < 2 {
                        self.colornumberint = 1
                    }else{
                        self.colornumberint -= 1
                    }
                }else{
                    self.colornumberint -= 3
                }
            }else{
                self.colornumberint -= 20
            }
        }else{
            self.colornumberint -= 100
        }
        self.number = self.createRandomMan(start: 0, end: cellNumber * cellNumber - 1)()
        print("随机中的but的Tag值\(self.number)")
        print("共有\(cellNumber * cellNumber)个but")
        
        let intR: Int = createRandomMan(start: 50, end: 255)()
        let r = CGFloat.init(intR)
        
        let intG: Int = createRandomMan(start: 50, end: 255)()
        let g = CGFloat.init(intG)
        
        let intB: Int = createRandomMan(start: 50, end: 255)()
        let b = CGFloat.init(intB)
        
        //颜色的最小值
        let colornumberMax = ((r < g) ? r : g) < b ? ((r < g) ? r : g) : b
        
        print("R, G, B \(r, g, b, colornumberMax)")
        
        let colornumber = CGFloat.init(colornumberint)
        
        print("色差 colornumber\(colornumber)")
        
        self.color1 = RGBA(r: r, g: g, b: b, a: 1)
        
        let nowR = (r > colornumber) ? (r - colornumber) : 0
        
        let nowG = (g > colornumber) ? (g - colornumber) : 0
        
        let nowB = (b > colornumber) ? (b - colornumber) : 0
        
        print("RNow, GNow, BNow \(nowR, nowG, nowB, colornumberMax, colornumber)")
        
        self.color2 = RGBA(r: nowR, g: nowG, b: nowB, a: 1)
        
        self.myTableView.reloadData()
    }
    
    func foundResetBut() {
        let but = UIButton(frame: CGRect(x: V_W / 2 - 45, y: 20, width: 90, height: 40))
        but .setTitle("重置", for: .normal)
        but .setTitleColor(UIColor.white, for: .normal)
    
        but.backgroundColor = UIColor.red
        but.addTarget(self, action: #selector(ViewController.resetAction), for: .touchDown)
        self.view.addSubview(but)
    }
    
    func resetAction() {
        self.cellNumber = 1
        self.number = 0
        self.colornumberint = 255
        self.cellNumberAdd()
    }
    
    func foundTiShiBut() {
        let but = UIButton(frame: CGRect(x: V_W / 2 - 45, y: 65, width: 90, height: 40))
        but .setTitle("提示", for: .normal)
        but .setTitleColor(UIColor.white, for: .normal)
        but.backgroundColor = UIColor.green
        but.addTarget(self, action: #selector(ViewController.TiShiAction), for: .touchDown)
        self.view.addSubview(but)
    }
    
    func TiShiAction() {
        
        if self.isBool {
            let but = self.view.viewWithTag(self.number + 100) as! UIButton
            but.layer.borderColor = UIColor.red.cgColor
            but.layer.borderWidth = 0.5
            self.isBool = false
        }else{
            let but = self.view.viewWithTag(self.number + 100) as! UIButton
            but.layer.borderWidth = 0
            self.isBool = true
        }
        
    }
    
    func createRandomMan(start: Int, end: Int) ->() ->Int! {
        //根据参数初始化可选值数组
        var nums = [Int]();
        for i in start...end{
            nums.append(i)
        }
        
        func randomMan() -> Int! {
            if !nums.isEmpty {
                //随机返回一个数，同时从数组里删除
                let index = Int(arc4random_uniform(UInt32(nums.count)))
                return nums.remove(at: index)
            }else {
                //所有值都随机完则返回nil
                return nil
            }
        }
        return randomMan
    }
}

