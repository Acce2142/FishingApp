//
//  CoreDataManage.swift
//  FishProduct
//

//

import UIKit
import CoreData

class CoreDataManage: NSObject {
    static let instance: CoreDataManage = CoreDataManage()
    class func sharedCoreData() -> CoreDataManage {
        return instance
    }
    func SearchQuestionByID(id:String) -> [Questions] {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let request:NSFetchRequest = Questions.fetchRequest()
        let pre :NSPredicate = NSPredicate.init(format: "questionid = %@", id)
        request.predicate = pre
        do{
            let fetchedObjects =  try context.fetch(request)
            return fetchedObjects
        }catch{
            fatalError("query fail")
        }
        return []
    }
    func InsertQuestion(q:QuestionModel?) {
        if q == nil {
            
            return
        }
        let app = UIApplication.shared.delegate as! AppDelegate
        let arr :[Questions]  = SearchQuestionByID(id: (q?.id)!)
        let context = app.persistentContainer.viewContext
        if arr.count <= 0 {
            let question = NSEntityDescription.insertNewObject(forEntityName: "Questions", into: context) as! Questions
            question.questionid = q?.id
            question.question = q?.question
            question.response = q?.responses
        }
        else{
            let question = arr[0]
            question.questionid = q?.id
            question.question = q?.question
            question.response = q?.responses
        }
        do {
            try context.save()
            print("save success！")
        } catch {
            fatalError("save fail：\(error)")
        }
    }
    func InsertrReport(report:ReportModel?){
        if report == nil{
            return
        }
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let newReport = NSEntityDescription.insertNewObject(forEntityName: "Report", into: context) as! Fish
    }
    func InsertFish(fish:FishModel?) {
        
        if fish == nil{
            return
        }
        
        let arr :[FishModel]  = SearchFishByName(fishName: (fish?.fish_name)!)
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        if arr.count <= 0 {
            let newFish = NSEntityDescription.insertNewObject(forEntityName: "Fish", into: context) as! Fish
            newFish.commonnames = (fish?.commonnames)!;
            newFish.fishdescription = (fish?.fish_description)!
            newFish.fishid = (fish?.fish_id)!
            newFish.image = (fish?.image)!
            newFish.name = (fish?.fish_name)!
            newFish.regions = (fish?.fish_regions)!
            newFish.restrictions = (fish?.fish_restriction)!
            newFish.scientificname = (fish?.scientificname)!
        }
        else{
            let newFish = arr[0]
            newFish.commonnames = (fish?.commonnames)!;
            newFish.fish_description = (fish?.fish_description)!
            newFish.fish_id = (fish?.fish_id)!
            newFish.image = (fish?.image)!
            newFish.fish_name = (fish?.fish_name)!
            newFish.fish_regions = (fish?.fish_regions)!
            newFish.fish_restriction = (fish?.fish_restriction)!
            newFish.scientificname = (fish?.scientificname)!
        }
        
        do {
            try context.save()
            print("save success！")
        } catch {
            fatalError("save fail：\(error)")
        }
    }
    
    func SearchFishByID(fishid:String) -> [FishModel] {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let request:NSFetchRequest = Fish.fetchRequest()
        let pre :NSPredicate = NSPredicate.init(format: "fishid = %@", fishid)
        request.predicate = pre
        
        do{
            let result =  try context.fetch(request)
            var arr :[FishModel] = [] as! [FishModel]
            
            for cf in result{
                arr.append(CoreFishToFishModel(cfish: cf))
            }
            return arr
        }catch{
            fatalError("query fail")
        }
        
        return []
    }
    
    func SearchFishByName(fishName:String) -> [FishModel] {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let request:NSFetchRequest = Fish.fetchRequest()
        let pre :NSPredicate = NSPredicate.init(format: "name = %@", fishName)
        request.predicate = pre
        
        do{
            let fetchedObjects =  try context.fetch(request)
            var arr :[FishModel] = [] as! [FishModel]
            
            for cf in fetchedObjects{
                arr.append(CoreFishToFishModel(cfish: cf))
            }
            print("query success")
            return arr
        }catch{
            print("query success")
        }
        
        return []
    }
    func FindAllFish() -> [FishModel] {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let request:NSFetchRequest = Fish.fetchRequest()
        
        do{
            let result =  try context.fetch(request)
            var arr :[FishModel] = [] as! [FishModel]
            for cf in result{
                arr.append(CoreFishToFishModel(cfish: cf))
            }
            return arr
        }catch{
            fatalError("query fail")
        }
        
        return []
    }
    func FindAllQuestions() -> [QuestionModel] {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let request:NSFetchRequest = Questions.fetchRequest()
        
        do{
            let result =  try context.fetch(request)
            var arr :[QuestionModel] = [] as! [QuestionModel]
            for cf in result{
                arr.append(CoreQuestionsToQuestionsModel(QUE: cf))
            }
            return arr
        }catch{
            fatalError("query fail")
        }
        
        return []
    }
    
    func SearchFishByKeyword(text:String) -> [FishModel] {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let request:NSFetchRequest = Fish.fetchRequest()
        let pre :NSPredicate = NSPredicate.init(format: "name CONTAINS %@", text)
        request.predicate = pre
        
        do{
            let result =  try context.fetch(request)
            var arr :[FishModel] = [] as! [FishModel]
            for cf in result{
                arr.append(CoreFishToFishModel(cfish: cf))
            }
            print("query success")
            return arr
        }catch{
            fatalError("query fail")
        }
        
        return []
    }
    
    func CoreFishToFishModel(cfish:Fish) -> FishModel {
        let fish = FishModel.init()
        fish.commonnames = cfish.commonnames!
        fish.fish_description = cfish.fishdescription!
        fish.fish_id = cfish.fishid!
        fish.image = cfish.image!
        fish.fish_name = cfish.name!
        fish.fish_regions = cfish.regions!
        fish.fish_restriction = cfish.restrictions!
        fish.scientificname = cfish.scientificname!
        return fish
    }
    func CoreQuestionsToQuestionsModel(QUE:Questions) -> QuestionModel {
        let QA = QuestionModel.init()
        QA.id = QUE.questionid!
        QA.question = QUE.question!
        QA.responses = QUE.response!
        return QA
    }
    
}
