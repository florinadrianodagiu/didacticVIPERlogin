What's in here: a sample Swift project, performing a simple Login function, showcasing VIPER architecture

It has 2 screens:
 -Login screen
 -Success screen



Login screen contains:
    - a text field for email (validated for existence of "@" and ".com"), changing border colors to black/red/blue
    - a text field for password (validated for at least 3 characters in length), changing border colors to black/red/blue
    - a button for login
        * disabled on validation failure
        * title
            * "Login" (default)
            * "Cancel" (while request is running)
            * "Try again" (after request has failed)
    - an activity indicator (when request is running)
    - an error label
        * empty (default)
        * text (localizedMessage from backend, when request has failed)



Success screen contains:
    - navigation bar with back button
    
    
Networking: 
    - a simple POST request, populated with email and password
    - web service returns 200 in case of success, but it may randomly return 401 (simulates authentication error) or 500 to allow for broader testing
    
    
Cocoapods/Alamofire used for networking code, alongside the Router pattern, laying the foundation for an easily scalable scaffold.
