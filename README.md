
Features of the app for testing:

BudgetView:
- Click the "Update Budget" button to set the budget for the current month. The budget set is always for the current month (June, 2021) and not for the previous month. The Arc on the left will change according to the budget set, and it will turn red (with an animation) if the spending of current month exceed the budget we set.
- Swiping the Update Budget button to any direction will change it temporarily to a Delete Budget button and will clear the budget we set. 
- Use the "plus" button to add an event in the "history spending" scrollview. 
- Use the edit button to edit or delete a button. (To make the popup window appear, click on the name or spending of the list item but not any part of the list). 
- Click on any list item will direct to the detail page of an event, where you can set the location of the event by a integrated map. To change the location, click on the search button and enter the location text for query and wait for about 0.5 second for a list of results to show up. Click on any result (you can also scroll down) will change the location with a pin in the map kit showing in animation. 
- The location is stored in the userdefaults, so switching views or quitting maps after storing the location should be fine. 

Stats View:
The view shows a bar chart indicating the proportion of spending on each category of a given month. Click on the calendar button and use the picker to select a different month and year (recommended: May, 2021, which has some defaults event set up for testing).

Memory View: 
- Deleting an event from the memory view will set the isMemory attribute of any event to be false, removing it from the memory view but not the history spending. 
- Add any event to the memory view by finding them in the budget view and use the edit popup window to "add to memories". 
- Clicking on any event will direct to the event detail page with the map, similar to clicking it in the budget view. 


API Usage:
Numerous controls (e.g. Button, Toggle, Stepper, Slider, Picker, etc.)
    - This is widely used in the app, with various buttons, pickers, and a toggle. 

TextField
    - This is used in the form for adding and editing an event, as well as the search bar for a map view. 

Image
    - This is used in different icons of the button in the tab view and in the app features. I also include a series of app icons as suggested by Professor's Piazza post. 

GeometryReader
    - This is widely used in the BudgetView, the EventDetailView, and the StatsView in the source code. 

NavigationView
    - This is used in the budget view and the memory view to list all the history spendings. 

Form or List (or both)
    - This is used in the list of history spendings and the forms for adding / editing an event. 

Gesture (more than just .onTapGesture or .onLongPressGesture)
    - This is used in the update budget swipe gesture to clear the current budget quickly. 

A custom ViewModifier
    - This is used in the update budget button to turn the text into a button with rounded corner, which cleans the code a bit. 

A custom Shape
    - This is used in the Arc for representing the percentage of budget used (in the budget view). 

An Animatable (either ViewModifier or Shape)
    - I made the Arc animatable by making its endAngle feature an animatableData, so that the Arc can nicely update when deleting / adding an event or updating the budget. 

Implicit Animation
    - This is used in the stats view (bar chart which can animate when changing the months) and the budget view (the arc uses implicit animation)

Explicit Animation
    - This is used in smoothly "shaking" the update budget button text when swiping it and also in the map kit, where a pin is explicitly place in the new location set. 

A modal sheet, popover, alert or action sheet
    - The popover is used in the edit popover window in the budget view to edit an event. 

UserDefaults
    - Used in the app to store all the model data, including the budget and each event.

Your UI must look good in all sizes/orientations on either all iPhones or all iPads or both.
    - This is also fulfilled, except that when the view is in the layout format in the budget view, it doesn't display the map view. However, I try not to squeeze the map view in a landscape format since it takes up too much space and make more sense to use a portrait format to set the location. 

YOUR COHICE APIS:
HSplitView, VSplitView or TabView (using any or all of these is only 1 API usage)
    - I use the TabView to organize three views in my apps, and I included an icon and a title for each tab. 
Integrates with some substantial UIKit API (e.g. MapKit, Camera, etc.)
    - I integrate my app with MapKit to set the location for each event. 
Multithreading (more than just fetching something from a URL, however)
    - This is not a major part of YOUR CHOICE APIS that I plan to use, but I also use a delay feature in searching the new location so that the search won't happen automatically when the text in the search bar is changed by the user. 
