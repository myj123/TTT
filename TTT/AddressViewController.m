//
//  AddressViewController.m
//  TTT
//
//  Created by Ibokan on 14-4-23.
//  Copyright (c) 2014年 孟延军. All rights reserved.
//

#import "AddressViewController.h"
#import "GDataXMLNode.h"
#import "MapViewController.h"
@interface AddressViewController ()

@end

@implementation AddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"城市";
    self.earr = [NSMutableArray array];
    [self requestData];
    CGRect rect = [[UIScreen mainScreen]bounds];
    self.tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, rect.origin.y, rect.size.width, rect.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tabView];
    self.tabView.dataSource = self;
    self.tabView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)requestData{
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.meituan.com/api/v1/divisions"]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    datas = nil;
    datas = [NSMutableData data];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [datas appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithData:datas options:0 error:nil];
    GDataXMLElement * root = [doc rootElement];
    GDataXMLElement * docList = [[root children] objectAtIndex:0];
    NSArray * arr = [docList children];
    for (GDataXMLElement *obj in arr) {
        NSMutableArray * arr = [NSMutableArray array];
        GDataXMLElement * idstr = [[obj children]objectAtIndex:1];
        NSString * name = [idstr stringValue];
        GDataXMLElement * location = [[obj children]objectAtIndex:2];
        GDataXMLElement * lati = [[location children]objectAtIndex:2];
        GDataXMLElement * loti = [[location children]objectAtIndex:3];
        NSString * latitude = [lati stringValue];
        NSString * longitude = [loti stringValue];
        [arr addObject:name];
        [arr addObject:latitude];
        [arr addObject:longitude];
        [self.earr addObject:arr];
    }
    [self.tabView reloadData];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    datas = nil;
    NSLog(@"%@",[error localizedDescription]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.earr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cell";
    __autoreleasing UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [[self.earr objectAtIndex:indexPath.row] objectAtIndex:0];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MapViewController * map = [[MapViewController alloc]init];
    map.darr = [self.earr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:map animated:YES];
}



@end
