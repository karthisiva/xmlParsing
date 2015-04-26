//
//  ViewController.h
//  xmlParsing
//
//  Created by Griffin on 26/04/15.
//  Copyright (c) 2015 Griffin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customCell.h"
#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IS_IOS8_OR_ABOVE                            (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,NSXMLParserDelegate>
{
#pragma xml datas required
    
    NSXMLParser *rssParser;
    NSMutableArray *articles;
    NSMutableDictionary *item;
    NSString *currentElement;
    NSMutableString *ElementValue;
    BOOL errorParsing;
}



#pragma view datas required

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) customCell *prototypeCell;


- (void)parseXMLFileAtURL:(NSString *)URL;
@end

