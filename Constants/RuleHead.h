//
//  RuleHead.h
//  birdplanOC
//
//  Created by ygj on 2017/7/19.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#ifndef RuleHead_h
#define RuleHead_h

// 中文姓名
#define verifyName /^[\u4e00-\u9fa5\.\·]{2,20}$/
// 身份证号
#define verifyIdcard /^[1-9]\d{13,16}([0-9]|X|x)$/
// 手机号
#define verifyPhoneNumber: /^1[3-9]\d{9}$/

#endif /* RuleHead_h */
