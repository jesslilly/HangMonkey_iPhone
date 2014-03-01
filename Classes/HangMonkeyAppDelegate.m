//
//  HangMonkeyAppDelegate.m
//  HangMonkey
//
//  Created by Carin Lilly on 4/18/09.
//  Copyright Essex High School 2009. All rights reserved.
//

#import "HangMonkeyAppDelegate.h"
#import "HangMonkeyViewController.h"

@implementation HangMonkeyAppDelegate

@synthesize window;
@synthesize hangMonkeyViewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	self.hangMonkeyViewController = 
		[[HangMonkeyViewController alloc]
		initWithNibName:@"HangMonkeyViewController" bundle:[NSBundle mainBundle]];
	
	[window addSubview:[hangMonkeyViewController view]];

	NSLog(@"about to call hmvc init");
	[self.hangMonkeyViewController init:self];

    [window makeKeyAndVisible];
}


- (void)dealloc {
	[hangMonkeyViewController release];
    [window release];
    [super dealloc];
}


@end
