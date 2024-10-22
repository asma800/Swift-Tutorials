//Week of 2.13.23 - Days 0-4
import UIKit

//-----SIMPLE DATA TYPES-----
//vars are mutable, but must stay same type - can't change string to int or vice versa
var greeting = "Hello, playground"
var age = 43

//multiline string in output
var str = """
This goes over
multiple lines
"""

//multiline string just for formatting
var str2 = """
This goes over \
multiple lines
"""

//let to initialize constant - always use let unless you want to change
let sky = "blue"

let number = 120
print(number.isMultiple(of: 3))

//boolean toggle
var gameOver = true
gameOver.toggle()

//string concatenation - can't add ints or other types with strings
let x = "hi"
let y = "person"
let phrase = x + " " + y
let num = 20
let message = "I'm " + String(num) //or "I'm" + /(num)

//String interpolation - place vars inside string
var score = 85
var scoreStr = "Your score was \(score)"
let quote = "The sign said \"Believe\""
print("5 * 5 = + \(5*5)")

//Checkpoint 1 - Celsius to Farenheit
let celsius = 30.0
print("Celsius: \(celsius). Farenheit = \(celsius * (9 / 5) + 32)°")

//-------COMPLEX DATATYPES--------
/*||Arrays||
- autimatically adapts to size
- only one type of data
- type safety - can't add arr of strings with string of ints
- must initialize with type or values*/
let temps = [67.9, 54.8, 43.9]
var scores = Array<Int>() //let scores = [Int]()
scores.append(90)
scores.append(78)
print(scores.count)
scores.remove(at: 1)
scores.removeAll()
scores.append(73)
scores.append(76)
scores.contains(8)
scores.sort()
let presidents = ["Bush", "Obama", "Trump", "Biden"]
let reversedPresidents = presidents.reversed()
print(reversedPresidents) //doesn't actually reverse, remember they are reversed for accessing

/*||Dictionaries||
- can use any type for key and value, but all keys need to be same and all values should have same type
- can't have duplicate keys - overwrite
- .count() and .removeAll*/
var employee = [
    "name": "Bob",
    "job": "teacher",
    "location": "Atlanta"
]
print(employee["name"]!) //prints optional because that key may or may not exist
print(employee["name", default:"unknown"]) //always get a string back
var heights = [String: Int]() //initialize dictionry
employee["job"] = "lawyer"
print(employee)

/*||Sets||
- don't remember order
- don't add duplicates
- advantage: when you don't want duplicates, highly optimized for searching by using .contains(), can sort a set using .sorted() - will return array
- will probably use arrays most times, but sometimes sets are useful
- */
var people = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])
print(people) //will print in any order - different every time
people.insert("Jennifer Lawrence") //don't append because no order

/*||Enums||
- short for enumeration
- named values
- prevents changing a var to something not in the possible choices
- highly optimized - Swift stores each case as number
- value of enums have the same type annotation as the enum itself*/
enum Weekday {
    case monday, tuesday, wednesday, thursday, friday
} //no longer can make Weekday anything other than these
var day = Weekday.monday
//or write it like this
var newDay = Weekday.tuesday
newDay = .thursday

/*||Type Annotations||
 - usually Swift infers the type
 - explitly define type instead - String, Int, Bool, Double
 - not required, but if you want an empty array or other data type
 - used for constants ("let" values) that haven't been decided yet - knows not to used constant before intialized
 - Swift must know at all times what type all data is
 - can't do var scored: Int = "Zero"*/
let luckyNum: Int = 8
let animal: String = "lion"
let classes: [String] = ["math, science, english"] //String array
var user: [String: String] = ["id" : "@bob123"]  //dictionary with string key and value
var books: Set<String> = Set(["To Kill a Mockingbird", "Pride and Prejudice"]) //Set holding String
//choose any of these for syntax to create empty array
var teams: [String] = [String]()
var cities: [String] = []
var clues = [String]()

/*||Checkpoint 2||
 - create array of strings, print items and count duplicates*/
var greetings = ["hello", "hey", "hi", "hey"]
print(greetings.count)
print(Set(greetings).count)


