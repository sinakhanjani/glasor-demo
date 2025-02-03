//
//  Constant.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/19/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation

// Typealias
typealias COMPLETION_HANDLER = (_ status: Alert) -> Void
typealias FORMDATA_PARAMETERS = [String:String]
typealias JSON_PARAMETERS = [String:Any]
let EMPTY_IMAGE = "http://glsrap.com/api/uploads/teacher_empty.png"

// Cells Identifier

let NEWS_CELL_ID = "newsCell"
let SCHOOL_HONOR_CELL_ID = "honorCell"
let MAIN_COLLECTION_CELL_ID = "mainCollectionCellID"
let HOME_WORK_CELL_ID = "homeWorkCell"
let WEEK_CELL = "weekendCell"
let TEACHER_CELL = "teacherCell"
let DEPUTY_CELL = "deputyCell"
let EXAM_CELL_ID = "examCell"
let RESULT_CELL_ID = "resultCell"
let TERMIK_CELL_ID = "termikCell"
let DAILY_CELL_ID = "dailyCell"

// StoryBoard IDs

let WEEK_CONTENT_VC_ID = "weekendContentID"
let TEACHER_CONTENT_VC_ID = "techerContentId"
let DEPUTY_CONTENT_VC_ID = "deputyContentId"
let EXAM_CONTENT_VC_ID = "examContentId"
let RESULT_CONTENT_VC_ID = "resultContentId"

// Segue

let LOADER_TO_MAIN_SEGUE = "mainViewControllerSegue"
let CONTENT_SIDE_MENU_SEGUE = "containSideMenuSegue"
let CUSTOM_VIEW_CONTROLLER_SEGUE = "customViewControllerSegue"
let LOGIN_TO_MAIN = "loginToMain"
let SIDE_NEWS_SEGUE = "sideNews"
let SIDE_SCHOOL_PROFILE = "schoolProfileSide"
let NEWS_TO_DETAIL = "newsToDetail"
let LOADER_TO_LOGIN = "loaderToLogin"
let NO_SEGUE = ""
let SCHOOL_HONOR_SEGUE = "schoolHonor"
let SCHOOL_HISTORY_SEGUE = "schoolHistory"
let MAIN_TO_NEWS = "mainToNews"
let MAIN_TO_HOMEWORK_SEGUE = "mainToHomeWork"
let HOMEWORK_TO_DETAIL_SEGUE = "homeWorkToDetail"
let MAIN_TO_WEEK = "mainToWeek"
let MAIN_TO_RESET_PASS = "mainToResetPass"
let MAIN_TO_EXAM = "mainToExam"
let EXAM_TO_DETAIL = "examToDetail"
let RESULT_TO_DETAIL = "resultToDetail"
let WEEK_TO_HOMEWORK = "weekToHomeWork"
let WEEK_TO_EXAM = "weekToExam"
let EXAM_TO_TERMIK_DETAIL = "termikDetail"
let MAIN_TO_DAILY = "mainToDaily"
let DAILY_TO_SEARCH = "dailyToSearch"
let DAILY_TO_DETAIL = "dailyToDetail"
// Observers

let RELOAD_START = Notification.Name.init("reloadStart")
let RELOAD_STOP = Notification.Name.init("reloadStop")
let INDICATOR_STOP = Notification.Name.init("indicatorStop")

// UserDefaults Key
let USER_DEFAULT_KEY = "group.iPersianDeveloper.Glasor"
let IS_LOGGED_IN_KEY = "isLoggedInKey"
let USER_ID_KEY = "userIdKey"
let VERSION_KEY = "versionKey"
let TOKEN_KEY = "tokenKey"
let PHONE_NUMBER_KEY = "phoneNumberKey"

//URLs
let BASE_URL = "https://glsrap.com/api/Api_v3/"
let USER_GET_PASSWORD_URL = BASE_URL + "User/userGetPassword"
let CHANGE_PASSWORD_URL = BASE_URL + "User/changePassword"
let LOGIN_USER_URL = BASE_URL + "User/loginUser"
let DO_PASSWORD_URL = BASE_URL + "User/doPassword"
let GET_MAIN_URL = BASE_URL + "Main/getMain"
let GET_NEWS_URL = BASE_URL + "News/getNews"
let GET_NEWS_DETAIL_URL = BASE_URL + "News/getNews"
let GET_HOME_WOKR_URL = BASE_URL + "Homework/getHomework"
let GET_HOME_WOKR_URL_DETAIL = BASE_URL + "Homework/getHomework"
let GET_EXAM_URL = BASE_URL + "Exam/getExam"
let GET_EXAM_DETAIL_URL = BASE_URL + "Exam/getExam"
let GET_EXAM_RESULT_URL = BASE_URL + "Exam/getExamResult"
let GET_TERM_RESULT_URL = BASE_URL + "Exam/getTermResult"
let GET_WEEK_URL = BASE_URL + "/Week/getWeek"
let GET_SCHOOL_INFO_URL = BASE_URL + "School/getSchoolInfo"
let GET_HONOR_URL = BASE_URL + "School/getHonors"
let GET_TEACHER_URL = BASE_URL + "School/getTeacher"
let GET_SCHOOL_DEPUTY_URL = BASE_URL + "School/getDeputy"
let GET_LOAD_URL = BASE_URL + "Main/getLoad"

let GET_DAILY_STUDENT_URL = BASE_URL + "Daily/getDailyStudent"
let GET_DAILY_STUDENT_DETAIL_URL = BASE_URL + "Daily/getDailyDetails"
let GET_DAILY_TEACHER_URL = BASE_URL + "Daily/getTeacherByClass"
let GET_DAILY_COURSE_STUDENT_URL = BASE_URL + "Daily/getCourseByStudent"

let GET_CHARTS_URL = BASE_URL + "Assessment/getChart"
let GET_EXAM_CLASS_URL = BASE_URL + "Assessment/getExamClass"
let GET_TABLE_SINGLE_URL = BASE_URL + "Assessment/getTableSingle"
let GET_TABLE_GROUP_URL = BASE_URL + "Assessment/getTableGroup"
let GET_EXAM_TERM_URL = BASE_URL + "Assessment/getExamTerm"


//Google Api Key

//Headers

// Font Name
let IRAN_SANS_MOBILE_FONT = "IRANSansMobileFaNum"

// Application Version
let VERSION = "1"

// YEAR
var YEAR: String {
    return APIServices.instance.load?.baseYear ?? "1398"
}
