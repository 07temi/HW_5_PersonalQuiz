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
    
    //Готово 1. Передать сюда массив с ответами
    //Готово 2. Определить наиболее часто встречающийся тип животного
    //Готово 3. Отобразить результат в соответсвии с этим живтным
    // 4. Избавится от кнопки возврата назад на экран результатов

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
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
