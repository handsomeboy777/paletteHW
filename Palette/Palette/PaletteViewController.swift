//
//  PaletteViewController.swift
//  Palette
//
//  Created by imac-2437 on 2023/1/16.
//

import UIKit

class PaletteViewController: UIViewController {

    @IBOutlet weak var paletteView: UIView!
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueTextField: UITextField!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaTextField: UITextField!
    @IBOutlet weak var alphaSlider: UISlider!

    var redValue: Float = 0.0
    var greenValue: Float = 0.0
    var blueValue: Float = 0.0
    var alphaValue: Float = 1.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        paletteView.layer.borderWidth = 2
        paletteView.layer.borderColor = UIColor.black.cgColor
        setupUI()
    }
    
    func setupUI() {
        paletteView.backgroundColor = .lightGray
        view.backgroundColor = .white
        //TextField
        setupTextField (textField: redTextField, tag: 0)
        setupTextField (textField: greenTextField, tag: 1)
        setupTextField (textField: blueTextField, tag: 2)
        setupTextField (textField: alphaTextField, tag: 3)
        //Slider
        setupSlider (slider: redSlider, tag: 0)
        setupSlider (slider: greenSlider, tag: 1)
        setupSlider (slider: blueSlider, tag: 2)
        setupSlider (slider: alphaSlider, tag: 3)
        //Tap Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    /// 設定UITextField 樣式
    /// - Parameters:
    ///   - textField: 要設定的 TextField
    ///   - tag: TextField 的 tag
    private func setupTextField (textField: UITextField, tag: Int) {
        textField.keyboardType = .numberPad
        textField.tag = tag
        textField.text = (tag == 3) ? "1" : "0"
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(title: String?, message: String?, confirmTitle: String, confirm: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle:  .alert)
        let confirmAction = UIAlertAction(title: "關閉", style: .default) { _ in
            confirm?()
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    
    /// 設定UISlider
    /// - Parameters:
    ///   - slider: 要設定的UISlider
    ///   - tag: UISlider 的 tag
    private func setupSlider (slider: UISlider, tag: Int) {
        slider.tag = tag
        slider.value = (tag == 3) ? 1 : 0
    }

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text, !(text.isEmpty) else {
            return
        }
        guard let textToFloat = Float(text), textToFloat <= 255.0 else {
            paletteView.backgroundColor = .lightGray
            view.backgroundColor = .white
            showAlert(title: "錯誤", message: "請輸入0~255之間的數值", confirmTitle: "關閉") {
                switch sender.tag {
                case 0:
                    sender.text = "0"
                    self.redSlider.value = 0
                case 1:
                    sender.text = "0"
                    self.greenSlider.value = 0
                case 2:
                    sender.text = "0"
                    self.blueSlider.value = 0
                case 3:
                    sender.text = "1"
                default:
                    break
                }
            }
            return
        }
        switch sender.tag {
        case 0:
            redValue = textToFloat
            redSlider.value = redValue
        case 1:
            greenValue = textToFloat
            greenSlider.value = greenValue
        case 2:
            blueValue = textToFloat
            blueSlider.value = blueValue
        case 3:
            alphaValue = textToFloat
            alphaSlider.value = alphaValue
        default:
            break
        }
        paletteView.backgroundColor = UIColor(red: CGFloat(redValue)/255,
                                              green: CGFloat(greenValue)/255,
                                              blue: CGFloat(blueValue)/255,
                                              alpha: CGFloat(alphaValue))
        view.backgroundColor = UIColor(red: CGFloat(redValue)/255,
                                       green: CGFloat(greenValue)/255,
                                       blue: CGFloat(blueValue)/255,
                                       alpha: CGFloat(alphaValue))
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redValue = sender.value
            redTextField.text = "\(Int(sender.value))"
            redSlider.minimumTrackTintColor = UIColor(red: CGFloat(redValue)/255,
                                                      green: 0,
                                                      blue: 0,
                                                      alpha: 1)
            redSlider.thumbTintColor = UIColor(red: CGFloat(redValue)/255,
                                                      green: 0,
                                                      blue: 0,
                                                      alpha: 1)
        case 1:
            greenValue = sender.value
            greenTextField.text = "\(Int(sender.value))"
            greenSlider.minimumTrackTintColor = UIColor(red: 0,
                                                        green: CGFloat(greenValue)/255,
                                                        blue: 0,
                                                        alpha: 1)
            greenSlider.thumbTintColor = UIColor(red: 0,
                                                 green: CGFloat(redValue)/255,
                                                 blue: 0,
                                                 alpha: 1)
        case 2:
            blueValue = sender.value
            blueTextField.text = "\(Int(sender.value))"
            blueSlider.minimumTrackTintColor = UIColor(red: 0,
                                                        green: 0,
                                                        blue: CGFloat(blueValue)/255,
                                                        alpha: 1)
            blueSlider.thumbTintColor = UIColor(red: 0,
                                                 green: 0,
                                                 blue: CGFloat(blueValue)/255,
                                                 alpha: 1)
            
        case 3:
            alphaValue = sender.value
            alphaTextField.text = String(format: "%.1f", sender.value)
        default:
            break
        }
        paletteView.backgroundColor = UIColor(red: CGFloat(redValue)/255,
                                            green: CGFloat(greenValue)/255,
                                            blue: CGFloat(blueValue)/255,
                                            alpha: CGFloat(alphaValue))
        view.backgroundColor = UIColor(red: CGFloat(redValue)/255,
                                              green: CGFloat(greenValue)/255,
                                              blue: CGFloat(blueValue)/255,
                                              alpha: CGFloat(alphaValue))


    }
}
