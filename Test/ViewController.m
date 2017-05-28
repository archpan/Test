//
//  ViewController.m
//  Test
//
//  Created by Archmage on 2017/5/22.
//  Copyright © 2017年 Archmage. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *imagesArr;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *btn;

//@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 300, 40)];
    [self.view addSubview:self.textField];
    self.textField.delegate = (id)self;
    
    self.textField.text = @"https://www.baidu.com";
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn addTarget:self action:@selector(onBtn) forControlEvents:UIControlEventTouchUpInside];
    self.btn.frame = CGRectMake(280, 140 + 20, 40, 20);
    [self.btn setTitle:@"OK" forState:UIControlStateNormal];
    [self.view addSubview:self.btn];
    self.btn.backgroundColor = [UIColor redColor];
    
//    self.webView = [[UIWebView alloc] init];
//    [self.view addSubview:self.webView];
//    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
//    // Do any additional setup after loading the view, typically from a nib.
//    
//    self.imagesArr = @[@"Snip20170519_2", @"Snip20170519_2", @"Snip20170519_2"];
//    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 200) style:UITableViewStylePlain];
//    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
//    [self.view addSubview:self.tableView];
//    
//    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 100 + 200 + 5, CGRectGetWidth(self.view.frame), 20)];
//    [self.view addSubview:self.pageControl];
//    self.pageControl.numberOfPages = self.imagesArr.count;
//    
//    self.tableView.delegate = (id)self;
//    self.tableView.dataSource = (id)self;
//    self.tableView.frame = CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 200);
//    self.view.backgroundColor = [UIColor blackColor];
//    self.tableView.pagingEnabled = YES;
//    self.tableView.showsVerticalScrollIndicator = NO;
}

- (void)onBtn
{
    NSString *urlString = self.textField.text;
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) {
        
    } else {
        WebViewController *webVc = [[WebViewController alloc] initWithUrl:url];
        [self.navigationController pushViewController:webVc animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imagesArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGRectGetWidth(self.view.frame);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"imageCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.transform = CGAffineTransformMakeRotation(M_PI_2);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
        imageView.tag = 11111;
        [cell addSubview:imageView];
    }
    
    NSString *imageName = self.imagesArr[indexPath.row];
    UIImageView *imageView = [cell viewWithTag:11111];
    if (imageView) {
        imageView.image = [UIImage imageNamed:imageName];
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = (self.tableView.contentOffset.y + CGRectGetWidth(self.view.frame) / 2) / CGRectGetWidth(self.view.frame);
    self.pageControl.currentPage = index;
}

@end
