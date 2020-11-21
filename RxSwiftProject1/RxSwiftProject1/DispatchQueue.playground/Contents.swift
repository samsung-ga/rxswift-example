import UIKit

let serialQueue = DispatchQueue(label: "serialQueue")

serialQueue.async {
    print("Task1 Done")
}
print("Task2 Done")

serialQueue.sync {
    print("Task3 Done")
}
print("Task4 Done")
print("Task5 Done")

let concurrentQueue = DispatchQueue(label: "conCurrentQueue", attributes: .concurrent)

concurrentQueue.async {
    print("Task1 Done")
}
print("Task2 Done")

concurrentQueue.sync {
    print("Task3 Done")
}
print("Task4 Done")
print("Task5 Done")
