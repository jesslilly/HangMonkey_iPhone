//
//  HangMonkeyAppDelegate.h
//  HangMonkey
//
//  Created by Carin Lilly on 4/18/09.
//  Copyright Essex High School 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HangMonkeyViewController;

@interface HangMonkeyAppDelegate : NSObject <UIApplicationDelegate> {
	HangMonkeyViewController* hangMonkeyViewController;
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HangMonkeyViewController *hangMonkeyViewController;

@end

