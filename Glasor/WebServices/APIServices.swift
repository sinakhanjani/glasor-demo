//
//  APIServices.swift
//  TEST
//
//  Created by Sinakhanjani on 9/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIServices {
    
    static let instance = APIServices()
    
    public var login: Login?
    public var main: Main?
    public var newsList: NewsList?
    public var newsDetail: NewsList?
    public var homeWorkList: HomeWork?
    public var homeWorkDetail: HomeWork?
    public var examResult: ExamResult?
    public var examResultDetail: ExamResult?
    public var examList: Exam?
    public var examDetail: ExamList?
    public var termList: TermList?
    public var weekList: WeekList?
    public var schoolInfo: SchoolInfo?
    public var honor: Honor?
    public var teacherList: TeacherList?
    public var deputyList: DeputyList?
    public var dailyTeacher: DailyTeachers?
    public var courseByTeacher: CourseByTeacher?
    public var dailyItems: DailyItems?
    public var dailyDetail: DailyItemsDetail?
    public var getCharts: GetCharts?
    public var getExamClass: GetExamClass?
    public var getTableSingle: GetTableSingle?
    public var getTableGroup: GetTableGroup?
    public var getExamTerm: GetExamTerm?
    public var load: GetLoadMain?

    
    
    public func userGetPassword(meliCode: String, completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: USER_GET_PASSWORD_URL) else { completion(.server) ; return }
        let parameters = ["userMeliCode":meliCode,
                          "year":YEAR
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            guard let json = try? JSON.init(data: data) else { completion(.json) ; return }
            guard let code = json["code"].string else { completion(.json) ; return }
            if code == "success" {
                completion(.success)
                // "message": "رمز عبور با موفقیت بازیابی شد"
            } else {
                completion(.failed)
            }
            
        }
        task.resume()
    }
    
    public func changePassword(studentId: String, schoolId: String,password: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: CHANGE_PASSWORD_URL) else { completion(.server) ; return }
        let parameters = ["student_id":studentId,
                          "school_id":schoolId,
                          "year":YEAR,
                          "password":password
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            guard let json = try? JSON.init(data: data) else { completion(.json) ; return }
            guard let code = json["code"].string else { completion(.json) ; return }
            if code == "success" {
                completion(.success)
                //  "message": "رمز عبور شما عوض شد."
            } else {
                completion(.failed)
            }
            
        }
        task.resume()
    }
    
    public func loginUser(fcmToken: String,meliCode: String,password: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: LOGIN_USER_URL) else { completion(.server) ; return }
        let parameters = ["userMeliCode":meliCode,
                          "userPassword":password,
                          "year":YEAR,
                          "PusheId":fcmToken
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let login = try? jsonDecoder.decode(Login.self, from: data) else { completion(.json) ; return }
            self.login = login
            print(login)
            completion(.success)
        }
        task.resume()
    }
    
    public func doPassword(password: String,smsCode: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: DO_PASSWORD_URL) else { completion(.server) ; return }
        let parameters = ["userPassword":password,
                          "userCode":smsCode,

        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            guard let json = try? JSON.init(data: data) else { completion(.json) ; return }
            guard let code = json["code"].string else { completion(.json) ; return }
            if code == "success" {
                completion(.success)
            } else {
                completion(.failed)
            }
        }
        task.resume()
    }
    
    public func getMain(schoolId: String, studentId: String, classId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_MAIN_URL) else { completion(.server) ; return }
        let parameters = ["school_id":schoolId,
                          "student_id":studentId,
                          "class_id":classId,
                          "year":YEAR
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            print("get Main")
            print(String(data: data, encoding: .utf8)!)
            guard let main = try? jsonDecoder.decode(Main.self, from: data) else { completion(.noData) ; return }
            self.main = main
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getNewsList(page: String,schoolId: String,baseId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_NEWS_URL) else { completion(.server) ; return }
        let parameters = ["page":page,
                          "school_id":schoolId,
                          "base_id":baseId,
                          "year":YEAR
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let newsList = try? jsonDecoder.decode(NewsList.self, from: data) else { completion(.json) ; return }
            self.newsList = newsList
            completion(.success)
            // * total row maximum number of row *
        }
        task.resume()
    }
    
    public func getNewsDetail(page: String,schoolId: String,baseId: String,newsId: String,studentId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_NEWS_DETAIL_URL) else { completion(.server) ; return }
        let parameters = ["page":page,
                          "school_id":schoolId,
                          "base_id":baseId,
                          "year":YEAR,
                          "news_id":newsId,
                          "student_id":studentId
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let newsDetail = try? jsonDecoder.decode(NewsList.self, from: data) else { completion(.json) ; return }
            self.newsDetail = newsDetail
            completion(.success)
            //
        }
        task.resume()
    }

    public func getHomeWorkList(page: String,schoolId: String,baseId: String,studentId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_HOME_WOKR_URL) else { completion(.server) ; return }
        let parameters = ["page":page,
                          "school_id":schoolId,
                          "base_id":baseId,
                          "year":YEAR,
                          "student_id":studentId
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let homeWorkList = try? jsonDecoder.decode(HomeWork.self, from: data) else { completion(.json) ; return }
            self.homeWorkList = homeWorkList
            completion(.success)
            //
        }
        task.resume()
    }

    public func getHomeWorkDetail(page: String,schoolId: String,baseId: String,studentId: String,homeWorkId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_HOME_WOKR_URL_DETAIL) else { completion(.server) ; return }
        let parameters = ["page":page,
                          "school_id":schoolId,
                          "year":YEAR,
                          "student_id":studentId,
                          "homework_id":homeWorkId
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let homeWorkDetail = try? jsonDecoder.decode(HomeWork.self, from: data) else { completion(.json) ; return }
            self.homeWorkDetail = homeWorkDetail
            completion(.success)
            //
        }
        task.resume()
    }

    public func getExamResult(page: String,schoolId: String,studentId: String,courseId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_EXAM_RESULT_URL) else { completion(.server) ; return }
        let parameters = ["page":page,
                          "school_id":schoolId,
                          "year":YEAR,
                          "student_id":studentId,
                          "course_id":courseId
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let examResult = try? jsonDecoder.decode(ExamResult.self, from: data) else { completion(.json) ; return }
            self.examResult = examResult
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getExamResultDetail(page: String,schoolId: String,studentId: String,examId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_EXAM_RESULT_URL) else { completion(.server) ; return }
        let parameters = ["page":page,
                          "school_id":schoolId,
                          "year":YEAR,
                          "student_id":studentId,
                          "exam_id":examId
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let examResult = try? jsonDecoder.decode(ExamResult.self, from: data) else { completion(.json) ; return }
            self.examResultDetail = examResult
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getExamList(page: String,schoolId: String,studentId: String,examId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_EXAM_URL) else { completion(.server) ; return }
        let parameters = ["page":page,
                          "school_id":schoolId,
                          "year":YEAR,
                          "student_id":studentId,
                          "course_id":examId
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let examList = try? jsonDecoder.decode(Exam.self, from: data) else { completion(.json) ; return }
            self.examList = examList
            completion(.success)
            //
        }
        task.resume()
    }

    public func getExamDetail(page: String,schoolId: String,studentId: String,examId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_EXAM_DETAIL_URL) else { completion(.server) ; return }
        let parameters = ["page":page,
                          "school_id":schoolId,
                          "year":YEAR,
                          "student_id":studentId,
                          "exam_id":examId
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let examDetail = try? jsonDecoder.decode(Exam.self, from: data) else { completion(.json) ; return }
            self.examDetail = examDetail.examList[0]
            completion(.success)
            //
        }
        task.resume()
    }

    public func getTermResult(page: String,schoolId: String,studentId: String,termId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_TERM_RESULT_URL) else { completion(.server) ; return }
        let parameters = ["page":page,
                          "school_id":schoolId,
                          "year":YEAR,
                          "student_id":studentId,
                          "term_id":termId
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let termList = try? jsonDecoder.decode(TermList.self, from: data) else { completion(.json) ; return }
            self.termList = termList
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getWeek(schoolId: String,baseId:String,weekName: Weeks,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_WEEK_URL) else { completion(.server) ; return }
        var parameters = ["school_id":schoolId,
                          "year":YEAR,
                          "class_id":baseId,
        ]
        switch weekName {
        case .shanbe:
            parameters.updateValue(weekName.rawValue, forKey: "week_name")
        case .yekshanbe:
            parameters.updateValue(weekName.rawValue, forKey: "week_name")
        case .doshanbe:
            parameters.updateValue(weekName.rawValue, forKey: "week_name")
        case .seshanbe:
            parameters.updateValue(weekName.rawValue, forKey: "week_name")
        case .charshanbe:
            parameters.updateValue(weekName.rawValue, forKey: "week_name")
        case .panjshanbe:
            parameters.updateValue(weekName.rawValue, forKey: "week_name")
        }
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let weekList = try? jsonDecoder.decode(WeekList.self, from: data) else { completion(.json) ; return }
            self.weekList = weekList
            completion(.success)
            //
        }
        task.resume()
    }

    public func getSchoolInfo(schoolId:String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_SCHOOL_INFO_URL) else { completion(.server) ; return }
        let parameters = ["school_id":schoolId
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let schoolInfo = try? jsonDecoder.decode(SchoolInfo.self, from: data) else { completion(.json) ; return }
            self.schoolInfo = schoolInfo
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getHonors(page:String,schoolId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_HONOR_URL) else { completion(.server) ; return }
        let parameters = ["school_id":schoolId,
                          "page":page,
                          "year":YEAR
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let honor = try? jsonDecoder.decode(Honor.self, from: data) else { completion(.json) ; return }
            self.honor = honor
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getTeacher(page:String,schoolId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_TEACHER_URL) else { completion(.server) ; return }
        let parameters = ["school_id":schoolId,
                          "page":page,
                          "year":YEAR
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let teacherList = try? jsonDecoder.decode(TeacherList.self, from: data) else { completion(.json) ; return }
            self.teacherList = teacherList
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getDeputy(page:String,schoolId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_SCHOOL_DEPUTY_URL) else { completion(.server) ; return }
        let parameters = ["school_id":schoolId,
                          "page":page,
                          "year":YEAR
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let deputyList = try? jsonDecoder.decode(DeputyList.self, from: data) else { completion(.json) ; return }
            self.deputyList = deputyList
            completion(.success)
            //
        }
        task.resume()
    }
    
    //.....................................
    public func getDailyItemsStudent(page:String,teacherId: String,teacherCourse: String,startMonth: String,endMonth: String,studentId: String,schoolId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_DAILY_STUDENT_URL) else { completion(.server) ; return }
        let parameters = ["teacher_id":teacherId,
                          "year":YEAR,
                          "page":page,
                          "teacher_course":teacherCourse,
                          "startMonth":startMonth,
                          "endMonth":endMonth,
                          "student_id":studentId,
                          "school_id":schoolId
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let daily = try? jsonDecoder.decode(DailyItems.self, from: data) else { completion(.json) ; return }
            self.dailyItems = daily
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getDailyItemsDetail(DailyStudentId: String,page: String,schoolId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_DAILY_STUDENT_DETAIL_URL) else { completion(.server) ; return }
        let parameters = ["daily_student_id":DailyStudentId,
                          "year":YEAR,
                          "page":page,
                          "school_id":schoolId
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let dailyDetails = try? jsonDecoder.decode(DailyItemsDetail.self, from: data) else { completion(.json) ; return }
            self.dailyDetail = dailyDetails
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getTeacherByClass(classID: String,schoolId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_DAILY_TEACHER_URL) else { completion(.server) ; return }
        let parameters = ["class_id":classID,
                          "year":YEAR,
                          "school_id":schoolId
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let dailyTeacher = try? jsonDecoder.decode(DailyTeachers.self, from: data) else { completion(.json) ; return }
            self.dailyTeacher = dailyTeacher
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getCourseByStudent(classID: String,schoolId: String,teacherId: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_DAILY_COURSE_STUDENT_URL) else { completion(.server) ; return }
        let parameters = ["class_id":classID,
                          "year":YEAR,
                          "school_id":schoolId,
                          "teacher_id":teacherId
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let courseByTeacher = try? jsonDecoder.decode(CourseByTeacher.self, from: data) else { completion(.json) ; return }
            self.courseByTeacher = courseByTeacher
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getLoad(completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_LOAD_URL) else { completion(.server) ; return }
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            print("get load main")
            guard let load = try? jsonDecoder.decode(GetLoadMain.self, from: data) else { completion(.noData) ; return }
            self.load = load
            completion(.success)
            //
        }
        task.resume()
    }
    
    
    // assesment apis
    
    public func getCharts(startMonth: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_CHARTS_URL) else { completion(.server) ; return }
        guard let userData = DataManager.shared.userDatail else { completion(.data) ; return }
        let parameters = ["school_id":userData.schoolID,
                          "year":YEAR,
                          "student_id":userData.studentID,
                          "class_id":userData.baseID,
                          "startMonth": startMonth
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            print(String(data: data, encoding: .utf8)!)
            let jsonDecoder = JSONDecoder()
            guard let getCharts = try? jsonDecoder.decode(GetCharts.self, from: data) else { completion(.json) ; return }
            self.getCharts = getCharts
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getExamClass(completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_EXAM_CLASS_URL) else { completion(.server) ; return }
        guard let userData = DataManager.shared.userDatail else { completion(.data) ; return }
        let parameters = ["school_id":userData.schoolID,
                          "year":YEAR,
                          "student_id":userData.studentID
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let getExamClass = try? jsonDecoder.decode(GetExamClass.self, from: data) else { completion(.json) ; return }
            self.getExamClass = getExamClass
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getTableSingle(teacherCourse: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_TABLE_SINGLE_URL) else { completion(.server) ; return }
        guard let userData = DataManager.shared.userDatail else { completion(.data) ; return }
        let parameters = ["school_id":userData.schoolID,
                          "year":YEAR,
                          "student_id":userData.studentID,
                          "class_id":userData.baseID,
                          "teacher_course": teacherCourse
        ]

        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let getTableSingle = try? jsonDecoder.decode(GetTableSingle.self, from: data) else { completion(.json) ; return }
            self.getTableSingle = getTableSingle
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getTableGroup(termId: String, teacherCourse: String,completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_TABLE_GROUP_URL) else { completion(.server) ; return }
        guard let userData = DataManager.shared.userDatail else { completion(.data) ; return }
        let parameters = ["school_id":userData.schoolID,
                          "year":YEAR,
                          "student_id":userData.studentID,
                          "term_id":termId,
                          "teacher_course": teacherCourse
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let getTableGroup = try? jsonDecoder.decode(GetTableGroup.self, from: data) else { completion(.json) ; return }
            self.getTableGroup = getTableGroup
            completion(.success)
            //
        }
        task.resume()
    }
    
    public func getExamTerm(completion: @escaping COMPLETION_HANDLER) {
        guard let url = URL(string: GET_EXAM_TERM_URL) else { completion(.server) ; return }
        guard let userData = DataManager.shared.userDatail else { completion(.data) ; return }
        let parameters = ["school_id":userData.schoolID,
                          "year":YEAR,
                          "student_id":userData.studentID
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let token = DataManager.shared.userDatail?.token else { completion(.invalidInput) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.data) ; return }
            let jsonDecoder = JSONDecoder()
            guard let getExamTerm = try? jsonDecoder.decode(GetExamTerm.self, from: data) else { completion(.json) ; return }
            self.getExamTerm = getExamTerm
            completion(.success)
            //
        }
        task.resume()
    }
    
    // Chat
    // CHAT
    let baseURL = URL.init(string: BASE_URL)
    public func getContanct(base_id: String,schoolId: String, completion: @escaping (_ results: [Contact]?) -> Void) {
        guard let url = baseURL?.appendingPathComponent("Dialog/getContact") else { completion(nil) ; return }
        let parameters = ["base_id":base_id,
                          "year":YEAR,
                          "school_id": "\(schoolId)"
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        guard let token = DataManager.shared.userDatail?.token else { completion(nil) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let data = data else { completion(nil) ; return }
            guard let results = try? decoder.decode(GetContanct.self, from: data) else { completion(nil) ; return }
            completion(results.contact)
        }
        task.resume()
    }
    
    public func createDialog(send_target: String,target: String,u_to:String,u_from: String,schoolId: String, completion: @escaping (_ results: CreateDialog?) -> Void) {
        guard let url = baseURL?.appendingPathComponent("Dialog/createDialog") else { completion(nil) ; return }
        let parameters = ["u_from":"\(u_from)",
            "year":YEAR,
            "school_id": "\(schoolId)",
            "u_to": "\(u_to)",
            "target":target,
            "send_target":send_target
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        guard let token = DataManager.shared.userDatail?.token else { completion(nil) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let data = data else { completion(nil) ; return }
            guard let results = try? decoder.decode(CreateDialog.self, from: data) else { completion(nil) ; return }
            completion(results)
        }
        task.resume()
    }
    
    public func getDialog(student_id: String,schoolId: String,page: Int, completion: @escaping (_ results: [Dialog]?) -> Void) {
        guard let url = baseURL?.appendingPathComponent("Dialog/getDialog") else { completion(nil) ; return }
        let parameters = ["student_id":student_id,
                          "year":YEAR,
                          "school_id": schoolId,
                          "page": "\(page)"
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        guard let token = DataManager.shared.userDatail?.token else { completion(nil) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let data = data else { completion(nil) ; return }
            guard let results = try? decoder.decode(GetDialog.self, from: data) else { completion(nil) ; return }
            completion(results.result)
        }
        task.resume()
    }
    
    public func CreateMessage(member_id: String,dialog_id: String,target: String,message: String,media: Data?,completion: @escaping (_ result: CreateMessageDone?) -> Void) {
        guard let url = baseURL?.appendingPathComponent("Dialog/createMessage") else { completion(nil) ; return }
        let parameters = ["member_id":"\(member_id)",
            "dialog_id":dialog_id,
            "target":target,
            "message":message,
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        guard let token = DataManager.shared.userDatail?.token else { completion(nil) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = Data.createDataBody2(withParameters: parameters, media: [media], uploadKey: ["attachment"], boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let data = data else { completion(nil) ; return }
            guard let results = try? decoder.decode(CreateMessageDone.self, from: data) else { completion(nil) ; return }
            completion(results)
        }
        task.resume()
    }
    
    public func getMessage(member_id: String,dialog_id: String,page: Int, completion: @escaping (_ results: [Message]?) -> Void) {
        guard let url = baseURL?.appendingPathComponent("Dialog/getMessage") else { completion(nil) ; return }
        let parameters = [ "member_id":member_id,
                           "dialog_id":dialog_id,
                           "page": "\(page)"
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        guard let token = DataManager.shared.userDatail?.token else { completion(nil) ; return }
        request.addValue(token, forHTTPHeaderField: "auth")
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let data = data else { completion(nil) ; return }
            guard let results = try? decoder.decode(GetMessage.self, from: data) else { completion(nil) ; return }
            completion(results.result)
        }
        task.resume()
    }
}

extension Data {
    static func createDataBody2(withParameters parameters: [String: String]?, media: [Data?]?, uploadKey: [String?]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        if let parameters = parameters {
            for (key,value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        if let media = media, let uploadKey = uploadKey {
            for (key,value) in media.enumerated() {
                if let value = value {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(uploadKey[key]!)\"; filename=\"\("\(arc4random())" + ".png")\"\(lineBreak)")
                    body.append("Content-Type: \(".png" + lineBreak + lineBreak)")
                    body.append(value)
                    body.append(lineBreak)
                }
            }
            
        }
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
}
