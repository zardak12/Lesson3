import UIKit

//MARK: - Реализация COW

final class ReferenceType<T> { // задает свойство reference type
    var value : T
    init(value : T) {
        self.value = value
    }
}

struct Container<T> {
    private var myReference : ReferenceType<T>
    init(value : T) {
        myReference = ReferenceType(value: value)
    }
    
    var containerValue : T {
        get{return myReference.value}
        set{
            guard isKnownUniquelyReferenced(&myReference) else { // если сильная сылка одна, то вернет True, иначе False и выполнит, то что лежит в else
                myReference = ReferenceType(value: newValue)
                return
            }
            myReference.value = newValue
        }
    }
}

//MARK: - Пример использования

struct MyStruct {
    var names = [String]()
}

let names = MyStruct(names: ["Deniz","Mark","Aleksandr","Petr","John"])
var containerFirst = Container(value: names)
var containerSecond = Container(value: names)
containerSecond.containerValue.names.removeLast()
print("Старый список имен :\(containerFirst.containerValue.names)\nCписок имен после изменений:\(containerSecond.containerValue.names)")
