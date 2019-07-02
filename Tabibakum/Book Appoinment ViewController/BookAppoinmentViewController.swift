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

class BookAppoinmentViewController: UIViewController {
    @IBOutlet weak var bookingDateCollectionView: UICollectionView!
    @IBOutlet weak var submit_Btn: UIButton!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var noSlotView: UIView!
    
    var doctorId = String()
    var slotInfoArr = timeSlot.timeSlotInfo()
    var dayInfoArr = [String:String]()
    var selectedIndexPath: IndexPath?
    var weekDate = String()
    var todayDate = String()
    var selectDate = String()
    var getBookingDate = String()
    var slotInfo = [String:String]()
    var todayArr = [timeSlot.timeSlotInfo]()
    var secondArr = [timeSlot.timeSlotInfo]()
    var thirdArr = [timeSlot.timeSlotInfo]()
    var fourthArr = [timeSlot.timeSlotInfo]()
    var fifthArr = [timeSlot.timeSlotInfo]()
    var sixthArr = [timeSlot.timeSlotInfo]()
    var seventhArr = [timeSlot.timeSlotInfo]()
    
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
            print ("Print :\(dateFormatter.string(from: formateDate!))")//Print
            weekDate = dateFormatter.string(from: formateDate!)
            dateFormatter.dateFormat = "EEEE"
            let dayInWeek = dateFormatter.string(from: formateDate!)
            print(dayInWeek)
            dayInfoArr.updateValue(myStringafd, forKey: "fulldate")
            dayInfoArr.updateValue(dayInWeek, forKey: "day")
            dayInfoArr.updateValue(weekDate, forKey: "date")
            print(dayInfoArr)
        }
    }
    
    func doctorTimeSlot(){
        LoadingIndicatorView.show()
        var api = String()
        api = Configurator.baseURL + ApiEndPoints.timeSlot + "?doctor_id=\(doctorId)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                LoadingIndicatorView.hide()
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
                    print(specialistObj)
                   
        
                  //  let filtered = dayInfoArr.filter{_ in(["from"] as? String) =}.flatMap{["from"] as? String
                        
                  //  } //contains 201,200,199
                    
                
                    //contains 2
                    

                    self.slotInfo.updateValue(specialistObj["id"]!.description, forKey: "id")
                    self.slotInfo.updateValue(specialistObj["doctor_id"]!.description, forKey: "doctor_id")
                    self.slotInfo.updateValue(specialistObj["from"] as! String, forKey: "from")
                    self.slotInfo.updateValue(specialistObj["to"] as! String, forKey: "to")
                    self.slotInfo.updateValue(specialistObj["created_at"] as! String, forKey: "created_at")
//                    let slot = timeSlot.timeSlotInfo(
//                        id: specialistObj["id"] as? Int,
//                        doctor_id: specialistObj["doctor_id"] as? Int,
//                        from: specialistObj["from"] as? String,
//                        to: specialistObj["to"] as? String,
//                        created_at: specialistObj["created_at"] as? String)
//                    self.slotInfo.append(slot)
                    let dateFormatterGet = DateFormatter()
                    let currentDateTime = Date()
                    let currenTymSptamp = currentDateTime.timeIntervalSince1970
                    print(currenTymSptamp)
                    var dateTymStamp = TimeInterval()
                    dateFormatterGet.dateFormat = "dd MMMM yyyy hh:mm aa"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let date = dateFormatterGet.date(from: (specialistObj["to"] as? String)!)
                    print(dateFormatterPrint.string(from: date!))
                    dateTymStamp = date!.timeIntervalSince1970
                    print(dateTymStamp)
                    let dateFrmt = DateFormatter()
                    dateFrmt.dateFormat = "MMM dd"
                    self.getBookingDate = (dateFrmt.string(from: date!))
                    print(self.getBookingDate)
                    // Output Formated
                    if currenTymSptamp<dateTymStamp{
//                        let to = slotInfo..to?.suffix(8).description
//                        let from = slot.from?.suffix(8).description
//                        let slottime = from! + "-" + to!
//                        print(self.dayInfoArr)
//                        print(self.slotInfo)
                       // dayInf
                       // if dayInfoArr.contains(where: )
                      //  if dayInfoArr(where: slotInfo){
//                            print("dtessss>")
//                        }
                  //  if dayInfoArr.co
                        
                            
                      
                        
                        
//                        if self.todayDate == self.getBookingDate {
//                            self.tagListView.addTags([slottime])
//                            self.noSlotView.isHidden = true
//                        }else if self.selectDate == self.getBookingDate{
//                            self.tagListView.addTags([slottime])
//                            self.noSlotView.isHidden = true
//                        }
//                        self.tagListView.reloadInputViews()
                  }
                }
        }
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
        
//        if indexPath.row == 0 {
//            cell.day_Lbl.text = "Today"
//            cell.backgroundColor = UIColor.white
//            cell.date_Lbl.textColor = UiInterFace.appThemeColor
//            cell.month_Lbl.textColor = UiInterFace.appThemeColor
//            cell.day_Lbl.textColor = UiInterFace.appThemeColor
//
//        }else {
//            let dayGet = dayInfoArr[indexPath.row].dropLast(7)
//            cell.day_Lbl.text = dayGet.description
//            let monthGet = dayInfoArr[indexPath.row].dropLast(3).description
//            let monthStr = monthGet.suffix(4)
//            cell.month_Lbl.text = monthStr.description
//            let dateGet = dayInfoArr[indexPath.row].suffix(2)
//            //let dateStr = dateGet.suffix(4)
//            cell.date_Lbl.text = dateGet.description
//        }
//        if selectedIndexPath != nil && indexPath == selectedIndexPath {
//            cell.backgroundColor = UIColor.white
//            cell.date_Lbl.textColor = UiInterFace.appThemeColor
//            cell.month_Lbl.textColor = UiInterFace.appThemeColor
//            cell.day_Lbl.textColor = UiInterFace.appThemeColor
//        }else{
//            cell.backgroundColor = UiInterFace.appThemeColor
//            cell.date_Lbl.textColor = UIColor.white
//            cell.month_Lbl.textColor = UIColor.white
//            cell.day_Lbl.textColor = UIColor.white
//        }
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
         //   let selDate = dayInfoArr[indexPath.row].suffix(6)
          //  selectDate = String(selDate)
            print(selectDate)
            doctorTimeSlot()
            //bookingDateCollectionView.reloadData()
        }
    }
}
