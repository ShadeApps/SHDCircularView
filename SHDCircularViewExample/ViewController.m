//
//  ViewController.m
//  SHDCircularView
//
//  Created by Sergey Grischyov on 18.07.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import "ViewController.h"

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

	for (int i = 0; i < 11; i++) {
		SHDPerson *newPerson = [SHDPerson new];
		newPerson.personName = [NSString stringWithFormat:@"Person %i", i];
		newPerson.personAvatarImageName = [NSString stringWithFormat:@"img%i.png", i];
		[mutArr addObject:newPerson];
	}

	[selectorView placeOuterCircleObjects:mutArr];
}

@end