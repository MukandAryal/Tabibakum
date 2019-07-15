//
//  BookAppoinmentViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 20/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire
import TagListView

struct timeSlot {
    struct timeSlotInfo {
        var id : Int?
        var doctor_id  : Int?
        var from : String?
        var to : String?
        var created_at : String?
    }
}

class BookAppoinmentViewController: BaseClassViewController,TagListViewDelegate {
    @IBOutlet weak var bookingDateCollectionView: UICollectionView!
    @IBOutlet weak var submit_Btn: UIButton!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var noSlotView: UIView!
    @IBOutlet weak var noSlotViewDay_Lbl: UILabel!
    var doctorId = String()
    var slotInfoArr = [timeSlot.timeSlotInfo]()
    var selectedIndexPath: IndexPath?
    var weekDate = String()
    var todayDate = String()
    var selectDate = String()
    var getBookingDate = String()
    var slotInfo = [String:String]()
    var dayInfoArr = [[String:String]]()
    var recordArr = [String:[String]]()
    var DateString = String()
    var fromTimeString = String()
    var toTimeString = String()
    var bookTimeSting = String()
    var DayString = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submit_Btn.layer.cornerRadius = submit_Btn.frame.height/2
        submit_Btn.clipsToBounds = true
        let nib = UINib(nibName: "BookAppoinmentCollectionViewCell", bundle: nil)
        bookingDateCollectionView?.register(nib, forCellWithReuseIdentifier: "BookAppoinmentCollectionViewCell")
        submit_Btn.backgroundColor = UiInterFace.appThemeColor
        bookingDateCollectionView.layer.cornerRadius = 5
        bookingDateCollectionView.clipsToBounds = true
        bookingDateCollectionView.layer.borderWidth = 0.5
        bookingDateCollectionView.layer.borderColor = UiInterFace.tabBackgroundColor.cgColor
        doctorTimeSlot()
        self.selectedIndexPath = IndexPath(row: 0, section: 0)
        tagListView.delegate = self
        let tagView = tagListView.addTag("")
        // tagView.tagBackgroundColor = UIColor.gray
        tagView.onTap = { tagView in
            print("Don’t tap me!")
        }
        let today = Date()
        print(today)
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
            let formatedate_ = dateFormatter.string(from: formateDate!)
            weekDate = dateFormatter.string(from: formateDate!)
            dateFormatter.dateFormat = "EEEE"
            let dayInWeek = dateFormatter.string(from: formateDate!)
            dateFormatter.dateFormat = "dd MMMM yyyy"
            let completeDate = dateFormatter.string(from: formateDate!)
            print(completeDate)
            var dayInfoDic = [String: String]()
            dayInfoDic["day"] = dayInWeek
            dayInfoDic["date"] = formatedate_
            dayInfoDic["completeDate"] = completeDate
            dayInfoArr.append(dayInfoDic)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func doctorTimeSlot(){
        self.showCustomProgress()
        var api = String()
        api = Configurator.baseURL + ApiEndPoints.timeSlot + "?doctor_id=\(doctorId)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
             
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                var arr_ = [String]()
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
                    let date = dateFormatterGet.date(from: (specialistObj["to"] as? String)!)
                    print(dateFormatterPrint.string(from: date!))
                    dateTymStamp = date!.timeIntervalSince1970
                    let dateFrmt = DateFormatter()
                    dateFrmt.dateFormat = "MMM dd"
                    self.getBookingDate = (dateFrmt.string(from: date!))
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
                                self.addTags(date_: date!)
                            }
                        }
                    }
                }
                self.stopProgress()
        }
    }
    
    func addTags(date_ : String){
        if let arr_m = recordArr[date_]{
            print("ARRAYYYYY \(arr_m)")
            self.tagListView.removeAllTags()
            for tagValue in arr_m {
                self.tagListView.addTags([tagValue])
            }
            tagListView.reloadInputViews()
            self.tagListView.isHidden = false
            noSlotView.isHidden = true
            submit_Btn.isHidden = false
        }else{
            self.tagListView.isHidden = true
            noSlotView.isHidden = false
            print(DateString)
            print(DayString)
            noSlotViewDay_Lbl.text = DateString.dropLast(4) + "(\(DayString))"
            submit_Btn.isHidden = true
        }
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        let fromTime = title.dropLast(9)
        let toTime = title.suffix(8)
        fromTimeString = DateString + " " + fromTime
        toTimeString = DateString + " " + toTime
        bookTimeSting = String(" " + fromTime + " - " + toTime)
        tagListView.tagViews.forEach {
            $0.isSelected = false
        }
        tagView.isSelected = !tagView.isSelected
    }
    
    func bookingConfimApi(){
        self.showCustomProgress()
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        let param: [String: Any] = [
            "doctor_id" : doctorId,
            "token" : loginToken!,
            "from" : fromTimeString,
            "to" : toTimeString
        ]
        print(param)
        var api = String()
        api = Configurator.baseURL + ApiEndPoints.patient_post_booking
        Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                self.stopProgress()
                if let resultDict = response.value as? [String: AnyObject]{
                    if let sucessStr = resultDict["success"] as? Bool{
                        print(sucessStr)
                        if sucessStr{
                            print("sucessss")
                            let obj = self.storyboard?.instantiateViewController(withIdentifier: "PatientBookingDoneViewController") as! PatientBookingDoneViewController
                            obj.dateString = self.DateString
                            obj.timeString = self.bookTimeSting
                            self.navigationController?.pushViewController(obj, animated: true)
                        }else {
                            let alert = UIAlertController(title: "Alert", message: "sumthing woring!", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
        }
    }
    @IBAction func actionBookingConfirm(_ sender: Any) {
        bookingConfimApi()
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension BookAppoinmentViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
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

extension BookAppoinmentViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? BookAppoinmentCollectionViewCell {
            cell.backgroundColor = UIColor.white
            cell.date_Lbl.textColor = UiInterFace.appThemeColor
            cell.month_Lbl.textColor = UiInterFace.appThemeColor
            cell.day_Lbl.textColor = UiInterFace.appThemeColor
            self.selectedIndexPath = indexPath
            print(selectDate)
            bookingDateCollectionView.reloadData()
            DayString = dayInfoArr[indexPath.row]["day"]!
            print(DayString)
            DateString = dayInfoArr[indexPath.row]["completeDate"]!
            let date = dayInfoArr[indexPath.row]["date"]
            addTags(date_: date!)
          
        }
        
    }
}
