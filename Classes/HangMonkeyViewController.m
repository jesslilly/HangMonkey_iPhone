//
//  HangMonkeyViewController.m
//  HangMonkey
//
//  Created by Carin Lilly on 4/18/09.
//  Copyright 2009 Essex High School. All rights reserved.
//

#import "HangMonkeyViewController.h"
#import "HangMonkey.h"

@implementation HangMonkeyViewController

@synthesize animationImageView;
//@synthesize messageLabel;
@synthesize answerLabel;

@synthesize winsLabel;
@synthesize lossesLabel;
@synthesize scoreLabel;
@synthesize streakLabel;
@synthesize guessesLabel;

@synthesize aboutButton;

@synthesize aButton;
@synthesize bButton;
@synthesize cButton;
@synthesize dButton;
@synthesize eButton;
@synthesize fButton;
@synthesize gButton;
@synthesize hButton;
@synthesize iButton;
@synthesize jButton;
@synthesize kButton;
@synthesize lButton;
@synthesize mButton;
@synthesize nButton;
@synthesize oButton;
@synthesize pButton;
@synthesize qButton;
@synthesize rButton;
@synthesize sButton;
@synthesize tButton;
@synthesize uButton;
@synthesize vButton;
@synthesize wButton;
@synthesize xButton;
@synthesize yButton;
@synthesize zButton;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (id)init:(id)sender {
	NSLog(@"HMVC init:sender");
	// I don't need to call this.  It is happening automatically.
	//[HangMonkey initialize];
	[HangMonkey setHangMonkeyViewController: self];
	[HangMonkey loadData];
	[HangMonkey loadAnimation];
//	[HangMonkey hideMessageLabel];
	[HangMonkey updateScore];
	[HangMonkey newGame];
	return self;
}

- (IBAction)alphaButtonPressed:(id)sender {
	NSLog(@"alphaButtonPressed");
	if ( [sender isKindOfClass:[UIButton class]] ) {
		[HangMonkey pickLetter:[HangMonkey letterForButton: sender] button: (UIButton*)sender];
	}
}

- (IBAction)aboutButtonPressed:(id)sender {
	NSLog(@"aboutButtonPressed");

	UIAlertView *popup = [[UIAlertView alloc] init];
	popup.title = @"About Hang Monkey";
	popup.message = @"Version 2.0\nMade in VT.\nProgramming and graphics by Jess Lilly.\nNo animals were harmed...\nwww.sparkyland.com";
	[popup addButtonWithTitle: @"Close"];
	popup.cancelButtonIndex = 0;
	[popup show];
	[popup release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)index {
	NSLog( @"Action sheet clicked at %d", index );
	NSString *name;
	switch (index) {
		case 0:
			name = @"hang-robot";
			break;
		case 1:
			name = @"hang-monkey";
			break;
		case 2:
			name = @"hang-snake";
			break;
		case 3:
			name = @"hang-earth";
			break;
		default:
			break;
	}
	if ( ! [name isEqualToString: [HangMonkey getAnimationName]] )
	{
		[HangMonkey setAnimationName:name];
		[HangMonkey loadAnimation];
	}
	[actionSheet dismissWithClickedButtonIndex: (NSInteger)index animated: YES];
}

- (void)enableAllAlphaButtons {
	CGFloat fullAlpha = 1;
	[aButton setEnabled: YES];
	[bButton setEnabled: YES];
	[cButton setEnabled: YES];
	[dButton setEnabled: YES];
	[eButton setEnabled: YES];
	[fButton setEnabled: YES];
	[gButton setEnabled: YES];
	[hButton setEnabled: YES];
	[iButton setEnabled: YES];
	[jButton setEnabled: YES];
	[kButton setEnabled: YES];
	[lButton setEnabled: YES];
	[mButton setEnabled: YES];
	[nButton setEnabled: YES];
	[oButton setEnabled: YES];
	[pButton setEnabled: YES];
	[qButton setEnabled: YES];
	[rButton setEnabled: YES];
	[sButton setEnabled: YES];
	[tButton setEnabled: YES];
	[uButton setEnabled: YES];
	[vButton setEnabled: YES];
	[wButton setEnabled: YES];
	[xButton setEnabled: YES];
	[yButton setEnabled: YES];
	[zButton setEnabled: YES];
	[aButton setAlpha:fullAlpha];
	[bButton setAlpha:fullAlpha];
	[cButton setAlpha:fullAlpha];
	[dButton setAlpha:fullAlpha];
	[eButton setAlpha:fullAlpha];
	[fButton setAlpha:fullAlpha];
	[gButton setAlpha:fullAlpha];
	[hButton setAlpha:fullAlpha];
	[iButton setAlpha:fullAlpha];
	[jButton setAlpha:fullAlpha];
	[kButton setAlpha:fullAlpha];
	[lButton setAlpha:fullAlpha];
	[mButton setAlpha:fullAlpha];
	[nButton setAlpha:fullAlpha];
	[oButton setAlpha:fullAlpha];
	[pButton setAlpha:fullAlpha];
	[qButton setAlpha:fullAlpha];
	[rButton setAlpha:fullAlpha];
	[sButton setAlpha:fullAlpha];
	[tButton setAlpha:fullAlpha];
	[uButton setAlpha:fullAlpha];
	[vButton setAlpha:fullAlpha];
	[wButton setAlpha:fullAlpha];
	[xButton setAlpha:fullAlpha];
	[yButton setAlpha:fullAlpha];
	[zButton setAlpha:fullAlpha];
}


- (void)dealloc {
// [HangMonkey release];
	
// [animationImageView release];
// [messageLabel release];
// [answerLabel release];
// 
// [winsLabel release];
// [lossesLabel release];
// [scoreLabel release];
// [streakLabel release];
// [guessesLabel release];
// 
// [aboutButton release];

// [aButton release];
// [bButton release];
// [cButton release];
// [dButton release];
// [eButton release];
// [fButton release];
// [gButton release];
// [hButton release];
// [iButton release];
// [jButton release];
// [kButton release];
// [lButton release];
// [mButton release];
// [nButton release];
// [oButton release];
// [pButton release];
// [qButton release];
// [rButton release];
// [sButton release];
// [tButton release];
// [uButton release];
// [vButton release];
// [wButton release];
// [xButton release];
// [yButton release];
// [zButton release];
	
    [super dealloc];
}

@end
