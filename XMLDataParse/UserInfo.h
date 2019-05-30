//
//  UserInfo.h
//  XMLDataParse
//
//  Created by Civet on 2019/5/27.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property(nonatomic,retain) NSString *mUserName;
@property(nonatomic,retain) NSString *mUserID;
@property(nonatomic,retain) NSString *mUserCredit;
@property(nonatomic,assign) NSString *mUserExp;
@property(nonatomic,retain) NSString *mUserNickName;
@property(nonatomic,retain) NSString *mHeaderPath;
@property(nonatomic,assign) NSInteger *mGroupID;
@property(nonatomic,assign) NSInteger *mFriendNum;

@end
