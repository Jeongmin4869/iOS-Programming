import UIKit

// var : 변수선언
// let : 상수선언

var str = "Hello, playground"   // Hello, playground
str = "Hello, Swift"            // Hello, Swift
let constStr = str              // Hello, Swift
constStr = "Hello, world"       // error

// 타입지정
// var variableName: Type
var nextYear: Int
var bodyTemp: Float
var hasPet: Bool

//숫자와 불린 타입
//-정수 : Int
//-32비트 실수 : Float
//-64비트 실수 : Double
//-80비트 실수 : Float80
//-불린 : true, false

//컬랙션타임
//-array : 배열은 강타입(Strong Type) 지정된 타입의 값만 저장
var arrayofInts: Array<int>      // 배열에 대한 표시
var arrayofInts2: [Int]          // 배열에 대한 축약적 표시
//-Dictionary
//       : <key, value> 쌍의 값을 저장하는 자료구조 // key는 유일해야한다
//       : 순서가 없다.             // 저장된 순서 등은 의미가 없다.
//                               // 순서가 있는 것 : 배열, 큐, 스택
var dictionaryOfCapitalsByCountry: Dictionary<String, String>
var dictionaryOfCapitalsByCountry2: [String: String] // 딕셔너리에 대한 축악적 표시
//-Set : 집합
//     : <key>값들을 저장하는 자료구조 // key는 유일하여야 함
//     :  순서가 없다.
var winningLottryNumbers: Set<Int>

//리터럴
//리터럴 : 값 그 자체
// - 1, 23, 345.6, "JMLEE", true
// - 상수와 혼돈하지 말 것. 상수는 변수인데 그 값이 하나로 고정 된 것이다.
let JM : "LEE"                  //JM->변수 "LEE"->리터럴
//서브스크립팅 : 구글링 참고

//이니셜라이저
//-상수와 변수의 초기화 -> 특정 ㅏㅌ입의 인스터스 생성
//-구글링참고!

//프로퍼티(property)
//타입의 인스턴스와 연관된 값이다.
//- Bool타입의 isEmpty
//- Array<T>타입의 count
//- 저장프로퍼티 : 값을 저장하고있는 프로퍼티.
//- 계산된프로퍼티 : 값을 저장하고 있지 않고 특정하게 계산한 값을 반환해주는 프로퍼티.
let countingUp = ["one", "two"]
let secondElement - countingUp[1]
countingUp.count
//인스턴스 메소드
//- 타입의 인스턴스에서 호출하는 함수.
var countingUp = ["one", "two"]
let secondElement = countingUp[1]
countingUp.append("three")

//옵셔넝
//타입 이름 뒤에 ?을 붙여 표시
//옵셔널 변수는 값을 저장하지 않을 수도 있다.
//- 값을 nil로 저장할 수 있다.
//- 옵셔널이 아닌 변수는 반드시 값을 저장해야 한다.
//- 옵셔널이 아닌 변수는 nil값을 저장할 수 없다.
var anOptionalFloat : Float?
var anOptionalArrayOfStrings: [String]?
var anArrayOfOtionalStrings: [String?]
var anOptionalArrayOfOptionalStrings: [String?]?
//
var reading1: Float?             //nil
var reading2: Float?             //nil
var reading3: Float?             //nil
var reading4: Float              //error
//언래핑
//옵셔널 변수의 값을 읽기 전에 nil이 아님을 확실히 확신하는것
var optionalV1: Float? = 10.0
var optionalV2: Float?
var nonoptionalV1: Float = 20.0
var nonoptionalV2: Float
optionalV2 = optionalV1          //10.0
optionalV2 = nonoptionalV1       //20.0
nonoptionalV2 = optionalV1       //문법적 에러
nonoptionalV2 = nonoptionalV1    //20.0


