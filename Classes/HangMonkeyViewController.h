//
//  HangMonkeyViewController.h
//  HangMonkey
//
//  Created by Carin Lilly on 4/18/09.
//  Copyright 2009 Essex High School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HangMonkeyViewController : UIViewController <UIActionSheetDelegate> {	
	UIImageView *animationImageView;
//	UITextView *messageLabel;
	UILabel *answerLabel;
	
	UILabel *winsLabel;
	UILabel *lossesLabel;
	UILabel *scoreLabel;
	UILabel *streakLabel;
	UILabel *guessesLabel;
	
	UIButton *aboutButton;
	
	UIButton *aButton;
	UIButton *bButton;
	UIButton *cButton;
	UIButton *dButton;
	UIButton *eButton;
	UIButton *fButton;
	UIButton *gButton;
	UIButton *hButton;
	UIButton *iButton;
	UIButton *jButton;
	UIButton *kButton;
	UIButton *lButton;
	UIButton *mButton;
	UIButton *nButton;
	UIButton *oButton;
	UIButton *pButton;
	UIButton *qButton;
	UIButton *rButton;
	UIButton *sButton;
	UIButton *tButton;
	UIButton *uButton;
	UIButton *vButton;
	UIButton *wButton;
	UIButton *xButton;
	UIButton *yButton;
	UIButton *zButton;
}

@property (nonatomic, retain) IBOutlet UIImageView *animationImageView;
//@property (nonatomic, retain) IBOutlet UITextView *messageLabel;
@property (nonatomic, retain) IBOutlet UILabel *answerLabel;

@property (nonatomic, retain) IBOutlet UILabel *winsLabel;
@property (nonatomic, retain) IBOutlet UILabel *lossesLabel;
@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *streakLabel;
@property (nonatomic, retain) IBOutlet UILabel *guessesLabel;

@property (nonatomic, retain) IBOutlet UIButton *aboutButton;

@property (nonatomic, retain) IBOutlet UIButton *aButton;
@property (nonatomic, retain) IBOutlet UIButton *bButton;
@property (nonatomic, retain) IBOutlet UIButton *cButton;
@property (nonatomic, retain) IBOutlet UIButton *dButton;
@property (nonatomic, retain) IBOutlet UIButton *eButton;
@property (nonatomic, retain) IBOutlet UIButton *fButton;
@property (nonatomic, retain) IBOutlet UIButton *gButton;
@property (nonatomic, retain) IBOutlet UIButton *hButton;
@property (nonatomic, retain) IBOutlet UIButton *iButton;
@property (nonatomic, retain) IBOutlet UIButton *jButton;
@property (nonatomic, retain) IBOutlet UIButton *kButton;
@property (nonatomic, retain) IBOutlet UIButton *lButton;
@property (nonatomic, retain) IBOutlet UIButton *mButton;
@property (nonatomic, retain) IBOutlet UIButton *nButton;
@property (nonatomic, retain) IBOutlet UIButton *oButton;
@property (nonatomic, retain) IBOutlet UIButton *pButton;
@property (nonatomic, retain) IBOutlet UIButton *qButton;
@property (nonatomic, retain) IBOutlet UIButton *rButton;
@property (nonatomic, retain) IBOutlet UIButton *sButton;
@property (nonatomic, retain) IBOutlet UIButton *tButton;
@property (nonatomic, retain) IBOutlet UIButton *uButton;
@property (nonatomic, retain) IBOutlet UIButton *vButton;
@property (nonatomic, retain) IBOutlet UIButton *wButton;
@property (nonatomic, retain) IBOutlet UIButton *xButton;
@property (nonatomic, retain) IBOutlet UIButton *yButton;
@property (nonatomic, retain) IBOutlet UIButton *zButton;
- (id)init:(id)sender;
- (IBAction)alphaButtonPressed:(id)sender;
- (IBAction)aboutButtonPressed:(id)sender;
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)index;
- (void)enableAllAlphaButtons;

@end
