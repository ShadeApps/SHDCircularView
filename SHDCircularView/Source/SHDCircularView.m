//
//  SHDCircularView.h
//  SHDCircularView
//
//  Created by Sergey Grischyov on 20.05.14.
//  Copyright (c) 2014 ShadeApps. All rights reserved.
//

#import "SHDCircularView.h"
#import "SHDDraggablePersonView.h"
#import "SHDFunctions.h"

@implementation SHDCircularView{

	UIImageView *gridImage;

	UIImageView *userAvatarCenterImage;

	//Outer Circle

	NSMutableArray *outerPlaceholderLayersArray;

	//Inner Circle

	UIView *innerCircleView;

	UILabel *centerCountLabel;

	NSMutableArray *innerCircleViewsArray;

	NSMutableArray *innerPlaceholderLayersArray;

	NSArray *mainPersonsArray;

	BOOL isDragging;

	int currentInnerArrayIndex;

	int currentMemberCount;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self __basicInit];
	}
	return self;
}

#pragma mark - Default Setup

- (void)__basicInit{
	_friendObjectsArray = [[NSMutableArray alloc] init];

	gridImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imgGrid.png"]];

	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, gridImage.frame.size.width, gridImage.frame.size.height);

	gridImage.userInteractionEnabled = YES;
	gridImage.frame = CGRectMake(0, 0, gridImage.frame.size.width, gridImage.frame.size.height);
	[self addSubview:gridImage];

	[self __placeCenterCirle];

	outerPlaceholderLayersArray = [[NSMutableArray alloc] init];
	innerPlaceholderLayersArray = [[NSMutableArray alloc] init];
	innerCircleViewsArray = [[NSMutableArray alloc] init];

	innerCircleView = [[UIView alloc] initWithFrame:CGRectMake(floorf((gridImage.frame.size.width - kInnerCirlceViewRadius) / 2), floorf((gridImage.frame.size.height - kInnerCirlceViewRadius) / 2) - 5, kInnerCirlceViewRadius, kInnerCirlceViewRadius)];
	innerCircleView.layer.cornerRadius = kInnerCirlceViewRadius / 2;
	innerCircleView.clipsToBounds = YES;
	innerCircleView.userInteractionEnabled = NO;
	[gridImage addSubview:innerCircleView];

	//Outer Circle

	[self __putOuterPlaceholdersInPlace];

	isDragging = NO;

	//Inner Circle

	[self __putInnerPlaceholdersInPlace];
}

- (void)__placeCenterCirle{
	userAvatarCenterImage = [[UIImageView alloc] initWithFrame:CGRectMake(floorf((gridImage.frame.size.width - kUserCenterAvatarRadius) / 2), floorf((gridImage.frame.size.height - kUserCenterAvatarRadius) / 2) - 5, kUserCenterAvatarRadius, kUserCenterAvatarRadius)];
	userAvatarCenterImage.clipsToBounds = YES;
	userAvatarCenterImage.layer.cornerRadius = kUserCenterAvatarRadius / 2;
	userAvatarCenterImage.layer.borderColor = MAIN_TINT_COLOR.CGColor;
	userAvatarCenterImage.layer.borderWidth = 1.0;
	userAvatarCenterImage.backgroundColor = MAIN_TINT_COLOR;
	userAvatarCenterImage.contentMode = UIViewContentModeCenter;
	userAvatarCenterImage.userInteractionEnabled = YES;
	[gridImage addSubview:userAvatarCenterImage];

	centerCountLabel = [SHDFunctions labelWithFontName:@"HelveticaNeue-Bold" fontSize:10 fontColor:MAIN_TINT_COLOR_DARK andDefaultText:@"Drag &\nDrop"];
	centerCountLabel.numberOfLines = 2;
	[centerCountLabel sizeToFit];
	centerCountLabel.textAlignment = NSTextAlignmentCenter;
	centerCountLabel.frame = CGRectMake(0, 0, userAvatarCenterImage.frame.size.width, userAvatarCenterImage.frame.size.height);
	[userAvatarCenterImage addSubview:centerCountLabel];
}

- (void)__putOuterPlaceholdersInPlace{

	for(int i = 0; i < kMaxOuterPeopleCount; i++) {

		// Construct the image layer which will contain the template image.
		CALayer *outerPlaceholderLayer = [CALayer layer];
		outerPlaceholderLayer.frame = CGRectMake(0, 0, kOuterCirlceLayerWidth, kOuterCirlceLayerWidth);

		// Calculate the x and y coordinate. Points go around the outer circle starting at pi = 0.
		int section = i > kMaxOuterPeopleCount -  1 ? kMaxOuterPeopleCount - 1 : i;
		float trig = section / (kMaxOuterPeopleCount / 2.0) * M_PI;
		float x = gridImage.frame.size.width / 2.0 + cosf(trig) * (gridImage.frame.size.width - kOuterCircleRatioDifference) /2.0;
		float y = gridImage.frame.size.width / 2.0 - sinf(trig) * (gridImage.frame.size.width - kOuterCircleRatioDifference) /2.0;
		outerPlaceholderLayer.position = CGPointMake(x, y);
		outerPlaceholderLayer.contents = (__bridge id)([UIImage imageNamed:@"imgLayerCircle.png"].CGImage);

		outerPlaceholderLayer.cornerRadius = outerPlaceholderLayer.frame.size.width / 2;
		outerPlaceholderLayer.masksToBounds = YES;

		[outerPlaceholderLayersArray addObject:outerPlaceholderLayer];
		[gridImage.layer addSublayer:outerPlaceholderLayer];
	}
}

- (void)__putInnerPlaceholdersInPlace{
	for(int i = 0; i < kInitialInnerPeopleCount; i++) {

		//Construct the image layer which will contain the template image.
		CALayer *innerPlaceholderLayer = [CALayer layer];
		innerPlaceholderLayer.frame = CGRectMake(0, 0, kInnerCirlceLayerWidth, kInnerCirlceLayerWidth);

		// Calculate the x and y coordinate. Points go around the outer circle starting at pi = 0.
		int section = i > kInitialInnerPeopleCount -  1 ? kInitialInnerPeopleCount - 1 : i;
		float trig = section / (kInitialInnerPeopleCount / 2.0) * M_PI;
		float x = kInnerCirlceViewRadius / 2.0 + cosf(trig) * (kInnerCirlceViewRadius - kInnerCircleRatioDifference) /2.0;
		float y = kInnerCirlceViewRadius / 2.0 - sinf(trig) * (kInnerCirlceViewRadius - kInnerCircleRatioDifference) /2.0;

		innerPlaceholderLayer.position = CGPointMake(x, y);
		innerPlaceholderLayer.cornerRadius = innerPlaceholderLayer.frame.size.width / 2;
		innerPlaceholderLayer.masksToBounds = YES;

		[innerPlaceholderLayersArray addObject:innerPlaceholderLayer];
		[innerCircleView.layer addSublayer:innerPlaceholderLayer];
	}

	//Certain manipulations for the right order of things (know iy's gross, but screw it)

	NSMutableArray *reverseArray = [NSMutableArray new];
	[reverseArray insertObject:innerPlaceholderLayersArray[2] atIndex:0];
	[reverseArray addObject:innerPlaceholderLayersArray[1]];
	[reverseArray addObject:innerPlaceholderLayersArray[0]];

	for (int i = (int)innerPlaceholderLayersArray.count - 1; i <= innerPlaceholderLayersArray.count; i--){
		[reverseArray addObject:innerPlaceholderLayersArray[i]];
	}
	innerPlaceholderLayersArray = reverseArray;

	[innerPlaceholderLayersArray removeLastObject];
	[innerPlaceholderLayersArray removeLastObject];
}

#pragma mark - Putting small circles in order

- (void)__placeNewInnerCircleObjectFromView:(SHDDraggablePersonView *)originalView withDistance:(CGFloat)distanceFromCenter shouldLoadNewPerson:(BOOL)shouldLoad{

	[_friendObjectsArray addObject:originalView.currentObject];

	if (shouldLoad){
		[self __loadNewPersonForPosition:originalView.originalViewRect];
	}

	if (currentInnerArrayIndex >= (int)innerPlaceholderLayersArray.count - 1) currentInnerArrayIndex = 0;

	originalView.personNameLabel.hidden = YES;
	originalView.userInteractionEnabled = NO;

	CALayer *givenObjectLAyer = innerPlaceholderLayersArray[currentInnerArrayIndex];

	currentInnerArrayIndex++;

	[innerCircleView addSubview:originalView];

	CGFloat kModifyingConstant = 10;

	CGRect rightRect = [self convertRect:originalView.frame toView:innerCircleView];
	rightRect.origin.x = rightRect.origin.x + kModifyingConstant;
	rightRect.origin.y = rightRect.origin.y + kModifyingConstant;
	rightRect.size.width = rightRect.size.height = kInnerCirlceLayerWidth;
	originalView.personImageView.frame = CGRectMake(0, 0, kInnerCirlceLayerWidth, kInnerCirlceLayerWidth);
	originalView.personImageView.layer.cornerRadius = kInnerCirlceLayerWidth / 2;

	originalView.frame = rightRect;

	[innerCircleView bringSubviewToFront:originalView];

	[UIView animateWithDuration:0.2 animations:^{
		originalView.frame = CGRectMake(givenObjectLAyer.frame.origin.x, givenObjectLAyer.frame.origin.y, kInnerCirlceLayerWidth, kInnerCirlceLayerWidth);
		originalView.personImageView.layer.borderColor = MAIN_TINT_COLOR.CGColor;
	}];

	[innerCircleViewsArray addObject:originalView];

	if (innerCircleViewsArray.count > kMaxOuterPeopleCount){

		int rightRange = 1;
		int targetNumber = (int)innerCircleViewsArray.count - kMaxOuterPeopleCount;

		if (targetNumber < 10) {
			rightRange = 1;
		}else{
			while (targetNumber > 0) {
				targetNumber /= 10;
				rightRange++;
			}
		}

		NSMutableAttributedString *titleText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"+%d \nfriends", (int)innerCircleViewsArray.count - kMaxOuterPeopleCount]];
		[titleText addAttributes:@{NSForegroundColorAttributeName : MAIN_TINT_COLOR_DARK} range:NSMakeRange(0, titleText.length)];
		[centerCountLabel setAttributedText:titleText];
	}else{
		NSMutableAttributedString *titleText = [[NSMutableAttributedString alloc] initWithString:@"Drag &\nDrop"];
		[titleText addAttributes:@{NSForegroundColorAttributeName : MAIN_TINT_COLOR_DARK} range:NSMakeRange(0, titleText.length)];
		[centerCountLabel setAttributedText:titleText];
	}
}

- (void)__loadNewPersonForPosition:(CGRect)position{

	if (currentMemberCount - 1 >= mainPersonsArray.count - 1) {
		return;
	}

	SHDPerson *personObject = mainPersonsArray[currentMemberCount];

	SHDDraggablePersonView *personView = [[SHDDraggablePersonView alloc] initWithFrame:position];
	[personView.personImageView setImage:[UIImage imageNamed:@"imgPerson.png"]];
	personView.currentObject = personObject;
	personView.personNameLabel.text = personObject.friendName;
	UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
	[panGesture setMaximumNumberOfTouches:1];
	[panGesture setMinimumNumberOfTouches:1];
	[panGesture setCancelsTouchesInView:YES];
	panGesture.delegate = self;
	[personView addGestureRecognizer:panGesture];
	[gridImage addSubview:personView];
	personView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);

	[UIView animateWithDuration:0.2 animations:^{
		personView.transform = CGAffineTransformIdentity;
	}];

	currentMemberCount++;
}

#pragma mark - Private Gesture Methods

- (void)handlePan:(UIPanGestureRecognizer*)sender{

	if (sender.state == UIGestureRecognizerStateBegan) {
		isDragging = YES;
	}

	[self adjustAnchorPointForGestureRecognizer:sender];

	CGPoint translation = [sender translationInView:self];

	[sender.view.superview bringSubviewToFront:sender.view];

	[sender.view setCenter:CGPointMake([sender.view center].x + translation.x, [sender.view center].y + translation.y)];

	[sender setTranslation:(CGPoint){0, 0} inView:self];

	if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {

		if ([sender.view isKindOfClass:[SHDDraggablePersonView class]]){

			CGFloat distance =  [self distanceFromGivenCenter:innerCircleView.center withCertainPoint:sender.view.center];

			if (distance <= kInnerCirlceViewRadius / 2){
				[self __placeNewInnerCircleObjectFromView:(SHDDraggablePersonView *)sender.view withDistance:distance shouldLoadNewPerson:YES];
			}else{
				[UIView animateWithDuration:0.22 animations:^{
					[(SHDDraggablePersonView *)sender.view setFrame:[(SHDDraggablePersonView *)sender.view originalViewRect]];
				}];
			}
		}
		isDragging = NO;
	}
}

-(float)distanceFromGivenCenter:(CGPoint)centerPoint withCertainPoint:(CGPoint)evaluatedPoint{

	CGFloat dx = centerPoint.x - evaluatedPoint.x;
	CGFloat dy = centerPoint.y - evaluatedPoint.y;

	return sqrt(dx*dx + dy*dy);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
	return YES;
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
	if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
		UIView *piece = self;
		CGPoint locationInView = [gestureRecognizer locationInView:piece];
		CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];

		piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
		piece.center = locationInSuperview;
	}
}

#pragma mark - Data Mngmnt

- (void)placeOuterArrayObjectsFromArray:(NSArray *)friendsArray{

	for (SHDDraggablePersonView *tmpView in gridImage.subviews) {
		if ([tmpView isKindOfClass:[SHDDraggablePersonView class]]) {
			[tmpView removeFromSuperview];
		}
	}

	mainPersonsArray = friendsArray;

	for (int i = 0; i < friendsArray.count; i++) {

		if (i > outerPlaceholderLayersArray.count - 1){
			break;
		}

		CALayer *tmpLayer = outerPlaceholderLayersArray[i];
		SHDPerson *personObject = friendsArray[i];

		SHDDraggablePersonView *personView = [[SHDDraggablePersonView alloc] initWithFrame:tmpLayer.frame];
		[personView.personImageView setImage:[UIImage imageNamed:@"imgPerson.png"]];
		personView.currentObject = personObject;
		personView.personNameLabel.text = personObject.friendName;
		UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
		[panGesture setMaximumNumberOfTouches:1];
		[panGesture setMinimumNumberOfTouches:1];
		[panGesture setCancelsTouchesInView:YES];
		panGesture.delegate = self;
		[personView addGestureRecognizer:panGesture];
		[gridImage addSubview:personView];
	}

	currentMemberCount = (int)outerPlaceholderLayersArray.count;
}

- (void)placeInnerArrayObjectsFromArray:(NSArray *)innerPersonsArray{

	NSArray *ourArray = [NSArray arrayWithArray:innerPersonsArray];

	for (SHDDraggablePersonView *tmpView in innerCircleView.subviews) {
		if ([tmpView isKindOfClass:[SHDDraggablePersonView class]]) {
			[tmpView removeFromSuperview];
		}
	}

	[_friendObjectsArray removeAllObjects];
	[innerCircleViewsArray removeAllObjects];
	currentInnerArrayIndex = 0;

	for (SHDPerson *tmpperson in ourArray){
		CALayer *tmpLayer = outerPlaceholderLayersArray[0];
		SHDDraggablePersonView *personView = [[SHDDraggablePersonView alloc] initWithFrame:tmpLayer.frame];
		[personView.personImageView setImage:[UIImage imageNamed:@"imgPerson.png"]];
		personView.currentObject = tmpperson;
		personView.personNameLabel.text = tmpperson.friendName;
		[self __placeNewInnerCircleObjectFromView:personView withDistance:10 shouldLoadNewPerson:NO];
	}
}

@end