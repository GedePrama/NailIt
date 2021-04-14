//
//  ListOfQuestionTableViewController.swift
//  Nailit
//
//  Created by Gede Wicaksana on 11/04/21.
//

import UIKit
import CoreData

class ListOfQuestionTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayListofQuestion = [ListOfQuestion]()
    var category = ""
    var categoryDetail = ""
    let userDefaultValue = UserDefaults.standard.getValueLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEverything()
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.title = categoryDetail
    }

    
    
    // MARK: - Manipulation Data Source
    
    func saveItems(){
        do {
            try context.save()
        } catch {
            print("Error saving content: \(error)")
        }
    }
    
    func inserItem(category: String, categoryDetail: String, question: String, questionDetail1: String, questionDetail2: String, video: String){
        let newItem = ListOfQuestion(context: context)
        newItem.category = category
        newItem.categoryDetail = categoryDetail
        newItem.question = question
        newItem.questionDetail1 = questionDetail1
        newItem.questionDetail2 = questionDetail2
        newItem.video = video
        newItem.bookmark = false
        newItem.notes = ""
        arrayListofQuestion.append(newItem)
        saveItems()
    }
    
    func loadItems(with request: NSFetchRequest<ListOfQuestion> = ListOfQuestion.fetchRequest(), predicate: NSPredicate! = nil){
        let categoryPredicate = NSPredicate(format: "category MATCHES %@", category)
        let categoryDetailPredicate = NSPredicate(format: "categoryDetail MATCHES %@", categoryDetail)
        if predicate != nil{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, categoryDetailPredicate, predicate])
        } else{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, categoryDetailPredicate])
        }

        request.sortDescriptors = [NSSortDescriptor(key: "question", ascending: true)]

        do {
            arrayListofQuestion = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayListofQuestion.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfQuestionCell", for: indexPath)
        cell.textLabel?.text = arrayListofQuestion[indexPath.row].question
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = storyboard?.instantiateViewController(identifier: "QuestionDetailViewController") as? QuestionDetailViewController
        cell?.question = arrayListofQuestion[indexPath.row].question!
        cell?.questionDetail1 = arrayListofQuestion[indexPath.row].questionDetail1!
        cell?.questionDetail2 = arrayListofQuestion[indexPath.row].questionDetail2!
        cell?.bookmark = arrayListofQuestion[indexPath.row].bookmark
        self.navigationController?.pushViewController(cell!, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       navigationController?.navigationBar.prefersLargeTitles = true

       let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.blue]

        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2509803922, green: 0.3137254902, blue: 0.7098039216, alpha: 1)
       navigationController?.navigationBar.standardAppearance = appearance
       navigationController?.navigationBar.compactAppearance = appearance
       navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    // MARK: - Load Data
    
    func loadEverything(){
        if userDefaultValue == nil{
            //MARK : Swift
                inserItem(category: "Technical", categoryDetail: "Swift", question: "Elaborate on the differences between Swift and Objective-C", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Swift", question: "What is PLIST in iOS?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Swift", question: "Who calls the main function of our app during the app launch cycle?", questionDetail1: "", questionDetail2: "", video: "")
                
                inserItem(category: "Technical", categoryDetail: "Swift", question: "Which JSON framework is supported by iOS?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Swift", question: "What is a Protocol in swift?", questionDetail1: "The protocol is a very common feature of the Swift programming language and the protocol is a concept that is similar to an interface from java. A protocol defines a blueprint of properties, methods, and other requirements that are suitable for a particular task.\n\nIn its simplest form, the protocol is an interface that describes some methods and properties. The protocol is just described as the properties or methods skeleton instead of implementation. Properties and methods implementation can be done by defining enumerations, functions, and classes.\n\nProtocols are declared after the structure, enumeration or class type names. A single and multiple protocol declaration can be possible. Multiple protocols are separated by commas.", questionDetail2: "We can define a protocol in a way that is very similar to structures, enumerations, and classes:\n\nProtocol Someprotocol\n\n{\n// protocol definition goes here\n}\n\nWe can define multiple protocols, which are separated by commas:\n\nClass SomeClass: SomeSuperclass, Firstprotocol, Secondprotocol\n{\n// Structure definition goes here\n}", video: "")

                inserItem(category: "Technical", categoryDetail: "Swift", question: "What is the use of double question mark “??” in swift?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Swift", question: "What is Optional chaining?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Swift", question: "What mechanism does iOS support for multi-threading?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Swift", question: "What are the different ways to pass data in swift?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Swift", question: "Explain the usage of Class and benefits of Inheritance.", questionDetail1: "", questionDetail2: "", video: "")



            //MARK : Python
                inserItem(category: "Technical", categoryDetail: "Python", question: "What is a dynamically typed language?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Python", question: "What are the pros of using Python?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Python", question: "What is a module and package in Python?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Python", question: "How do you generate random numbers in Python", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Python", question: "How can you make a Python Script executable on Unix?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Python", question: "Explain split() and join() functions in Python?", questionDetail1: "You can use split() function to split a string based on a delimiter to a list of strings.\nYou can use join() function to join a list of strings based on a delimiter to give a single string.\n\nstring = \"This is a string.”\nstring_list = string.split(' ') #delimiter is ‘space’ character or ‘ ‘\nprint(string_list) #output: ['This', 'is', 'a', 'string.’]\nprint(' '.join(string_list)) #output: This is a string.\n", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "How would you convert a string to all lower case?", question: "Apa itu Python", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "What is Flask and its benefits?", question: "Apa itu Python", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "How does Python manage memory?", question: "Apa itu Python", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "How can you convert a number to a string?", question: "Apa itu Python", questionDetail1: "", questionDetail2: "", video: "")
                


            //MARK : Java

                inserItem(category: "Technical", categoryDetail: "Java", question: "What is the importance of the main() method in Java?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Java", question: "What do you understand about copy constructor in Java?", questionDetail1: "", questionDetail2: "", video: "")
                
                inserItem(category: "Technical", categoryDetail: "Java", question: "What is the final Keyword in Java?", questionDetail1: "", questionDetail2: "", video: "")
                
                inserItem(category: "Technical", categoryDetail: "Java", question: "Why does Java not support pointers?", questionDetail1: "", questionDetail2: "", video: "")
                
                inserItem(category: "Technical", categoryDetail: "Java", question: "What is the Java timer class? How to schedule a task to run after the specific interval?", questionDetail1: "", questionDetail2: "", video: "")
                
                inserItem(category: "Technical", categoryDetail: "Java", question: "What is the volatile keyword in Java?", questionDetail1: "", questionDetail2: "", video: "")
                
                inserItem(category: "Technical", categoryDetail: "Java", question: "What is Enum in Java?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Java", question: "What are the differences between the constructors and methods?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Java", question: "What are the restrictions that are applied to the Java static methods?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "Technical", categoryDetail: "Java", question: "How many types of constructors are used in Java?", questionDetail1: "", questionDetail2: "", video: "")



            //MARK : Character

                inserItem(category: "General", categoryDetail: "Character", question: "If you could change one thing about your personality, what would it be?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Character", question: "Tell me about a stressful scenario in the past and how you handled it.", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Character", question: "What hobbies or sports are you involved with outside of work, and why do you enjoy them?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Character", question: "Can you tell me about a time when you went above and beyond in your job?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Character", question: "What drives you in your professional life?", questionDetail1: "", questionDetail2: "", video: "")

            inserItem(category: "General", categoryDetail: "Character", question: "What makes you unique?", questionDetail1: "This question can enable you to highlight the skills and characteristics that you appreciate about yourself. You can choose traits that apply to the job you're applying for as well as set you apart from other candidates.", questionDetail2: "Example: \"I feel that my strong attention to detail and the ability to pick out inconsistencies will bring tremendous value to my role as your Copy Editor. This position requires a keen eye to be able to edit large amounts of content regularly. Not only will this ability benefit my next job, but it has proved useful in previous jobs as well.\n\n\"During my role as a Blog Manager for Nutrient Dense, I identified a spelling error in a vitamin brand's ingredient on the company website. It turned out that all the writers were misspelling the ingredient because that was simply the way it was spelled on the vitamin bottle. My boss notified the vitamin company and thanked me for taking the extra time to spellcheck blog content, particularly the content that previous editors assumed was correct.\"", video: "")

                inserItem(category: "General", categoryDetail: "Character", question: "TDescribe a time when you dealt with change?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Character", question: "What motivates you?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Character", question: "How do you define success?.", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Character", question: "How would you describe yourself?", questionDetail1: "", questionDetail2: "", video: "")



            //MARK : Experience

                inserItem(category: "General", categoryDetail: "Experience", question: "What work experience do you have that prepares you for this position?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Experience", question: "How does your work experience qualify you for this position?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Experience", question: "Who was your best boss, and who was the worst? Why?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Experience", question: "What do you think you’ll like most about this job? And what do you think you’ll dislike?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Experience", question: "What is the professional achievement you’re most proud of?", questionDetail1: "This is another version of the “Why should we hire you” question, but with a focus on one very specific achievement. This one’s pretty straightforward, just mention your #1 professional achievement and you’re good to go.", questionDetail2: "As a given, the achievement has to be related to the job you’re applying for. Let’s say you’re applying for the position of Sales Manager:\n\n[Incorrect Example]\n“I’m very good at underwater basket-weaving, having woven 20+ baskets in the past year.”\n\n[Correct Example]\n“In my previous sales position, I managed to hit and exceed department KPIs by 50%+ for 6 months in a row”\n\nKeep in mind, though, that you want to be very specific with your answer. To get this right, try using the STAR method. It goes something like this:\n\nS: Situation - Set the scene and context.\n\nT: Task - Describe what your challenge or responsibility was.\n\nA: Action - List and dwell on all the actions you took towards addressing the challenge or responsibility.\n\nR: Result - Explain what the outcomes were and how they fit with the overall goal of the project or company.\n\nSo, find a work-related achievement that showcases your contribution through your skills and experience to something that matters to the company.", video: "")

                inserItem(category: "General", categoryDetail: "Experience", question: "Why have you switched jobs so many times?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Experience", question: "Why were you fired?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Experience", question: "Do you think you’re qualified for this job?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Experience", question: "Can you walk me through your resume?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Experience", question: "What are your salary requirements?", questionDetail1: "", questionDetail2: "", video: "")


            //MARK : Company

                inserItem(category: "General", categoryDetail: "Company", question: "Why Do You Want to Work at This Company?", questionDetail1: "Beware of generic answers! If what you say can apply to a whole slew of other companies, or if your response makes you sound like every other candidate, you’re missing an opportunity to stand out. Zhang recommends one of four strategies: Do your research and point to something that makes the company unique that really appeals to you; talk about how you’ve watched the company grow and change since you first heard of it; focus on the organization’s opportunities for future growth and how you can contribute to it; or share what’s gotten you excited from your interactions with employees so far. Whichever route you choose, make sure to be specific. And if you can’t figure out why you’d want to work at the company you’re interviewing with by the time you’re well into the hiring process? It might be a red flag telling you that this position is not the right fit", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Company", question: "Why Do You Want This Job?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Company", question: "Why Should We Hire You?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Company", question: "What Type of Work Environment Do You Prefer?", questionDetail1: "", questionDetail2: "", video: "")
                
                inserItem(category: "General", categoryDetail: "Company", question: "What are your salary expectations?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Company", question: "Do you have any questions for me?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Company", question: "What are the most important things you are looking for in your next role?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Company", question: "Are You Planning on Having Children?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Company", question: "How Do You Like to Be Managed?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Company", question: "What Do You Think We Could Do Better or Differently?", questionDetail1: "", questionDetail2: "", video: "")


            //MARK : Skill

                inserItem(category: "General", categoryDetail: "Skill", question: "How did you gain the technical knowledge you need to do your job?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Skill", question: "Can you tell me about a time when you successfully led a team through a sticky situation?", questionDetail1: "With any behavioral interview question, you want to be sure to provide enough detail. It’s important that you set the scene for your interviewer so that he or she has enough context to truly appreciate your answer.", questionDetail2: "For this response in particular, make sure you pick a scenario that actually was both challenging and meaningful and then provide two or three tactical things you did to navigate your team through it. That could look something like this:\n\nOur design team received some rather brutal feedback from a client, and everybody was feeling pretty disheartened about the amount of work we had already put in.\n\nInstead of allowing my peers to continue to wallow, I organized a meeting where we could all sit down and hash out the client’s revisions together and make sure we were all on the same page about what was being requested.\n\nPrior to that meeting, I also created a more digestible breakdown of the client’s requests and gathered the relevant resources to ensure that we had everything we needed to knock those changes out. Everybody left that meeting feeling far more accomplished and satisfied with our progress.", video: "")

                inserItem(category: "General", categoryDetail: "Skill", question: "How do you keep informed about what’s happening in your field?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Skill", question: "Give me an example of an especially difficult assignment or project.  What was your role?  What did you do?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Skill", question: "Have you received any commendations for your performance?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Skill", question: "Can you walk me through your process of how you’d explain a complex topic to someone who was unfamiliar?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Skill", question: "What have you done to make your group work more smoothly and efficiently?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Skill", question: "Describe the procedures you have used to keep track of things that require your attention", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Skill", question: "What job-related publications do you normally read?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Skill", question: "How do you cope when you have too much work on your plate?", questionDetail1: "", questionDetail2: "", video: "")


            //MARK :  Teamwork

                inserItem(category: "General", categoryDetail: "Teamwork", question: "Describe a time when you worked well as part of a team", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Teamwork", question: "How do you get team members to accept your thoughts?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Teamwork", question: "Can you tell me about a time when a lack of teamwork hindered a project? How did you address the situation?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Teamwork", question: "Do you prefer to work as part of a team or independently?", questionDetail1: "Admittedly, in the land of teamwork interview questions, this one’s a little roundabout. It isn’t directly asking about your teamwork capabilities. Instead, it focuses on your preferences.\n\nBut how you answer matters. If you focus a ton of your reply on your desire to work independently, the hiring manager may doubt your ability to excel in a team-oriented environment. That’s why you need to handle this question tactfully.", questionDetail2: "Example answer : \n“I enjoy splitting my time between working as part of a team and working independently. In my past positions, for solving problems and handling large projects, being part of a group was usually beneficial. It spurred creativity and innovation while also ensuring access to a larger cumulative skillset. At times, I found that detail-oriented tasks with highly defined processes were better accomplished independently, as it made maintaining focus easier. Each approach has its place, so I embrace them both depending on the situation at hand.”", video: "")

                inserItem(category: "General", categoryDetail: "Teamwork", question: "If a team member was disengaged, what would you do to motivate them?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Teamwork", question: "What will you do when you disagreed with a team member?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Teamwork", question: "How do you make sure that team members get credit for their contributions?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Teamwork", question: "What do you mean by the strong team??", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Teamwork", question: "When to give someone feedback?", questionDetail1: "", questionDetail2: "", video: "")

                inserItem(category: "General", categoryDetail: "Teamwork", question: "Describe a challenging workplace situation. How did you deal with it?", questionDetail1: "", questionDetail2: "", video: "")
            UserDefaults.standard.setValueLoad(value: true)
        }
        loadItems()
    }
    
    
    
}


extension ListOfQuestionTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<ListOfQuestion> = ListOfQuestion.fetchRequest()
        let searchPredicate = NSPredicate(format: "question CONTAINS[cd] %@", searchBar.text!)
        loadItems(with: request, predicate: searchPredicate)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
