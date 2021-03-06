//: Playground - noun: a place where people can play

import UIKit

func friendlyTime(dateTimeString: String) -> String {
    var showTimeString = dateTimeString
    
    func getTimeString(_ num: Int) -> String {
        if num < 10 {
            return "0\(num)"
        }
        return "\(num)"
    }
    
    let newDate = Date()
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.init(identifier: "zh_CN")
    dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
    guard let date = dateFormatter.date(from: dateTimeString) else {
        return showTimeString
    }
    
    let delta = newDate.timeIntervalSince(date)
    //    print("时间相差：\(delta)")
    if delta <= 0 {
        showTimeString = "刚刚"
    }else if (delta < 60) {
        showTimeString = "\(Int(delta))秒前"
    }else if (delta < 3600) {
        showTimeString = "\(Int(delta/60))分钟前"
    }else{
        let calender = Calendar.current
        //        print(calender.description)
        let comonsents: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute]
        
        let dateComponents = calender.dateComponents(comonsents, from: newDate)
        let dateComponents1 = calender.dateComponents(comonsents, from: date)
        
        guard let currentYear = dateComponents.year,
            let currentMonth = dateComponents.month,
            let currentDay = dateComponents.day,
            let year = dateComponents1.year,
            let month = dateComponents1.month,
            let day = dateComponents1.day,
            let hour = dateComponents1.hour,
            let minute = dateComponents1.minute else {
                return showTimeString
        }
        
        let yearString = "\(year)"
        let monthString = "\(month)"
        let dayString = getTimeString(day)
        let hourString = getTimeString(hour)
        let minuteString = getTimeString(minute)
        
        if currentYear == year { // 相同年
            if currentMonth != month {
                showTimeString =  "\(monthString)月\(dayString)日"
            }else{
                if currentDay == day {
                    showTimeString =  "今天 \(hourString):\(minuteString)"
                }else{
                    let dayDelay = currentDay - day
                    
                    if dayDelay == 1 {
                        showTimeString = "昨天 \(hourString):\(minuteString)"
                    }else if dayDelay == 2 {
                        showTimeString =  "前天"
                    }else{
                        showTimeString =  "\(dayDelay)天前"
                    }
                }
            }
        }else{ // 不同年
            showTimeString = "\(yearString)年\(monthString)月\(dayString)日"
        }
    }
    
    return showTimeString
}

let dateTimeString = "2018-03-22 01:07:12"
print(friendlyTime(dateTimeString: dateTimeString))

let dateTimeString1 = "2018-02-22 01:07:12"
print(friendlyTime(dateTimeString: dateTimeString1))

let dateTimeString2 = "2017-03-22 01:07:12"
print(friendlyTime(dateTimeString: dateTimeString2))

let dateTimeString3 = "2018-03-22 10:39:12"
print(friendlyTime(dateTimeString: dateTimeString3))

let dateTimeString4 = "2018-03-20 10:39:12"
print(friendlyTime(dateTimeString: dateTimeString4))

let dateTimeString5 = "2018-03-21 10:39:12"
print(friendlyTime(dateTimeString: dateTimeString5))
