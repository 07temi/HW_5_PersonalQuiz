//
//  ResultsViewController.swift
//  PersonalQuiz
//
//  Created by brubru on 20.12.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var youAreLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    
    var resultArray: [Answer]!
    
    //Перечитал массу статей по алгоритмам, понял что существует понятие сложности
    //не смог найти адекватной оценки тому или иному методу массива
    //поэтому действовал по интуиции))
    //Я могу ошибаться, но если производить подсчет результата вместе с нажатием на "Ответить"
    //то будет сильно проще. провозился со статьями и не успею так переделать((
    // П.С. Не судите строго, сам понимаю что наделал абы как(
    // И что если котиков например столько же сколько собачек, тоже не понял как дествовать

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youAreLabel.text = ("Вы - \(getCountAnimals(from: resultArray).rawValue)")
        definitionLabel.text = getCountAnimals(from: resultArray).definition
        
    }
}


// MARK: - Private methods

private func getCountAnimals (from answerArray: [Answer]) -> AnimalType {
    var resultDict: [AnimalType: Int] = [.cat: 0, .dog: 0, .rabbit: 0, .turtle: 0]
    
    for index in answerArray.indices {
        switch answerArray[index].type {
        case .cat:
            updateCountAnimals(forAnimalType: .cat, inputDict: &resultDict)
        case .dog:
            updateCountAnimals(forAnimalType: .dog, inputDict: &resultDict)
        case .rabbit:
            updateCountAnimals(forAnimalType: .rabbit, inputDict: &resultDict)
        default:
            updateCountAnimals(forAnimalType: .turtle, inputDict: &resultDict)
        }
    }
    // тут поиск максимума в словаре
    var maxValueType = AnimalType.cat
    var maxValueInt = 0
    
    for (animal, value) in resultDict {
        if maxValueInt < value {
            maxValueInt = value
            maxValueType = animal
        }
    }
    return maxValueType
}


private func updateCountAnimals(forAnimalType animalType: AnimalType, inputDict input: inout Dictionary<AnimalType, Int>) {
    guard var countAnimalType = input[animalType] else { return }
    countAnimalType += 1
    input.updateValue(countAnimalType, forKey: animalType)
}
