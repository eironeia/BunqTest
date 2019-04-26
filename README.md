
## iOS Assignment 1
The problems which I found are the following ones:

Inside the function  `doWorkWithPerson` there it is called the function  `performSelectorInBackground`.  As we can see in the [documentation](https://developer.apple.com/documentation/objectivec/nsobject/1412390-performselectorinbackground?language=objc) the thread where the function is going to be executed is not going to be the main thread. There is no problem so far. 

What I have noticed is that there is UI updates when the following code is called:

```objectivec
[[ProgressBar instance] update:p];
```

As it is suggested in a lot of pages (as  [Updating UI Controls On Background Threads – iOS Developer](https://ios-developer.net/iphone-ipad-programmer/development/threads/updating-ui-controls-on-background-threads)),  we shouldn’t update UI nowhere else than on the main thread.  The reason behind that is that the UIApplication it is set up on the main thread when you start the app.

We could just easily solve it this way:

```objectivec
dispatch_sync(dispatch_get_main_queue(), ^{
//Update UI in main thread here
[[ProgressBar instance] update:p];
});
```

I have my doubts regarding the block if force to be executed on the main thread or no because I don’t know what is going to proceed to execute later, it might contain UI updates or not. I would just go safe and ensure to run it on main thread since it’s executed after  **“Do final actions”**.  Which probably will follow with a UI update.

As discussed on the interview I don’t have that strong knowledge about Objective-C and I tried to find some error else, but nothing else popup on my mind. I would love to see the solution to this in order to keep improving in case I have missed something.

## iOS Assignment 2

### Implementation details

For the app I have decided to use a **MVVM-C** architecture. The way I use it is one coordinator for each flow. On that particular exercise, doesn’t require flows, but I just write it down in order to be ready to go if some navigation appears, and also to instantiate through the **ViewControllerFactory** the **ViewController** which I am going to present. I am working with protocols.  I use **dependency inversion** and **dependency injection** to make components abstracts between them and we as developers we are able to use mocks which implements those protocols.

For the notification and handling of the employees list, I am using a “reactive” approach with closures. That would make it so easy if some day I want to integrate into this project  RxSwift or other Reactive Framework.

I want to add tests, but I have seen that **EmployeeDirectory** is an interface but not a protocol and I was not sure if I could modify them, creating a protocol with the methods and stored properties that they have and make it to implement it. Also since the creation of the employees is random, if there is no mock with specific values, the testing with not be accurate at all.

As I have mentioned I haven’t had that much time but I still wanted to deliver something more or less okay before the weekend maybe the team has some time to take a look although I believe is going to be hard. 

I wouldn’t mind have a chat and discuss about the tests or something, is just literally the lack of time, really busy days!

