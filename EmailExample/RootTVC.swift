//
//  RootTVC.swift
//  EmailExample
//
//  Created by Emily Byrne on 9/18/17.
//  Copyright © 2017 Byrne. All rights reserved.
//

import UIKit

protocol CellSelectedDelegate {
    func read(email: Email)
}

class RootTVC: UITableViewController {
    
    var emails = [Email]()
    var delegate: CellSelectedDelegate?
    var num: String = ""
    var dataDictionary1: [String:Array<Email>] = [:]
    var addButton:UIBarButtonItem = UIBarButtonItem()
    var subjectEmail: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if num == "Inbox" {
            self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
        
        if num == "Sent" {
            addButton.title = "+"
            addButton.action = #selector(addButtonHit)
            self.navigationItem.rightBarButtonItem = addButton
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    func addButtonHit(_ button:UIBarButtonItem!){
        print("Done clicked")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emails.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: react to user selecting row
        //I want the detail view controller to update based on the row that I selected
        
        let selectedEmail = emails[indexPath.row]
        delegate?.read(email: selectedEmail)
        subjectEmail = selectedEmail.subject
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let currentEmail = emails[indexPath.row]
        cell.textLabel?.text = currentEmail.subject
        cell.detailTextLabel?.text = currentEmail.sender
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                let emailDeleted = emails[indexPath.row]
                layer.dataDictionary["Inbox"]?.remove(at: indexPath.row)
                layer.dataDictionary["Trash"]?.insert(emailDeleted, at: 1)
                emails.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                //dataDictionary1 = ["Inbox": [], "Sent":[Email(sender: "prof@asu.edu", subject: "Homework", contents: "Hi turn it in please")], "Trash":[Email(sender: "alert@asu.edu", subject: "Bees", contents: "Hi help me please there are bees"),Email(sender: "fellow.student@asu.edu", subject: "Project Question", contents: "Hi help me please")]]
                //layer.dataDictionary = dataDictionary1
                
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
