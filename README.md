# bookmark-manager

# User stories
```
As a user 
I can see all of my bookmarks
I want a page that displays the bookmarks

As a time-pressed user
So that I can save a website
I would like to add the site's address and title to bookmark manager

As a user 
So that I can view bookmarks I've added
I would like to add a new bookmark
```

# Domain model
![Image of a basic domain model](https://raw.githubusercontent.com/samcolson4/bookmark-manager/master/images/domain_model_1.png)

# DB set up

 Connect to `psql` and create the `bookmark_manager` database:

 ```
 CREATE DATABASE bookmark_manager;
 ```

 To set up the appropriate tables, connect to the database in `psql` and run the SQL scripts in the `db/migrations` folder in the given order.

# For testing

Connect to 'psql' and create the 'bookmark_manager_test' database.