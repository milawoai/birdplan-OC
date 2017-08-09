//
//  BDPImageConstants.h
//  birdplanOC
//
//  Created by ygj on 2017/8/6.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#ifndef BDPImageConstants_h
#define BDPImageConstants_h

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

#endif /* BDPImageConstants_h */
