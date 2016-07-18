//
//  SHDPerson.h
//  SHDCircularView
//
//  Created by Sergey Grischyov on 09.09.14.
//  Copyright (c) 2014 ShadeApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SHDPerson : NSObject

@property (nonatomic, retain) NSString * friendBirthdayTS;
@property (nonatomic, retain) NSString * friendEmail;
@property (nonatomic, retain) NSString * friendFacebookID;
@property (nonatomic, retain) NSString * friendFacebookURL;
@property (nonatomic, retain) NSString * friendID;
@property (nonatomic, retain) NSString * friendImgURL;
@property (nonatomic, retain) NSString * friendLogin;
@property (nonatomic, retain) NSString * friendName;
@property (nonatomic, retain) NSString * friendPhone;
@end