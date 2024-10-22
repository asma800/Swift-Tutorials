//Week of 2.20.23 - Days 5 to 8
import UIKit

//------------------CONDITIONALS---------------------
/*||If statements||
 - use && and || or to check multiple conditions*/
var score = 85
if score > 80 {
    print("Great job!")
}
let place = "Metropolis"

let day = 5
print("My true love gave to me…")

/*||If statements||
 - use fallthrough if want to do the next case as well - usually not used*/
switch day {
case 5:
    print("5 golden rings")
    fallthrough //continue to next case - don't used commonly
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 French hens")
    fallthrough
case 2:
    print("2 turtle doves")
    fallthrough
default:
    print("A partridge in a pear tree")
}

/*||Ternanary operator||
 - operates on three pieces of data at a itme - others are binary
 - condensed form of if-else
 - mnemonic: What? True  : False (WTF)*/
let age = 18
var canVote = age >= 18 ? "yes" : "no"
let names = ["Kaylee", "Joe", "Dan"]
print(names.isEmpty ? "No one" : "\(names.count) people")

//---------------------LOOPS-----------------------
/*||For Loops||
 - can loop through everything in array, or loop through fixed number
 - range like in for loop is unique data type
 - inclusive range 1...5
 - exclude last range 1..<5 - used for array looping */
let platforms = ["iOS", "macOS", "tvOS", "watchOS"]
for os in platforms {
    print("Swift works great on \(os).")
}
for i in 1...12 {  //range [1, 12]
    print("This is the \(i) times table")
    for j in 1...12 {
        print("\(i) x \(j) = \(i * j)")
    }
    print()
}
for i in 1..<5 {
    print("\(i)")
}
for _ in 1...5 {  //used when you don't need a variable
    print("hey")
}

/*||While Loops||
- runs until condition becomes false
- less common and less useful
- used when we don't know when to stop */
var roll = 0
while roll != 20 {
    roll = Int.random(in: 1...20)
    print("I rolled \(roll)")
}

/*||Continue and Break||
 - continue: continues to next loop iteration and doesn't do anything else in current iteration
 - breal: skips all next loop iterations*/
let filenames = ["me.jpg", "work.txt", "hw.jpg"]
for filename in filenames {
    if (!filename.hasSuffix(".jpg")) {
        continue  //continues to next loop iteration
    }
    print("found picture \(filename)")
}
//print first 10 multiples
let number1 = 4
let number2 = 14
var multiples = [Int]()
for i in 1...100_000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)

        if multiples.count == 10 {
            break //skips all next loop iterations
        }
    }
}
print(multiples)

//---------------------FUNCTIONS-----------------------
/*||functions||
 - used to reuse code - so we don't have copypasta error
 - parameters in function are placeholders
 - arguments are actual values used when calling
 - return multiple value using tuples - fixed size and can have a variety of data types*/
func printTimesTables(number: Int, end: Int) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}
printTimesTables(number: 5, end: 20)
func rollDice() -> Int {
    return Int.random(in: 1...6)
}

let result = rollDice()
print(result)

func isUppercase(string: String) -> Bool {
    string == string.uppercased()
}
print(isUppercase(string: "Hello"))
/*- with dictionaries, Swift doesn't know that dictionary key is present - need default
 - when going to access tuple values, Swift knows it will be there
 - dictionary may contain arbitrary number of values
 - distinguish functions by parameters*/
func getUser() -> (firstName: String, lastName: String) {
    ("Taylor", "Swift")
}
let user = getUser()
print("Name: \(user.firstName) \(user.lastName)")
func getUser1() -> (String, String) {   //tuple without names - use index
    ("Taylor", "Swift")
}
let user1 = getUser1()
print("hi \(user1.0)")
let (firstName, _) = getUser1() //destructuring, use _ if you don't need one of the value
print("\(firstName)")
/*customize parameter labels so that you don't need to specifiy name when calling*/
func isLowercase(_ string: String) -> Bool {
    string == string.lowercased()
}
print("\(isLowercase("hi"))")
//can use different parameter names for internal vs external use
//use default values for parameters when it makes sense
func printTimesTable(for number: Int = 1) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}
printTimesTable(for: 5)
printTimesTable()
/*||Throwing and Handling errors||
 - build enum for errors
 - immediately terminate if you reach error
 - throws means function may throw error*/
enum PasswordError: Error {
    case short, obvious
}
func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }
    if password == "12345" {
        throw PasswordError.obvious
    }
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}
let password = "12345"
//try must be written before any throwing functions called
do {
    let result = try checkPassword(password) //if error, skip to catch
    print("\(result)")
} catch PasswordError.short {
    print("That's way too short")
} catch {
    print("There was an error \(error.localizedDescription)") //description useful for apple errors
}
//checkpoint 4
enum sqrtError: Error {
    case OutOfBounds, NoRoot
}
func squareRoot(_ num: Int) throws -> Int {
    if num < 1 || num > 10000 {
        throw sqrtError.OutOfBounds
    }
    for i in 1...100 {
        if (i * i == num) {
            return i
        }
    }
    throw sqrtError.NoRoot
}
do {
    let answer = try squareRoot(6)
    print("\(answer)")
} catch sqrtError.NoRoot {
    print("Error")
} catch sqrtError.OutOfBounds {
    print("Error")
}
