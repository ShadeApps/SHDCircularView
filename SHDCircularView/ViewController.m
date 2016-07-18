//
//  ViewController.m
//  SHDCircularView
//
//  Created by Sergey Grischyov on 18.07.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import "ViewController.h"
#import "SHDPerson.h"
#import "SHDFunctions.h"
#import "SHDCircularView.h"

@interface ViewController ()

@end

@implementation ViewController{
	SHDCircularView *selectorView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [SHDFunctions colorFromHex:@"202020"];

	selectorView = [[SHDCircularView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 340) / 2, self.view.frame.size.width, 340)];
	[self.view addSubview:selectorView];

	NSMutableArray *mutArr = [NSMutableArray new];

	for (int i = 0; i < 10; i++) {
		SHDPerson *newFriend = [SHDPerson new];
		newFriend.friendName = [NSString stringWithFormat:@"Person %i", i];
		[mutArr addObject:newFriend];
	}

	[selectorView placeOuterArrayObjectsFromArray:mutArr];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end