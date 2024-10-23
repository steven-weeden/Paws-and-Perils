Just a Reminder for those who forgot how to push this with Git like I did:

Make sure that Updates are sent to your correct Branch!
To Check the Branches you have
- git branch
To Create a new branch and switch to it
- git checkout -b "Name of Branch"

Make sure to be in the right Directory first with change directory
- cd "destination"

To add folders to your push attempt
- git add <folder-name>
- git add <file-name> | git add example.txt
- git add .   // This will add everything that is in the folder. 

You can add a comment to your push if you use Commit
- git commit -m "Example text"

To finally push that data into your branch or main
- git push origin // This will push into main
- git push origin "branch name" // This will push into your Branch
