//
//  ViewController.m
//  SHDCircularView
//
//  Created by Sergey Grischyov on 18.07.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import "ViewController.h"
#import "SHDPerson.h"
#import "SHDCircularView.h"

@interface ViewController ()

@end

@implementation ViewController{
	SHDCircularView *selectorView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = MAIN_BACKGROUND_COLOR;

	selectorView = [[SHDCircularView alloc] initWithFrame:CGRectMake(0, 0, selectorView.frame.size.width, selectorView.frame.size.height)];
	selectorView.center = self.view.center;
	[self.view addSubview:selectorView];

	NSMutableArray *mutArr = [NSMutableArray new];

	for (int i = 0; i < 10; i++) {
		SHDPerson *newFriend = [SHDPerson new];
		newFriend.friendName = [NSString stringWithFormat:@"Person %i", i];
		[mutArr addObject:newFriend];
	}

	[selectorView placeOuterArrayObjectsFromArray:mutArr];
}

@end