//
//  HangMonkey.h
//  HangMonkey
//
//  Created by Carin Lilly on 4/21/09.
//  Copyright 2009 Essex High School. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HangMonkeyViewController;

/*
 This class will have all of the application logic 
 for the Hang Man Game.
 There should only ever be one of these "guys",
 so instead of coding this for a single instance of the class,
 I'm going to make use the Class object, Class methods (+) and
 static variables that are defined in the .m.
 */

@interface HangMonkey : NSObject {
}

+(void)initialize;
+(void)setHangMonkeyViewController: (HangMonkeyViewController*) viewController;

+(void)loadAnimation;
+(void)newGame;
+(void)generateWord;
+(NSString*)hideAnswer;
+(NSString*)letterForButton: (UIButton*)button;
+(void)pickLetter:(NSString*)letter button: (UIButton*)sender;
+(void)revealLetter:(NSString*)letter;
+(void)coverLetter:(UIButton*) sender xOrO: (NSString*) xOrO;
+(void)winReward;
+(void)loseBad;
+(BOOL)rewardMessage;
+(void)updateScore;
+(void)setNumOfWrongAnswers:(int)number;
+(void)updateGuesses;
+(NSString*)getAnimationName;
+(void)setAnimationName:(NSString*)name;

+(void)saveData;
+(BOOL)writeApplicationData:(NSData *)data toFile:(NSString *)fileName;
+(id)applicationPlistFromFile:(NSString *)fileName;
+(NSData*)applicationDataFromFile:(NSString *)fileName;
+(void)loadData;

+(BOOL)charMatches:(NSString*) letter string: (NSString*) validChars;
+(NSString*)charAt:(int)index string: (NSString*)word;
+(void)alert:(NSString*) message;
//+(void)hideMessageLabel;

+(void)release;

@end
