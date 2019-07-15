//
//  DoctorScheduleSetViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 04/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import TagListView
import Alamofire

class DoctorScheduleSetViewController: BaseClassViewController,UIPickerViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var bookingDateCollectionView: UICollectionView!
    @IBOutlet weak var submit_Btn: UIButton!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var noSlotView: UIView!
    @IBOutlet weak var dateslotLbl: UILabel!
    let timePicker = UIDatePicker()
    let redColor = UIColor(red: 244.0/255.0, green: 67.0/255.0, blue: 54.0/255.0, alpha: 1.0)
    
    var doctorId = String()
    var slotInfoArr = [timeSlot.timeSlotInfo]()
    var dayInfoArr = [[String:String]]()
    var recordArr = [String:[String]]()
    var arrDicFromTo = [[String:String]]()
    var selectedIndexPath: IndexPath?
    var weekDate = String()
    var todayDate = String()
    var selectDate = String()
    var getBookingDate = String()
    var slotInfo = [String:String]()
    var DateString = String()
    var fromTimeString = String()
    var toTimeString = String()
    var bookTimeSting = String()
    var DayString = String()
    var shFrom = true
    var fromStr = ""
    var toStr   = ""
    var fromDate = Date()
    var toDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submit_Btn.layer.cornerRadius = submit_Btn.frame.height/2
        submit_Btn.clipsToBounds = true
        let nib = UINib(nibName: "BookAppoinmentCollectionViewCell", bundle: nil)
        bookingDateCollectionView?.register(nib, forCellWithReuseIdentifier: "BookAppoinmentCollectionViewCell")
        bookingDateCollectionView.layer.cornerRadius = 5
        bookingDateCollectionView.clipsToBounds = true
        bookingDateCollectionView.layer.borderWidth = 0.5
        bookingDateCollectionView.layer.borderColor = UiInterFace.tabBackgroundColor.cgColor
        noSlotView.isHidden = true
        doctorTimeSlot()
        
        selectedIndexPath = IndexPath(row: 0, section: 0)
        timePicker.datePickerMode = .time
        timePicker.minimumDate = Date()
        calculateWeek()
        
    }
    func calculateWeek(){
        let today = Date()
        for i in 0..<7{
            let finalDate = Calendar.current.date(byAdding: .day, value: i, to: today)!
            print(finalDate)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            // again convert your date to string
            let myStringafd = dateFormatter.string(from: finalDate)
            let formateDate = dateFormatter.date(from: myStringafd)
            dateFormatter.dateFormat = "MMM dd"
            // Output Formated
            print ("Print :\(dateFormatter.string(from: formateDate!))")
            let formatedate_ = dateFormatter.string(from: formateDate!)
            weekDate = dateFormatter.string(from: formateDate!)
            dateFormatter.dateFormat = "EEEE"
            let dayInWeek = dateFormatter.string(from: formateDate!)
            var dayInfoDic = [String: String]()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            let completeDate = dateFormatter.string(from: formateDate!)
            print(completeDate)
            dayInfoDic["day"] = dayInWeek
            dayInfoDic["date"] = formatedate_
            dayInfoDic["completeDate"] = completeDate
            dayInfoArr.append(dayInfoDic)
        }
    }
    
    
    func doctorTimeSlot(){
        self.showCustomProgress()
        let useid = UserDefaults.standard.integer(forKey: "userId")
        var api = String()
        api = Configurator.baseURL + ApiEndPoints.timeSlot + "?doctor_id=\(useid)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                self.stopProgress()
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                var arr_ = [String]()
                self.slotInfoArr = []
                self.recordArr = [:]
                for specialistObj in dataDict! {
                    print(specialistObj)
                    let slot = timeSlot.timeSlotInfo(
                        id: specialistObj["id"] as? Int,
                        doctor_id: specialistObj["doctor_id"] as? Int,
                        from: specialistObj["from"] as? String,
                        to: specialistObj["to"] as? String,
                        created_at: specialistObj["created_at"] as? String)
                    self.slotInfoArr.append(slot)
                    let dateFormatterGet = DateFormatter()
                    let currentDateTime = Date()
                    let currenTymSptamp = currentDateTime.timeIntervalSince1970
                    var dateTymStamp = TimeInterval()
                    dateFormatterGet.dateFormat = "dd MMMM yyyy hh:mm aa"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    if let toStr = specialistObj["to"] as? String{
                        if let date = dateFormatterGet.date(from: toStr){
                            print(dateFormatterPrint.string(from: date))
                            dateTymStamp = date.timeIntervalSince1970
                            let dateFrmt = DateFormatter()
                            dateFrmt.dateFormat = "MMM dd"
                            self.getBookingDate = (dateFrmt.string(from: date))
                        }
                    }

                    // Output Formated
                    if currenTymSptamp<dateTymStamp{
                        let to = slot.to!.suffix(8).description
                        let from = slot.from!.suffix(8).description
                        for value in self.dayInfoArr{
                            if value["date"] == self.getBookingDate{
                                if self.recordArr[self.getBookingDate] == nil{
                                    arr_ = []
                                }
                                arr_.append("\(from)-\(to)")
                                self.recordArr[self.getBookingDate] = arr_
                                let date = self.dayInfoArr[0]["date"]
                                let completeDate = self.dayInfoArr[0]["completeDate"]
                                self.addTags(date_: date!, completeDate: completeDate!)
                            }
                        }
                    }
                }
        }
    }
    
    
    
    func addTags(date_ : String, completeDate : String){
        if let arr_m = recordArr[date_]{
            print("ARRAYYYYY \(date_) \(arr_m)")
            self.tagListView.removeAllTags()
            arrDicFromTo = []
            for tagValue in arr_m {
                let splitArr = tagValue.split(separator: "-")
                let fromVal = splitArr[0]
                let toVal = splitArr[1]
                print(splitArr)
                print(fromVal)
                print(toVal)
                var dic = [String:String]()
                dic["from"] = "\(completeDate) \(fromVal)"
                dic["to"] = "\(completeDate) \(toVal)"
                arrDicFromTo.append(dic)
                self.tagListView.addTags([tagValue])
            }
            tagListView.reloadInputViews()
            self.tagListView.isHidden = false
            noSlotView.isHidden = true
        }else{
            self.tagListView.isHidden = true
            noSlotView.isHidden = false
            dateslotLbl.text = DateString.dropLast(4) + "(\(DayString))"
        }
    }
    
    func showScheduleCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let setSchduleVc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorSetSlotView") as? DoctorSetSlotView
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: setSchduleVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .fadeIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        setSchduleVc?.submitBtn.addTargetClosure{ _ in
            self.toStr = ""
            self.fromStr = ""
            self.timePicker.minimumDate = Date()
            self.timePicker.maximumDate = nil
            popup.dismiss()
            self.submitAc()
        }
        setSchduleVc!.cancelBtn.addTargetClosure { _ in
            self.toStr = ""
            self.fromStr = ""
            self.timePicker.minimumDate = Date()
            self.timePicker.maximumDate = nil
            popup.dismiss()
        }
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        if fromStr == ""{
            setSchduleVc?.from_TF.text = "+"
            setSchduleVc?.from_TF.font = UIFont.systemFont(ofSize: 25)
        }
        else{
            setSchduleVc?.from_TF.text = fromStr
            setSchduleVc?.from_TF.font = UIFont.systemFont(ofSize: 15)
        }
        if toStr == ""{
            setSchduleVc?.to_TF.text = "+"
            setSchduleVc?.to_TF.font = UIFont.systemFont(ofSize: 25)
        }
        else{
            setSchduleVc?.to_TF.text = toStr
            setSchduleVc?.to_TF.font = UIFont.systemFont(ofSize: 15)
        }
        setSchduleVc?.from_TF.delegate = self
        setSchduleVc?.to_TF.delegate   = self
        setSchduleVc?.from_TF.tag      = 1
        setSchduleVc?.to_TF.tag        = 2
        // add toolbar to textField
        setSchduleVc?.from_TF.inputAccessoryView = toolbar
        // add datepicker to textField
        setSchduleVc?.from_TF.inputView = timePicker
        setSchduleVc?.to_TF.inputAccessoryView = toolbar
        // add datepicker to textField
        setSchduleVc?.to_TF.inputView = timePicker
        present(popup, animated: animated, completion: nil)
    }
    func submitAc(){
        
        var soon = Date()
        var later = Date()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd MMMM yyyy hh:mm aa"
        var i = 0
        for value in arrDicFromTo{
            i = i + 1
            soon = dateFormatterGet.date(from: value["from"]!)!
            later = dateFormatterGet.date(from: value["to"]!)!
            let range = soon...later
            
            
            if range.contains(fromDate) || range.contains(toDate){
                self.showAlert(message: "slot not available")
                return
            }
        }
        if i == arrDicFromTo.count{
            print("submit")
            slotSetApi()
        }
    }
    
    func slotSetApi(){
        print(fromDate)
        print(toDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMMM-yyyy HH:mm aa"
        let formatedate_ = dateFormatter.string(from: fromDate)
        let todate_ = dateFormatter.string(from: toDate)
        print(formatedate_)
        print(todate_)
        self.showCustomProgress()
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        let param: [String: Any] = [
            "token" : loginToken!,
            "from" : formatedate_,
            "to" : todate_
        ]
        print(param)
        var api = String()
        api = Configurator.baseURL + ApiEndPoints.doctorschedule
        Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                self.stopProgress()
                if let resultDict = response.value as? [String: AnyObject]{
                    if let sucessStr = resultDict["success"] as? Bool{
                        print(sucessStr)
                        if sucessStr{
                            print("sucessss")
                            self.doctorTimeSlot()
                        }else {
                            let alert = UIAlertController(title: "Alert", message: "sumthing woring!", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 1{
            shFrom = true
        }
        else{
            shFrom = false
        }
    }
    @objc func donedatePicker(){
        self.dismiss(animated: true, completion:{
            
        })
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        if shFrom == true {
            fromStr = "\(formatter.string(from: timePicker.date))"
            fromDate = timePicker.date
            timePicker.minimumDate = fromDate.addingTimeInterval(60)
        }
        else{
            toStr = "\(formatter.string(from: timePicker.date))"
            toDate = timePicker.date
            timePicker.maximumDate = toDate
        }
        
        self.view.endEditing(true)
        showScheduleCustomDialog()
    }
    
    @objc func cancelDatePicker(){
        self.dismiss(animated: true, completion:{
            
        })
        fromStr = ""
        toStr = ""
        self.view.endEditing(true)
        showScheduleCustomDialog()
    }
    @objc func startTimeDiveChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
    }
    
    @IBAction func actionSetSlotBtn(_ sender: Any) {
        showScheduleCustomDialog()
    }
}


extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

extension DoctorScheduleSetViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayInfoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "BookAppoinmentCollectionViewCell", for: indexPath) as! BookAppoinmentCollectionViewCell
        let dayGet = dayInfoArr[indexPath.row]["day"]
        cell.day_Lbl.text = dayGet
        let monthGet = dayInfoArr[indexPath.row]["date"]?.dropLast(3).description
        let monthStr = monthGet!.suffix(4)
        cell.month_Lbl.text = monthStr.description
        let dateGet = dayInfoArr[indexPath.row]["date"]?.suffix(2).description
        cell.date_Lbl.text = dateGet!.description.trimmingCharacters(in: .whitespaces)
        
        if selectedIndexPath != nil && indexPath == selectedIndexPath {
            cell.backgroundColor = UIColor.white
            cell.date_Lbl.textColor = UiInterFace.appThemeColor
            cell.month_Lbl.textColor = UiInterFace.appThemeColor
            cell.day_Lbl.textColor = UiInterFace.appThemeColor
        }else{
            cell.backgroundColor = UiInterFace.appThemeColor
            cell.date_Lbl.textColor = UIColor.white
            cell.month_Lbl.textColor = UIColor.white
            cell.day_Lbl.textColor = UIColor.white
        }
        return cell
    }
}

extension DoctorScheduleSetViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BookAppoinmentCollectionViewCell {
            cell.backgroundColor = UIColor.white
            cell.date_Lbl.textColor = UiInterFace.appThemeColor
            cell.month_Lbl.textColor = UiInterFace.appThemeColor
            cell.day_Lbl.textColor = UiInterFace.appThemeColor
            self.selectedIndexPath = indexPath
            print(selectDate)
            bookingDateCollectionView.reloadData()
            let date = dayInfoArr[indexPath.row]["date"]
            DayString = dayInfoArr[indexPath.row]["day"]!
            print(DayString)
            DateString = dayInfoArr[indexPath.row]["completeDate"]!
            addTags(date_: date!, completeDate: DateString)
        }
    }
}