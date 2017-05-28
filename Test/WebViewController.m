//
//  WebViewController.m
//  Test
//
//  Created by Archmage on 2017/5/28.
//  Copyright © 2017年 Archmage. All rights reserved.
//

#import "WebViewController.h"
#import "ImagesLIstVCTableViewController.h"

static NSString* const OnClickToSelectPictureJavaScriptString=
@"  var imgs = new Array();                                     \
function setImageClickFunction(){                               \
var tagImgs = document.getElementsByTagName(\"img\");       \
var selectorImgs = document.querySelectorAll(\"a>img\");    \
for (var i=0; i<tagImgs.length; i++){                       \
var tagSrc = tagImgs[i].src;                            \
var j=0;                                                \
for (; j<selectorImgs.length; j++) {                    \
var selectorSrc = selectorImgs[j].src;              \
if (tagSrc == selectorSrc) {                        \
break;                                          \
}                                                   \
}                                                       \
if (j > selectorImgs.length - 1) {                      \
imgs.push(tagSrc);                                  \
tagImgs[i].onclick=function(){click(this.src);};    \
}                                                       \
}                                                           \
}                                                               \
\
function getUrls(){                                             \
var imgUrls = \"\";                                         \
for (var i=0;i<imgs.length;i++){                            \
var imagesrc = imgs[i];                                 \
if(imagesrc.indexOf(\"http\") < 0) {                   \
imagesrc=document.location.host+imagesrc ;          \
}                                                       \
if(i == 0) {                                            \
imgUrls += imagesrc ;                               \
} else {                                                \
imgUrls += \"@\" + imagesrc ;                       \
}                                                       \
}                                                           \
return imgUrls;                                             \
}                                                               \
\
function click(imagesrc){                                       \
if(imagesrc.indexOf(\"http:\") < 0)                         \
{ imagesrc=document.location.href+imagesrc ;}               \
var url=\"qiushibaike\"+imagesrc;                           \
document.location.href = url;                               \
}";

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURL *orgUrl;

@property (nonatomic, strong) NSArray *allImgUrls;

@property (nonatomic, strong) UIButton *button;
@end

@implementation WebViewController

- (instancetype)initWithUrl:(NSURL *)url
{
    if (self = [super init]) {
        self.orgUrl = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    self.webView = [[UIWebView alloc] init];
    [self.view addSubview:self.webView];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.frame = CGRectMake(0, 0, CGRectGetWidth(screenBounds), CGRectGetHeight(screenBounds));
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:_orgUrl];
    [self.webView loadRequest:request];
    self.webView.delegate = self;

    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"image" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(onSeeImages) forControlEvents:UIControlEventTouchUpInside];
    [self.webView addSubview:self.button];
    
    self.button.frame = CGRectMake(10, CGRectGetHeight(screenBounds) - 120, 80, 30);
    self.button.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onSeeImages
{
    if (self.allImgUrls.count > 0) {
        ImagesLIstVCTableViewController *vc = [[ImagesLIstVCTableViewController alloc] initWithImgsArr:self.allImgUrls];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSLog(@"not loaded or no images");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- UIWebViewDelegate
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    return YES;
//}
//
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//    
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *urls = nil;
    urls = [self.webView stringByEvaluatingJavaScriptFromString:OnClickToSelectPictureJavaScriptString];
    urls =[self.webView stringByEvaluatingJavaScriptFromString:@"setImageClickFunction();"];
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    urls = [self.webView stringByEvaluatingJavaScriptFromString:@"getUrls();"];
    NSArray *imgUrls = [urls componentsSeparatedByString:@"@"];
    self.allImgUrls = [imgUrls mutableCopy];
}

//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    
//}

@end
