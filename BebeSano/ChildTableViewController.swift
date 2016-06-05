//
//  ChildTableViewController.swift
//  BebeSano
//
//  Created by César Gutiérrez Tapiador on 3/6/16.
//  Copyright © 2016 César Gutiérrez Tapiador. All rights reserved.
//

import UIKit

class ChildTableViewController: UITableViewController {
    
    // MARK: Properties
    var children = [Child]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        
        //Load data
        if let savedChildren = loadChildren() {
            children += savedChildren
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return children.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ChildTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ChildTableViewCell

        let child = children[indexPath.row]
        
        cell.nameLabel.text = child.name
        cell.photoImageView.image = child.photo
        if child.gender == Child.EGender.Male{
            cell.genderImageView.image = UIImage(named: "maleOn")
        }else if child.gender == Child.EGender.Female{
            cell.genderImageView.image = UIImage(named: "femaleOn")
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        cell.birthDate.text = dateFormatter.stringFromDate(child.birthDate)
        

        //Show round image
        cell.photoImageView.layer.cornerRadius = cell.photoImageView.frame.size.width / 2;
        cell.photoImageView.clipsToBounds = true;
        
        return cell
    }
    

    // MARK: - Navigation
    @IBAction func unwindToChildList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ChildViewController, child = sourceViewController.child {
            let newIndexPath = NSIndexPath(forRow: children.count, inSection: 0)
            children.append(child)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            //save data
            saveChildren()
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Show" {
            let percentileDetailViewController = segue.destinationViewController as! PercentileViewController
            
            // Get the cell that generated this segue.
            if let selectedChildCell = sender as? ChildTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedChildCell)!
                let selectedChild = children[indexPath.row]
                percentileDetailViewController.child = selectedChild
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new Child.")
        }
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            children.removeAtIndex(indexPath.row)
            //save data
            saveChildren()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // MARK: NSCoding
    //Save data
    func saveChildren() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(children, toFile: Child.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save childern...")
        }
    }
    //load data
    func loadChildren() -> [Child]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Child.ArchiveURL.path!) as? [Child]
    }

}
