## InteractiveCustomPushNotificationUI

![Alt text](./promo.jpg?raw=true "Custom Push notification UI")


A simple demo showcasing interactive custom push notification UI that has several custom UI:
- Video Player using XCDYoutubeKit
- Star Rating control using Cosmos
- A plain UITextView
- Several UIButton

## Requirement

- Xcode 11.4


## Installation

- Clone and run the project from simulator
- Use the provided APNS file in the project to drag and drop to target simulator
- Open the notification preview


## Sample APS Payload

Make sure the extension of the file is apns (not .JSON)

```
{
   "aps" : {
      "alert" : {
         "title" : "A new trailer has arrived for you",
         "body" : "Fast and Furious F9 Official Trailer"
      },
      "category" : "testNotificationCategory",
      "sound": "bingbong.aiff",
      "badge": 3,
   },
   "videoId" : "Kopyc23VfSw",
   "description": "Release date: 05-21-2020",
   "Simulator Target Bundle": "com.alfianlosari.apnspushsimulate"
}
```
