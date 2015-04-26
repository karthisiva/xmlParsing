//
//  ViewController.m
//  xmlParsing
//
//  Created by Griffin on 26/04/15.
//  Copyright (c) 2015 Griffin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    articles = [[NSMutableArray alloc] init];
    item = [[NSMutableDictionary alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self parseXMLFileAtURL:@"http://news.prlog.org/rss.xml"];

}
-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PrototypeCell
//- (customCell *)prototypeCell
//{
//    if (!_prototypeCell) {
//        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([customCell class])];
//    }
//    
//    return _prototypeCell;
//}

#pragma mark - Configure
- (void)configureCell:(customCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *quote = [articles objectAtIndex:indexPath.row];

    cell.titleLbl.numberOfLines=0;
    cell.titleLbl.text = [NSString stringWithFormat:@"%@",quote];
}

#pragma mark - UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    customCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([customCell class])];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IOS8_OR_ABOVE) {
        return UITableViewAutomaticDimension;
    }
    
    //self.prototypeCell.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(self.prototypeCell.bounds));
    
    [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
    
    [self.prototypeCell updateConstraintsIfNeeded];
    [self.prototypeCell layoutIfNeeded];
    
    return [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
}
- (void)parseXMLFileAtURL:(NSString *)URL
{
    
    
    
    
    errorParsing=NO;
    NSURL *url=[NSURL URLWithString:URL];

    rssParser =[[NSXMLParser alloc] initWithContentsOfURL:url];
    [rssParser setDelegate:self];
    // You may need to turn some of these on depending on the type of XML file you are parsing
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
    [rssParser setShouldResolveExternalEntities:NO];
    
    [rssParser parse];

    
}


- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"File found and parsing started");
    
}
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    
    NSString *errorString = [NSString stringWithFormat:@"Error code %li", (long)[parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
    
    
    errorParsing=YES;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    currentElement=elementName;
    NSLog(@"current element--------->%@",currentElement);

    if([elementName isEqualToString:@"item"])
    {
        errorParsing=YES;
        ElementValue = [[NSMutableString alloc] init];
       
     
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    if([elementName isEqualToString:@"item"])
    {
        errorParsing=NO;
//      [item setObject:ElementValue forKey:@"title"];
        [articles addObject:ElementValue];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (errorParsing)
    {
        if ([currentElement isEqualToString:@"title"])
        {
            [ElementValue appendString:string];

        }
    }
    
}


- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
    if (errorParsing==NO)
    {
        NSLog(@"XML processing done!");
    } else
    {
        NSLog(@"Error occurred during XML processing");
    }
//    NSLog(@"dictonary------>%@",item);
//    NSLog(@"load array-------->%@",articles);
//    NSLog(@"load array count-------->%lu",(unsigned long)articles.count);
}
@end
