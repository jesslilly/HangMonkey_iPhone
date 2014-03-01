//
//  HangMonkey.m
//  HangMonkey
//
//  Created by Carin Lilly on 4/21/09.
//  Copyright 2009 Essex High School. All rights reserved.
//
/*
 Todo List:
 -------------------------- 
 Clear score button.
 Send email to friends button.
 
 Completed Todo List Items:
 -------------------------- 
 Make a load image.
 Word list does not work.
 Pop up result message.
 The Answer is slightly cropped at the bottom.
 Can't see death image.
 Move num guesses under image.
 New Word indicator.
 test on a real iphone.
 Run w instruments - memory checks.
 Icon image, load Image (none), Icon name (info.plist file)
 Make Message Label non-editable. (Xib file)
 Make sure the surprise is % 5.
 New animation
 Search all source files for todos.
 Remove HMButton object - not needed.
 Unified graphics
 Remove excessive debug.
 Test without a plist file (new player).
 Remove all compiler warnings.
 Spell check the word list again.
 Remove plurals from the word list.
 Review all words.
 Game crashes when you choose the same animation over again.
 Made in VT
 No animals were harmed
 Sparkyland
 More words: 360 to 900.
 Memory checks.  Search for new, alloc, copy - make sure you release.
 Memory checks.  Search for release - only release if it is new, alloc, or copy.
 Memory checks.  Search for any Class constructors that I made and make sure they release from the class.
 Memory checks.  Dealloc all instance variables for non-static classes.
 Game crashes when you choose a new animation several times.
 Search for commented out code.
 
 Ignored Items
 -------------
 Play hang monkey on the web for free.
 Somehow indicate that there is a new word and you can pick a new letter.
 Reward wins with bananas.
 Multiple players? or option to save score?
 Multiple word lists somehow.
 Randomize word sequence.
 */
 
#import "HangMonkey.h"
#import <Foundation/NSRange.h>
#include <stdlib.h> // random function.
#import "HangMonkeyViewController.h"

static HangMonkeyViewController *hangMonkeyViewController;

static NSArray *wordList;
static NSString *answer;
static NSString *hiddenAnswer;
static int numOfWrongAnswers = 0;
static int losingStreak = 0;
static NSArray *imageArray;
static BOOL previousResult = TRUE;

// Begin variables that are saved
static int numWins = 0;
static int numLosses = 0;
static int winningStreak = 0;
static int wordIndex = 0;
static NSString *animationName= @"hang-snake";
// End variables that are saved

@implementation HangMonkey

+(void)initialize {
	NSLog(@"initialize");
	[HangMonkey setNumOfWrongAnswers: 0];
	
	//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	//NSString *wordListPath = [[paths objectAtIndex:0] stringByAppendingString: @"/wordlist.txt"];
	NSString *wordListPath = [[NSBundle mainBundle] pathForResource:@"wordlist" ofType:@"txt"];
	NSLog(wordListPath);

	wordList = [[NSArray alloc] initWithContentsOfFile: wordListPath];
	
	if ( wordList == nil )
	{
		NSLog(@"Could not load word list!");
		wordList = [[NSArray alloc] initWithObjects: @"APE",@"SECOND",@"DAFT",@"FIGHT",@"GLUE",@"HEALTH",@"JOKE",@"KIND",@"LOST",@"ZONE",@"CHUNK",@"CHILL",@"VALVE",@"BETTER",@"NOTICE",@"MOTHER",@"QUIET",@"WHITE",@"EARLY",@"REALITY",@"TERSE",@"YESTERDAY",@"UNDER",@"INSIDE",@"OPPOSITE",@"PLENTY",nil];
	}	
}

+(void)setHangMonkeyViewController: (HangMonkeyViewController*) viewController {
	hangMonkeyViewController = viewController;
}

+(void)loadAnimation {
	NSLog(@"loadAnimation");
	const int arraySize = 10;
	UIImage *hangAnimation[arraySize];
	
	NSString *extension = @".gif";
	if ( [animationName isEqualToString: @"hang-snake"] )
		extension = @".png";

	NSString *temp;
	for ( int i = 0; i < arraySize; i++ )
	{
		temp = [[animationName stringByAppendingString: [NSString stringWithFormat:@"%d", i]] stringByAppendingString: extension];
		NSLog(@"Get Image %@",temp);
		hangAnimation[i] = [UIImage imageNamed: temp];
	}
	if ( imageArray != nil )
		[imageArray release];
	imageArray = [[NSArray alloc] initWithObjects: hangAnimation count: arraySize];
	hangMonkeyViewController.animationImageView.image = [imageArray objectAtIndex: (NSUInteger)numOfWrongAnswers ];
	hangMonkeyViewController.animationImageView.userInteractionEnabled = NO;
}
+(void)newGame {
	NSLog(@"newGame");
	[HangMonkey generateWord];
	
	[hangMonkeyViewController enableAllAlphaButtons];
	[HangMonkey setNumOfWrongAnswers: 0];
}

+(void)generateWord {
	NSLog(@"generateWord");

	answer = (NSString*)[wordList objectAtIndex: wordIndex];

	wordIndex++;
	if ( wordIndex >= [wordList count] )
	{
		wordIndex=0;
	}
	
	hiddenAnswer = [HangMonkey hideAnswer];
	
	hangMonkeyViewController.answerLabel.text = hiddenAnswer;
}
+(NSString*)hideAnswer {
	NSLog(@"Hide answer %@ with question marks.", answer);
	
	NSMutableString *hidden = [answer mutableCopy];
	// Replace all alpha characters with the hidden character.
	// Do not replace characters like space and dash.
	NSRange range = NSMakeRange(0, [hidden length]);
	// todo: reimplement this with charMatches?  Javascript style...
	[hidden replaceOccurrencesOfString:@"A" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"B" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"C" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"D" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"E" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"F" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"G" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"H" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"I" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"J" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"K" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"L" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"M" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"N" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"O" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"P" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"Q" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"R" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"S" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"T" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"U" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"V" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"W" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"X" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"Y" withString: @"?" options:NSLiteralSearch range:range];
	[hidden replaceOccurrencesOfString:@"Z" withString: @"?" options:NSLiteralSearch range:range];
	return (NSString*)[hidden autorelease];
}

+(NSString*)letterForButton: (UIButton*)button {
	if (button == hangMonkeyViewController.aButton)
		return @"A";
	else if (button == hangMonkeyViewController.eButton)
		return @"E";
	else if (button == hangMonkeyViewController.iButton)
		return @"I";
	else if (button == hangMonkeyViewController.oButton)
		return @"O";
	else if (button == hangMonkeyViewController.uButton)
		return @"U";

	else if (button == hangMonkeyViewController.lButton)
		return @"L";
	else if (button == hangMonkeyViewController.nButton)
		return @"N";
	else if (button == hangMonkeyViewController.rButton)
		return @"R";
	else if (button == hangMonkeyViewController.sButton)
		return @"S";
	else if (button == hangMonkeyViewController.tButton)
		return @"T";
					
	else if (button == hangMonkeyViewController.bButton)
		return @"B";
	else if (button == hangMonkeyViewController.cButton)
		return @"C";
	else if (button == hangMonkeyViewController.dButton)
		return @"D";
	else if (button == hangMonkeyViewController.fButton)
		return @"F";
	else if (button == hangMonkeyViewController.gButton)
		return @"G";
	else if (button == hangMonkeyViewController.hButton)
		return @"H";
	else if (button == hangMonkeyViewController.jButton)
		return @"J";
	else if (button == hangMonkeyViewController.kButton)
		return @"K";
	else if (button == hangMonkeyViewController.mButton)
		return @"M";
	else if (button == hangMonkeyViewController.pButton)
		return @"P";
	else if (button == hangMonkeyViewController.qButton)
		return @"Q";
	else if (button == hangMonkeyViewController.vButton)
		return @"V";
	else if (button == hangMonkeyViewController.wButton)
		return @"W";
	else if (button == hangMonkeyViewController.xButton)
		return @"X";
	else if (button == hangMonkeyViewController.yButton)
		return @"Y";
	else if (button == hangMonkeyViewController.zButton)
		return @"Z";
	return @"NOP";
}

+(void)pickLetter:(NSString*)letter button: (UIButton*)sender {
	
	// todo: this condition could be tightened.
//	if (numOfWrongAnswers == 0)
//	{
//		[HangMonkey hideMessageLabel];
//	}
	if ( [HangMonkey charMatches: letter string: answer ] )
	{
		NSLog(@"You picked a correct letter.");
		[HangMonkey revealLetter: letter];
		
		if ( previousResult == FALSE )
		{
			hangMonkeyViewController.animationImageView.image = [imageArray objectAtIndex: (NSUInteger)numOfWrongAnswers ];
			previousResult = TRUE;
		}	
		[HangMonkey coverLetter: sender xOrO: @"greenO.gif"];
		[HangMonkey winReward];
	}
	else
	{
		NSLog(@"You picked a bad letter.  HANG MAN!");
		[HangMonkey setNumOfWrongAnswers: ++numOfWrongAnswers ];
		hangMonkeyViewController.animationImageView.image = [imageArray objectAtIndex: (NSUInteger)numOfWrongAnswers ];
		[HangMonkey coverLetter: sender xOrO: @"redX.gif"];
		[HangMonkey loseBad];
	}
}

+(void)revealLetter:(NSString*)letter {
	NSLog(@"revealLetter %@", letter );
	hiddenAnswer = hangMonkeyViewController.answerLabel.text;
	NSMutableString *newHiddenAnswer = [[NSMutableString alloc] init];
	for ( int i = 0; i < [answer length]; i++ )
	{
		if ( [letter isEqualToString: [HangMonkey charAt: i string: answer]] )
		{
			[newHiddenAnswer appendString: letter];
		}
		else
		{
			[newHiddenAnswer appendString: [HangMonkey charAt: i string: hiddenAnswer]];
		}
	}
	hiddenAnswer = (NSString*)newHiddenAnswer;
	hangMonkeyViewController.answerLabel.text = hiddenAnswer;
	[newHiddenAnswer release];
}

+(void)coverLetter:(UIButton*) sender xOrO: (NSString*) xOrO {
	UIImage *image = [UIImage imageNamed: xOrO];
	[sender setBackgroundImage: image forState:(UIControlState)UIControlStateDisabled ];
	[sender setAlpha:(CGFloat)0.5];
	[sender setEnabled: NO];
}

+(void)winReward {
	hiddenAnswer = hangMonkeyViewController.answerLabel.text;
	if ( [answer isEqualToString: hiddenAnswer] )
	{
		previousResult = TRUE;
		numWins++;
		winningStreak++;
		losingStreak=0;
		[HangMonkey updateScore];
		[HangMonkey saveData];
		if (! [HangMonkey rewardMessage]) {
			hangMonkeyViewController.animationImageView.image = [imageArray objectAtIndex: (NSUInteger)0 ];
		}
		NSLog(@"call newGame");
		[HangMonkey newGame];
	}
}
+(void)loseBad {
	if ( numOfWrongAnswers >= 9 )
	{
		previousResult = FALSE;
		numLosses++;
		winningStreak=0;
		losingStreak++;
		[HangMonkey updateScore];
		[HangMonkey saveData];
		
		NSMutableString *message = [[NSMutableString alloc] init];
		[message appendString: @"Sorry, you lost!\n"];
		[message appendString: @"The answer was "];
		[message appendString: answer];
		[message appendString: @".\n"];
		
		if ( losingStreak >= 3 )
		{
			[message appendString: @"Tip: "];
			if ( losingStreak == 3 )
				[message appendString: @"Choose common letters first like E, R, S and T."];
			else
				[message appendString: @"Choose some or all of the vowels first."];
		}
		[HangMonkey alert: message];
		[message release];
		
		[HangMonkey newGame];
		// don't reset the animationImageView to 0;  Show them the loss picture!
		// We have to reset it later in pickLetter using previousResult.
	}
}
+(BOOL)rewardMessage {
	BOOL surprise = FALSE;
	NSMutableString *message = [[NSMutableString alloc] init];
	[message appendString: @"You win!\n"];
	[message appendString: @"The answer was "];
	[message appendString: answer];
	[message appendString: @".\n"];
	
	int streakRemainder = winningStreak % 5;
	if ( streakRemainder == 1 )
	{
		[message appendString: @"If you get 5 wins in a row, you get a SURPRISE!\n"];
	}
	if ( streakRemainder > 1 && streakRemainder < 5 )
	{
		[message appendString: @"You need "];
		[message appendString: [NSString stringWithFormat:@"%d", ( 5 - streakRemainder )]];
		[message appendString: @" more win"];
		if ( streakRemainder < 4 )
			[message appendString: @"s"];
		[message appendString: @" to get your surprise.\n"];
	}
	[HangMonkey alert: message];
	[message release];

	if ( streakRemainder == 0 )
	{
		// Surprise!
		surprise = TRUE;
		NSLog(@"begin popup code");
		UIActionSheet *popup = [[UIActionSheet alloc] init];
		popup.title = @"Surprise! Select a new Theme.";
		popup.delegate = hangMonkeyViewController;
		[popup addButtonWithTitle: @"Robot"];
		[popup addButtonWithTitle: @"Monkey vs. Croc"];
		[popup addButtonWithTitle: @"Monkey vs. Boa (standard)"];
		[popup addButtonWithTitle: @"Space Dragons"];
		[popup showInView: (UIView*)hangMonkeyViewController.view];
		[popup release];
		NSLog(@"end popup code");
	}
	return surprise;
}

+(void)updateScore {
	int score = 0;
	if ( ( numLosses + numWins ) > 0 )
	{
		score = round( ( (numWins * 1.0) / ( numLosses + numWins * 1.0 ) ) * 100 );
	}	
	hangMonkeyViewController.winsLabel.text = [NSString stringWithFormat: @"%d", numWins];
	hangMonkeyViewController.lossesLabel.text = [NSString stringWithFormat: @"%d", numLosses];
	hangMonkeyViewController.scoreLabel.text = [NSString stringWithFormat: @"%d %%", score];
	hangMonkeyViewController.streakLabel.text = [NSString stringWithFormat: @"%d", winningStreak];
}

+(void)setNumOfWrongAnswers: (int)number {
	numOfWrongAnswers = number;
	[HangMonkey updateGuesses];
}

+(void)updateGuesses {
	hangMonkeyViewController.guessesLabel.text = [NSString stringWithFormat: @"%d", (9 - numOfWrongAnswers)];
}

+(NSString*)getAnimationName {
	return animationName;
}

+(void)setAnimationName:(NSString*)name {
	NSLog(@"setAnimationName: %@", name );
	if ( animationName != nil )
		[animationName release];
	animationName = [name copy];
}

// ____________________ begin util/string functions _________________________
+(BOOL)charMatches:(NSString*) letter string: (NSString*) validChars {
	BOOL matches2 = NO;
	
	for ( int j = 0; j < [validChars length]; j++ )
	{
		if ( [letter isEqualToString: [HangMonkey charAt:j string:validChars ]] )
		{
			matches2 = YES;
			break;
		}
	}
	return matches2;
}
+(NSString*)charAt:(int)index string: (NSString*)word {
	return [word substringWithRange:NSMakeRange(index,1)];
}
+(void)alert: (NSString*) message {	
	UIAlertView *popup = [[UIAlertView alloc] init];
	popup.title = @"Hang Monkey";
	popup.message = message;
	[popup addButtonWithTitle: @"Next Word"];
	popup.cancelButtonIndex = 0;
	[popup show];
	[popup release];

//	[hangMonkeyViewController.animationImageView setAlpha:(CGFloat)0.2];
//	[hangMonkeyViewController.messageLabel setAlpha:(CGFloat)1.0];
//	hangMonkeyViewController.messageLabel.text = message;
}

//+(void)hideMessageLabel {
//	[hangMonkeyViewController.messageLabel setAlpha:(CGFloat)0.0];
//	[hangMonkeyViewController.animationImageView setAlpha:(CGFloat)1.0];	
//}

// ____________________ end util/string functions _________________________

// ____________________ begin cookies _________________________
+(void)saveData {
	NSString *error;
	NSMutableDictionary *dataToSave = [[NSMutableDictionary alloc]initWithCapacity:5];
	
	[dataToSave setObject:[NSNumber numberWithInt:numWins] forKey:@"numWins"];
	[dataToSave setObject:[NSNumber numberWithInt:numLosses] forKey:@"numLosses"];
	[dataToSave setObject:[NSNumber numberWithInt:wordIndex] forKey:@"wordIndex"];
	NSLog(@"saveData animationName: %@", animationName );
	[dataToSave setObject:animationName forKey:@"animationName"];
	[dataToSave setObject:[NSNumber numberWithInt:winningStreak] forKey:@"winningStreak"];
	
	// NSPropertyListXMLFormat_v1_0
	// NSPropertyListBinaryFormat_v1_0
	
	NSData *pData = [NSPropertyListSerialization dataFromPropertyList:dataToSave format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
	
	if (!pData) {
		NSLog(@"%@", error);
	}
	
	if ( ! [HangMonkey writeApplicationData:pData toFile:@"score.plist"])
	{
		NSLog(@"writeApplicationData failed.");
	}
	[dataToSave release];
}

+(BOOL)writeApplicationData:(NSData *)data toFile:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (!documentsDirectory) {
        NSLog(@"Documents directory not found!");
        return NO;
    }
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
	NSLog(@"write to file %@", appFile);
    return ([data writeToFile:appFile atomically:YES]);	
}

+(id)applicationPlistFromFile:(NSString *)fileName {
    NSData *retData;
    NSString *error;
    id retPlist;
    NSPropertyListFormat format;
    retData = [HangMonkey applicationDataFromFile:fileName];
    if (!retData) {
        NSLog(@"Data file not returned.");
        return nil;
    }
    retPlist = [NSPropertyListSerialization propertyListFromData:retData  mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&error];
    if (!retPlist){
        NSLog(@"Plist not returned, error: %@", error);
    }
    return retPlist;	
}

+(NSData *)applicationDataFromFile:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSData *myData = [[[NSData alloc] initWithContentsOfFile:appFile] autorelease];
    return myData;	
}

+(void)loadData {
	NSDictionary *dict = [HangMonkey applicationPlistFromFile: @"score.plist"];
	if (dict)
	{
		numWins = [(NSNumber*)[dict valueForKey:@"numWins"] intValue];
		NSLog(@"Load numWins: %d",numWins);
		numLosses = [(NSNumber*)[dict valueForKey:@"numLosses"] intValue];
		wordIndex = [(NSNumber*)[dict valueForKey:@"wordIndex"] intValue];
		[HangMonkey setAnimationName: [dict valueForKey:@"animationName"]];
		NSLog(@"loadData animationName: %@", animationName );
		winningStreak = [(NSNumber*)[dict valueForKey:@"winningStreak"] intValue];
	}
	else
	{
		// Notes on random: http://www.iphonedevsdk.com/forum/iphone-sdk-development/2969-random-number-generator.html
		// Use arc4random or srand with random.
		wordIndex = arc4random() % ([wordList count]);
	}
	NSLog(@"wordIndex = %i",wordIndex);
}
// ____________________ end cookies _________________________

+(void)release {
	[answer release];
	[hiddenAnswer release];
	[hangMonkeyViewController release];
	[wordList release];
	[imageArray release];
	[animationName release];
}

@end