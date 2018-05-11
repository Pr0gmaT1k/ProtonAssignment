ProtonMail Mobile Dev Test
===========

### Dependencies
#### CocoaPods
- [RealmSwift](https://github.com/realm/realm-cocoa) Realm is a mobile database: a replacement for Core Data & SQLite
- [Reusable](https://github.com/AliSoftware/Reusable) A Swift mixin for reusing views easily and in a type-safe way
- [PageMenu](https://github.com/PageMenu/PageMenu) A paging menu controller built from other view controllers placed inside a scroll view
- [FileProvider](https://github.com/amosavian/FileProvider) FileManager replacement for Local, iCloud and Remote (WebDAV/FTP/Dropbox/OneDrive) files -- Swift
- [SwiftLint](https://github.com/realm/SwiftLint) A tool to enforce Swift style and conventions.
- [SwiftGen](https://github.com/SwiftGen/SwiftGen) The Swift code generator for your assets, storyboards, Localizable.strings, … — Get rid of all String-based APIs!

I also use [Gyro](https://github.com/NijiDigital/gyro) Tool to generate Realm.io models for Swift, Java & ObjC from xcdatamodel and its visual Xcode editor <== I'm a contributor 8D. Take a look at gyro.sh

#### Test Account
I choosed to upload on Yandex. Firstly i tryed iCloud, because, in theory, is the most easiest one. I lost at least two hour on a bug who, I think, is caused by the simulator. For Dropbox I need Oauth system and an API key. So, Yandex was the fastest solution.
Client: https://disk.yandex.com/client/disk
UserName: Pr0gmaT1k
Pass: test1234 (no email / phone are attached to account)

#### PageMenu
An elegant & swipable menu to quickly switch between pending, current and completed task information.
For a better visual aspect, I had to add the function delete a task

#### Pending Task
I made the choices not to use the swipeable cell because of the page menu and that a pending and completed task cannot be edited.

#### In progress
I added the possibility to cancel a task, a visual indicator for delayed state and a progress bar

#### Completed
I add the start date, end date, and the state of the task (failed, completed, canceled).

#### Add
Source: Photo library
Destination: Yandex

#### Custom Notification
Not enough time :/ I lost so many time on iCloud...
With one more day, I can make you the most beautiful custom notification in the world.

#### Test & UITest
There is some UITests and unit test, mainly for navigation and TaskManager. There is not so many public funcs / properties to test and not enough time to make a frameworks and test the actual private funcs / properties.
