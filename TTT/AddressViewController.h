//
//  AddressViewController.h
//  TTT
//
//  Created by Ibokan on 14-4-23.
//  Copyright (c) 2014年 孟延军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableData * datas;
}

@property(strong,nonatomic)NSMutableArray * earr;

@property(strong,nonatomic)UITableView * tabView;

@end
