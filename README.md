# Babool 🌵

Babool is a versatile iOS library designed for developers who want to efficiently manage and store development logs. Whether you need to keep logs locally or prefer to utilize cloud storage, Babool provides seamless integration with both local CSV files and Google Sheets.

## Features
1. Local Logging:
Save your development logs directly to a CSV file on your device. This feature is ideal for quick access and offline use.

2. Cloud Logging:
Automatically upload your logs to Google Sheets, ensuring your data is accessible from anywhere and easily shareable with your team.

3. Easy Integration:
With straightforward setup and minimal configuration, you can start logging in just a few minutes.

4. Customizable Logs:
Define the structure and content of your logs to suit your specific development needs.
Secure and Reliable: Ensures the integrity and security of your logs whether stored locally or in the cloud.

## Installation

Babool is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Babool'
```

## Example

0. Add `File Sharing` Authorization in your `Info.plist`, 
```
<key>UISupportsDocumentBrowser</key>
<true/>
<key>UIFileSharingEnabled</key>
<true/>
```

1. Local Logging
Here, you will have a `Babool-Log` CSV in your iPhone's 'Files App.
```
let babool = BaboolBoard(boardType: .localSheet(csvName: "Babool-Log"))
babool?.write(payload: DefaultPayload(title: "My Title", description: "I dont have anything to write here", category: "DEBUG"))
```

2. GoogleSheet Remote Logging - [WIP]

## Use Cases
Debugging: Keep detailed logs of app behavior and crashes to streamline the debugging process.
Performance Monitoring: Track performance metrics and log them for later analysis.
User Behavior Tracking: Log user interactions and behavior for UX improvements.

Babool simplifies the process of logging development activities, giving you the flexibility to choose between local and cloud storage based on your needs. Enhance your development workflow with reliable and accessible log management.

## Author
Abhishek Ravi 🌵

## License
Babool is available under the MIT license. See the LICENSE file for more info.
