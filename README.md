# TVShows
iOS Code Challenge for GonetUSA

## Main architecture decisions you've made and a quick explanation of why.
- Used Storyboards and tried leaving most of the UI configuration within the storyboards
- Used URLSession directly to load the webservice instead of using another external dependency
- Used CachedURLResponse to cache images
- Used Codable to allow simple JSON decoding
- Added Realm as storage to save user data
- Created extensions to allow function reusability
- Avoided duplicated code as possible

## List of third party libraries and why you chose each one.
- Realm: To save user data locally

## What in your code could be improved if you had more time.
- Change network layer to accept more services
- Improve error handling
- Separate ViewController extensions in multiple files
- Improve detail view, adding more fields and information
- Check if the API allows pagination to avoid loading all shows at once
- Add search by show name
- Add filters, by tags, by status
- Add sort by tags, by status, by year

## Mention anything that was asked but not delivered and why, and any additional comments.
