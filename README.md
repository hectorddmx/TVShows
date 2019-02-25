# TVShows
iOS Code Challenge for GonetUSA

## Main architecture decisions you've made and a quick explanation of why.

### Patterns and project structure
- Used simple MVC to avoid complicating project structure
- Separated files in different folders to keep them categorized
- Used MARK: - comments to segment code

### Views
- Used Storyboards and tried leaving most of the UI configuration within the storyboards
- Used different screens and ViewControllers for Favorites and TVShows to avoid having lots of conditions for presentation
- Used a XIB file to configure the cell's presentation
- Added NibName and ReuseIdentifier as static properties within the cell's Class to keep naming consistency

### Network
- Used URLSession directly to request the data instead of using another external dependency
- Used CachedURLResponse to cache images, helping to avoid saving the images manually and using another external dependency like SDWebImage

### Models
- Used Codable lean Models to allow simple JSON decoding, instead of using Dictionaries
- Added Realm as storage to save user data, simplifies greatly data storage
- Created separate storage object as DTO to simplify store objects lifecycle

### Misc
- Created extensions to enforce function reusability
- Used enum's as constants 
- Used enums to manage ViewController state
- Avoided duplicated code where possible

## List of third party libraries and why you chose each one.
- Realm: To save user data locally

## What in your code could be improved if you had more time.
- Change network layer to accept more services
- Improve error handling
- Separate ViewController extensions in multiple files
- Improve detail view, adding more fields and information
- Check if the API allows pagination to avoid loading all shows at once
- Change strings to Localization files
- Add search by show name
- Add filters, by tags, by status
- Add sort by tags, by status, by year

## Mention anything that was asked but not delivered and why, and any additional comments.
