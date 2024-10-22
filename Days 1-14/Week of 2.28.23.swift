//Week of 2.28.23 - Days 9 to 13
import UIKit
import Foundation

//-----------------------------------------------CLOSURES----------------------------------------------------
/*||Closures||
 - function copy works just like function but without external parameter names
 - functions have types based on parameter and return types
 - closure: a chunk of code we can pass around and call whenever we want
 - doesn't have parameter names for closures
 - function copies are similar to closures in this way
 - anywhere you can pass a function, you can pass a closure
 - if a function's parameters are functions, use trailing closure syntax
 */
func greetUser() {
    print("hi there")
}
greetUser()
let greetCopy = greetUser //don't use paranthese if you want to copy whole function
greetCopy()
//if you don't want to make function first, you can let constant do the function work
let sayHello = { (name: String) -> String in  //in keywork marks the end of parameter and return type and begin closure
    "Hi \(name)!"
}
sayHello("Taylor")
//modify sort function by passing in a function - sort compares two things at a time: true or false for sorted
let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)
/*func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    else {
        return name1 < name2
    }
}
let captainFirstTeam = team.sorted(by: captainFirstSorted(name1:name2:))
print(captainFirstTeam)*/
//same thing as above but with closure - sort and assign as variable at same time
//don't need to specify paramter or return type because need to be (name1: String, name2: String) -> Bool
let captainFirstTeam = team.sorted {name1, name2 in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
} //can change first parameter to $0 and second to $1 - shorthand syntax
print(captainFirstTeam)
let reverseTeam = team.sorted { $0 > $1 }
let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)
let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)
//function accepting function as parameter
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()

    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }

    return numbers
}
//rewrite above using closure
let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}
func generateNumber() -> Int {
    Int.random(in: 1...20)
}
let newRolls = makeArray(size: 50, using: generateNumber)
print(newRolls)

//accepting functions as parameters
func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}
doImportantWork {
    print("This is the first work")
} second: {
    print("This is the second work")
} third: {
    print("This is the third work")
}

/*||Checkpoint 5||*/
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
func luckyNum(luckyNumFilt: ([Int]) -> [Int], luckyNumMap: ([Int]) -> Void) {
    var x = luckyNumFilt(luckyNumbers)
    x = x.sorted()
    luckyNumMap(x)
}
let luckyNumFilt = luckyNumbers.filter { int1 in
    if int1.isMultiple(of: 2) {
        return false
    } else {
        return true
    }
}
let luckyNumMap: [()] = luckyNumbers.map {int1 in
    print("\(int1) is a lucky number")
}

//--------------------------------------------------STRUCTS------------------------------------------------------
/*||Structs||
 - structs let us create our own custom, complex data types, complete with their own variables and their own functions
 - like an object
 - function name is in camelcase
 */
struct Album {
    let title: String
    let artist: String
    let year: Int

    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}
//Two album instances
let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title)
print(wings.artist)

red.printSummary()
wings.printSummary()
//function can't change variables in the struct - constant instance
//if you want to make a function that can change the data in the struct, you have to make it a mutating fucntion

struct Employee {
    //properties
    let name: String //can set constant to a default it must always be
    var vacationRemaining: Int = 30 //changeable
    //methods
    mutating func takeVacation(days: Int) -> Void {
        if vacationRemaining >= days {
            print("I'm on vacation!")
            vacationRemaining -= days
            print("I have \(vacationRemaining) vacation days left")
        } else {
            print("not enough vacation days left")
        }
    }
}

/*||Getters and Setters||*/
//if you want to call a mutating function, you must use var keyword
var james = Employee(name: "james", vacationRemaining: 14) //initializer
james.takeVacation(days: 5)
struct NewEmployee {
    let name: String
    var vacationAllocated: Int
    var vacationTaken = 0
    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }
        
        set { //newValue autimatically recognized in setter
            vacationAllocated = vacationTaken + newValue
        }
    }
}
var archer = NewEmployee(name: "Sterling Archer", vacationAllocated: 28)
archer.vacationTaken += 4
archer.vacationRemaining = 8 //calls vacation remaining setter
print(archer.vacationAllocated)

/*||Property Observers||
 - didSet = runs whenever you set the var, Swift automatically provides the constant oldValue inside didSet
 - willSet = runs some code before the property changes, provides the newValue
 - didSet is more common */
struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }

        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")

/*||Custom Initializers||
 - like constructors
 - initializers never explicitly have a return type – they always return the type of data they belong to
 - normal initializer is provided - memberwise initializer
 - after initializing, all properties must be initialized
 - if you make custom initializer, builtin way goes away*/
struct Player {
    let name: String
    let number: Int

    init(name: String) {
        self.name = name
        number = Int.random(in: 1...99)
    }
}

let player = Player(name: "Megan R")
print(player.number)

/*||Access Control||
 - private: “don’t let anything outside the struct use this.”
 - fileprivate: “don’t let anything outside the current file use this.”
 - public: “let anyone, anywhere use this.”
 - private(set): “let anyone read this property, but only let my methods write it.”
 - if private property, likely need custom initializer*/
struct BankAccount {
    private(set) var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}
var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)
if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}

/*||Static vs. Non-static types||
 - used when you want to add a property/method to struct itself, rather than to one instance of struct
 - can't read nonstatic from static
 - can read static from nonstatic - School.schoulCount - Self.schoolCount
 - self = value of struct
 - Self = type of struct */
struct School {
    static var studentCount = 0

    static func add(student: String) { //don't need mutating because no instance - need mututating if you might have constant or variable instances
        print("\(student) joined the school.")
        studentCount += 1
    }
}
School.add(student: "Taylor Swift") //note: don't need to create instance of school because adding student to School struct
print(School.studentCount)

//really helpful for examples
struct User {
    let username: String
    let password: String

    static let example = User(username: "cfederighi", password: "hairforceone")
}

/*||Checkpoint 6||*/
struct Car {
    let seats: Int
    let model: Int
    private(set) var gear: Int
    init(seats: Int, model: Int, gear: Int) {
        self.seats = seats
        self.model = model
        if (gear > 10 || gear < 1) {
            print("invalid gear")
        }
        self.gear = gear
    }
    mutating func gearUp(num: Int) {
        if gear + num > 10 {
            print("can't do that")
        } else {
            gear += num
        }
    }
    mutating func gearDown(num: Int) {
        if gear + num < 1 {
            print("can't do that")
        } else {
            gear = num
        }
    }
}
var toyota = Car(seats: 5, model: 2007, gear: 5)
print("gear: \(toyota.gear)")
toyota.gearUp(num: 2)
print("gear: \(toyota.gear)")

//--------------------------------------------------CLASSES------------------------------------------------------
/*||Classes||
 - String, Int, Double, and Array are made of STRUCTS
 - classes allow inheritance
 - classes don't have memberwise inheritance - write your own initializer, or assign default values to all your properties
 - if you copy an instance of a class, both copies share the same data***
 - change one copy, other also changes
 - deinitializer: optional when final instance of class is destroyed
 - even if class is constant, you can still change its properties as long as they are vars */
class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10

/*||Inheritance||*/
class Worker {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}
//developer and manager can both use hours because they inherit from Worker
final class Developer: Worker { //final class can't be inherited from - try to make them final by default
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
    }
}
class Manager: Worker {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}
let novall = Developer(hours: 8)
novall.printSummary()

/*||Class Initializers||
 - initialize for self, then for parent
 - if child doesn't have initializer, it will inherit from parent - child can just have default val*/
class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}
class CarV: Vehicle {
    let isConvertible: Bool

    init(isElectric: Bool, isConvertible: Bool) { //need to initialize parent properties using super
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}
let teslaX = CarV(isElectric: true, isConvertible: false)

/*||Copying Classes||
 - allows us to share common data in lots of parts of the code
 - reminder that structs do not share data*/
class User1 {
    var username = "Anonymous"
    func copy() -> User1 { //creates a deep copy
        let user = User1()
        user.username = username
        return user
    }
}
var user1 = User1()
var user2 = user1
user2.username = "Taylor"
print(user1.username)
print(user2.username)
var user3 = user1.copy()
user3.username = "Jason"
print(user1.username)
print(user3.username)

/*||Creating a deinitializer||
 - called when object is destroyed
 - don't use func keyword
 - never take parameters, don't return anything
 - structs don't have deiniitalizer
 - when struct is done, data destroyed
 - for classes, only one copy of the data is destoyed, but when the final copy is destroyed, goes back to system
 - deinit called when called when the last remaining reference to A CLASS INSTANCE is destroyed*/
class Person {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}
for i in 1...3 {
    let user = Person(id: i)
    print("User \(user.id): I'm in control!")
}

/*||Variables inside classes||
 - think of creating instance as creating a sign pointing to the class
 - if constant, pointer remains same, but data in class can change
 - Constant instance, constant property – a signpost that always points to the same user, who always has the same name.
 - Constant instance, variable property – a signpost that always points to the same user, but their name can change.
 - Variable instance, constant property – a signpost that can point to different users, but their names never change.
 - Variable instance, variable property – a signpost that can point to different users, and those users can also change their names.
 - classes don't need mutating keyword*/
class Human {
    var name = "Paul"
}
var userx = Human()
userx.name = "Taylor"
userx = Human() //create new Human, changes pointer
print(userx.name)

/*||Checkpoint 7||*/
class Animal {
    var legs = 4
}
class Dog: Animal {
    func speak(){
        print("bark")
    }
}
class Corgi: Dog {
    override func speak() {
        print("corgi bark")
    }
}
class Poodle: Dog {
    override func speak() {
        print("poodle bark")
    }
}
class Cat: Animal {
    let isTame: Bool
    init(tame: Bool) {
        isTame = tame
    }
    func speak(){
        print("bark")
    }
}
class Persian: Cat {
    override func speak() {
        print("persian meow")
    }
}
class Lion: Cat {
    override func speak() {
        print("roar")
    }
}
let corgi = Corgi()
corgi.speak()
let lion = Lion(tame: false)
lion.speak()

//-----------------------------------------------PROTOCOLS AND EXTENSIONS---------------------------------------------------
/*||Protocols||
 - let us define methods and properties
 - don't implement
 - like blueprint
 - no function body
 - we adopt to the protocol
 - can conform to as many protocols as you want*/
protocol Transportation {
    var name: String { get } //read only
    var currentPassengers: Int { get set } //read and write
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}
struct MiniVan: Transportation {
    var name = "MiniVan"
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }

    func openSunroof() {
        print("It's a nice day!")
    }
}
struct Bicycle: Transportation {
    var name = "Bike"
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }

    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}

func commute(distance: Int, using vehicle: Transportation) { //using Transportation allows it to wokr with any transportation
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

func getTravelEstimates(using vehicles: [Transportation], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}

let mini = MiniVan()
commute(distance: 100, using: mini)
var bike = Bicycle()
commute(distance: 50, using: bike)
bike.currentPassengers = 3

getTravelEstimates(using: [mini, bike], distance: 150)

/*||Opaque Return Types||
 - quatable protocol allows us to use == */
func getRandomNumber() -> some Equatable { //makes an equatable
    Int.random(in: 1...6) //changing to double still works, allows us to change type
}
func getRandomBool() -> some Equatable {
    Bool.random()
}
print(getRandomNumber() == getRandomNumber())

/*||Extensions||
 - Extensions let us add functionality to any type, whether we created it or someone else created it – even one of Apple’s own types.
 */
var quote = "   The truth is rarely pure and never simple   "
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines) //long to write - create extension

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}
extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}
