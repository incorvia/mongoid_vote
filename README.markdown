Mongoid Voit - mongoid_vote
========

Developed by: Kevin Incorvia  
Start Date: Dec 2, 2011  


Description
-----------
A very basic voting gem for mongoid.  


Installation
-----------
Simply include in your document model: 

include MongoidVote::Voteable


Usage Examples:
-----------
vote up: @comment.vote(@user, "up")
vote down: @comment.vote(@user, "down")

vote count: @comment.votes["count"]
vote up count: @comment.votes["up_count"]
vote down count: @comment.votes["down_count"]

list of up votes: @comment.votes["up"]
list of down votes: @comment.votes["up"]


Notes:
-----------
Currently only allows one vote per object.  If a user had previously voted 'up' an object, the ensuing vote would remove their previous vote and add a down vote instead. 