//
//  ImagesLIstVCTableViewController.m
//  Test
//
//  Created by Archmage on 2017/5/28.
//  Copyright © 2017年 Archmage. All rights reserved.
//

#import "ImagesLIstVCTableViewController.h"
#import <UIImageView+WebCache.h>

@interface ImagesLIstVCTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *imgUrlArr;


@end

@implementation ImagesLIstVCTableViewController

- (instancetype)initWithImgsArr:(NSArray *)imgsArr
{
    if (self = [super init]) {
        _imgUrlArr = imgsArr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imgUrlArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"imageCell";
    static NSInteger imageViewTag = 11111;
    static NSInteger labelTag = 22222;
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imageView.tag = imageViewTag;
        [cell addSubview:imageView];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, CGRectGetWidth(self.view.frame) - 40, 40)];
        label.tag = labelTag;
        label.numberOfLines = 0;
        [cell addSubview:label];
    }
    UIImageView *imageView = [cell viewWithTag:imageViewTag];
    UILabel *label = [cell viewWithTag:labelTag];
    
    NSString *imgUrlStr = self.imgUrlArr[indexPath.row];
    label.text = imgUrlStr;
    [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr]];
    
    return cell;
}

@end
