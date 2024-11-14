//
//  ViewController.swift
//  SlideshowApp
//
//  Created by UI3 on 2024/11/04.
//

import UIKit

class ViewController: UIViewController {
    
    // プロパティの定義
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var dispImageNo = 0
    var timer: Timer?
    
    let imageNameArray = [
    "shoes.jpg",
    "car.jpg",
    "sea.jpg",
    ]
    
    //メソッドを記述する
    
    //画面の読み込み
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //初期画像の設定
        updateImageView()
        
        //画像をタップして遷移させる
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        
    }
    
    //画像を切り替えるメソッド
    func updateImageView() {
        let imageName = imageNameArray[dispImageNo]
            imageView.image = UIImage(named: imageName)
    }
    
    //各ボタンのタップのアクション
    @IBAction func next(_ sender: Any) {
        dispImageNo = (dispImageNo + 1) % imageNameArray.count
        updateImageView()
    }
    
    @IBAction func prev(_ sender: Any) {
        dispImageNo = (dispImageNo - 1 + imageNameArray.count) % imageNameArray.count
        updateImageView()
    }
    
    @IBAction func playButtonTap(_ sender: UIButton) {
        if timer != nil {
            stopImageCycle()
        } else {
            startImageCycle()
        }
    }
    
    // 画像の自動切り替えを開始するメソッド
    func startImageCycle() {
        // 進む・戻るボタンを無効化
                nextButton.isEnabled = false
                prevButton.isEnabled = false
        
        // タイマーが設定されていない場合、新たに設定する
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateImage), userInfo: nil, repeats: true)
        
        // 再生ボタンを停止ボタンに変更
        playButton.setTitle("停止", for: .normal)
    }
    
    // 画像の自動切り替えを停止するメソッド
    func stopImageCycle() {
        timer?.invalidate()  // タイマーを停止
        timer = nil
        
        // 進む・戻るボタンを有効化
        nextButton.isEnabled = true
        prevButton.isEnabled = true
                
        // 再生ボタンを再生ボタンに戻す
        playButton.setTitle("再生", for: .normal)
    }
    
    
    // 画像を切り替えるメソッド
    @objc func updateImage() {
        // 次の画像に切り替え
        dispImageNo = (dispImageNo + 1) % imageNameArray.count
        updateImageView()
    }
    

    // 画像をタップして画面遷移させる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultViewController {
            let imageName = imageNameArray[dispImageNo]
                resultViewController.imageName = imageName
        }
    }


    @objc func imageTapped() {
        // タップされた画像で遷移
        performSegue(withIdentifier: "showResult", sender: self)
    }

    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }

    @IBAction func unwind(_ segue: UIStoryboardSegue){
        
    }
    
    
}

