# iOS / Android Code Challenge
## View-01 - TV Shows home screen    

- As a user I want to see a list of existent TV Shows. 
- I should be able to save or delete a TV Show as my favorite.

### Acceptance Criteria  

- This screen should be the first when the App opens
- This screen should have the same specs as the screenshots provided.	
  - When **Shows** tab is selected then the TV Shows list should be shown (/shows)
- When **Favorites** tab is selected then my favorites shows should be listed (View-01)
- The favorites list needs to be accessed offline. You can choose how to save the TV Show.
- The list item should have:
  - Poster {image.medium}
  - Name {name}
  - The poster image has to be cached
- Each row needs to have an action to delete or save a TV Show.
- When the TV Show is not saved, the action needs to have a **green background** and **Favorite** as a label.
- When a TV Show is saved, the action needs to have a **red background** and **Delete** as a label.
- You can save as many TV Show's properties as you wish.
- When deleting a saved TV Show, a confirmation popup should be shown to confirm the deletion.
- When the user click on the row then the details screen (View-02) should be opened
- When any user action fails, then a retry dialog should be shown. The retry dialog should have:
  - Title
    - Oops, something went wrong
  - Description:
    - For saving/removing favorite:
      - There was a problem saving/deleting this TV Show. Do you want to try again?
    - For timeout / no connection:
      - An error occurred while fetching data. Do you want to try again?
  - Cancel option
  - Retry option

## View-02 - Details Screen  

As a user I want to see the detailed information of existing TV Shows and then I should be able to remove or add the TV Show to my favorite list.

### Acceptance Criteria  

- This screen should have the same identity as the list screen (View-01), but the layout is up to you
- NavigationBar should have a different color than the previous screen. You can choose any color.
- The screen title should be the TV Show's name
- The screen should have:
  - Poster {image.original}
  - Summary {summary}
  - IMDb {externals.imdb}
  - Any other information you find relevant
- When the user clicks on IMDb link, then the TV Show page (https://www.imdb.com/title/:id) should be opened in the default browser app
- When there is no IMDb id, then the link should not be visible
- NavigationBar should have a button to save or delete the TV show from favorites.
- When the TV Show is not saved, then a save icon/text should be used
- When the TV Show is saved, then a delete icon/text should be used

## View-03 - Favorites Screen  

- As a user I want to see all the TV Shows I marked as favorites, having the option to delete them from my favorites.

### Acceptance Criteria

- This screen should look like the TV Shows screen
- This screen should have all the user's saved TV Shows
- User needs to have the option to delete a TV Show from favorites
- When deleting a TV Show, a popup needs to be shown to confirm deletion
- After deletion, TV Show needs to be removed from Favorites List and database
- When the user click on the row then the details screen (View-02) should be opened

---

## Technical Details

- **Language**: Kotlin or Java, Swift or Objective-C, Swift and Kotlin are preferred.
- **Persistence**: Any type of persistence can be used. (Room, CoreData or Realm)
- **Documentation**: http://www.tvmaze.com/api
- **API Swagger**: https://static.tvmaze.com/apidoc 
- **API**: http://api.tvmaze.com/shows

--- 

## Notes

- This assessment must be delivered within **3 days**, you can send the project or give read rights to a repo, your choice.
- You can use whatever third party library you want to accomplish these requirements.
- The application should adapt to iOS or Android design systems.
  - Android: https://developer.android.com/design
  - iOS: https://developer.apple.com/design/human-interface-guidelines/ios/overview/themes/
- Please provide a COMMENTS file, explaining:
  - Main architecture decisions you've made and a quick explanation of why.
  - List of third party libraries and why you chose each one.
  - What in your code could be improved if you had more time.
- Mention anything that was asked but not delivered and why, and any additional comments.
