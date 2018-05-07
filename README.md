ProtonMail Mobile Dev Test
===========

### Dependencies
#### CocoaPods
- [RealmSwift](https://github.com/realm/realm-cocoa) Realm is a mobile database: a replacement for Core Data & SQLite
- [Reusable](https://github.com/AliSoftware/Reusable) A Swift mixin for reusing views easily and in a type-safe way
- [PageMenu](https://github.com/PageMenu/PageMenu) A paging menu controller built from other view controllers placed inside a scroll view
- [SwiftLint](https://github.com/realm/SwiftLint) A tool to enforce Swift style and conventions.
- [SwiftGen](https://github.com/SwiftGen/SwiftGen) The Swift code generator for your assets, storyboards, Localizable.strings, … — Get rid of all String-based APIs!

### Goal
Tasks manager app: Create iOS Application which consists of 2 screens.

#### Screen 1
The main screen consists of 2 different views (tabs or something similar). The first tab contains a list of tasks that need to be processed (Pending Tasks). All tasks can be executed concurrently. The list should be "swipe enabled" where left swipe postpones the task for 1 min and the right swipe starts the task immediately. The second tab shows all completed tasks with time how long it took for completion. Swiping each of the rows in the second tab puts the task for execution again. In both tabs, you need to add a way to add the new task or to edit the existing tasks. Add/Edit will bring up the screen 2

#### Screen 2
Task creation screen, which contains a "Name" input field, "Description" input field and a "file upload button" where the user can choose a file from the device or from the third- party Apps. Also, this screen contains the list of "keyword" input field and a "+ add keyword" button to adding more "keyword" fields to the keyword list dynamically. At the end, the task should upload the file to cloud storage (Dropbox, iCloud or others) and all other fields should all be saved in local storage. This screen contains buttons "Save" and "Cancel". Pressing the "Save" button puts the task in the queue for execution (Pending Tasks) and closes the screen.

#### Notification
Also, create a notification mechanism that will inform the user of tasks status, if the task is still executing it should show progress, and if it is done, it should show appropriate info. If multiple tasks are done, show this accordingly. Pressing on a notification, should open the application on Screen 1. Please add Cancel and New action buttons, where Cancel will stop the current execution task, and New will open a Screen 2.
