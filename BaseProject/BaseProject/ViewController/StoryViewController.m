//
//  StoryViewController.m
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "StoryViewController.h"
#import "StoryViewModel.h"
#import "Factory.h"
#import "ParallaxHeaderView.h"
#import "myUILabel.h"
#import "GradientView.h"

@interface StoryViewController ()<UIWebViewDelegate,ParallaxHeaderViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)StoryViewModel *storyVM;
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)ParallaxHeaderView *webHeaderView;
@property (nonatomic,strong)myUILabel *titleLabel;
@property (nonatomic,strong)UILabel *sourceLabel;
@property (nonatomic,strong)GradientView *blurView;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIView *statusBarBackground;
@property (nonatomic)BOOL stausBarFlag;
@property (nonatomic,strong)UIImageView *refreshImageView;
//滑到对应位置时调整arrow方向
@property (nonatomic)BOOL arrowState;
@property (nonatomic)BOOL dragging;
@property (nonatomic)BOOL triggered;
//判断是否有图
@property (nonatomic)BOOL hasImage;

@end

@implementation StoryViewController

{
    CGFloat _orginalHeight;
}
-(void)setArrowState:(BOOL)arrowState
{
    if (arrowState == YES) {
        [UIView animateWithDuration:(0.2) animations:^{
            self.refreshImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }else{
        [UIView animateWithDuration:(0.2) animations:^{
            self.refreshImageView.transform = CGAffineTransformIdentity;
        }];
    }
}
-(void)setStausBarFlag:(BOOL)stausBarFlag
{
    [UIView animateWithDuration:(0.2) animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}
- (instancetype)initWithStoryId:(NSString *)storyId
{
    if (self = [super init]) {
        self.storyId = storyId;
    }
    return self;
}
-(StoryViewModel *)storyVM
{
    if (!_storyVM) {
        _storyVM = [[StoryViewModel alloc]initWithStoryId:self.storyId];
    }
    return _storyVM;
}
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [UIWebView new];
        [_webView loadHTMLString:[self.storyVM storyHTML] baseURL:nil];
//        [_webView loadRequest:[NSURLRequest requestWithURL:[self.storyVM storyURL]]];
        _webView.delegate = self;
        [_webView.scrollView addSubview:self.webHeaderView];
          //对scrollView做基本配置
        _webView.scrollView.delegate = self;
        _webView.scrollView.clipsToBounds =NO;
        _webView.scrollView.showsVerticalScrollIndicator =false;
    }
    return _webView;
}
-(UIImageView *)refreshImageView
{
    if (!_refreshImageView) {
        _refreshImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kWindowW/2-47, -30, 15, 15)];
        _refreshImageView.contentMode = UIViewContentModeScaleAspectFill;
        _refreshImageView.image = [UIImage imageNamed:@"arrow"];
        [_refreshImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _refreshImageView.tintColor = kRGBColor(215, 215, 215);
    }
    return _refreshImageView;
}
-(GradientView *)blurView
{
    if (!_blurView) {
        _blurView = [[GradientView alloc]initWithFrame:CGRectMake(0, -85, kWindowW, _orginalHeight +85) type:TRANSPARENT_GRADIENT_TWICE_TYPE];
        //在blurView上添加"载入上一篇"Label
        UILabel *refreshLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 25, kWindowW, 45)];
        refreshLabel.text = @"载入上一篇";
        refreshLabel.textAlignment = NSTextAlignmentCenter;
        refreshLabel.textColor = kRGBColor(215, 215, 215);
        refreshLabel.font = [UIFont systemFontOfSize:14];
        [_blurView addSubview:refreshLabel];
        //在blurView上添加"载入上一篇"图片
        [_blurView addSubview:self.refreshImageView];
    }
    return _blurView;
}
-(myUILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[myUILabel alloc]initWithFrame:CGRectMake(15, _orginalHeight-80, kWindowW-30, 60)];
        _titleLabel.font =[UIFont boldSystemFontOfSize:21];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor blackColor];
        _titleLabel.shadowOffset = CGSizeMake(0, 1);
        _titleLabel.verticalAlignment = VerticalAlignmentBottom;
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"阿斯蒂芬回家卡上都会犯贱的疯狂加快建设的打";
        

    }
    return _titleLabel;
}
-(UILabel *)sourceLabel
{
    if (!_sourceLabel) {
        _sourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, _orginalHeight-22, kWindowW -30, 15)];
        _sourceLabel.font = [UIFont systemFontOfSize:9];
        _sourceLabel.textColor = [UIColor lightTextColor];
        _sourceLabel.textAlignment = NSTextAlignmentRight;
        _sourceLabel.text = @"fasdfa";

    }
    return _sourceLabel;
}
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW/320*198)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.image = [UIImage imageNamed:@"WebTopImage.jpg"];
        _orginalHeight = _imageView.frame.size.height;
        //设置图片上方的title
        [_imageView addSubview:self.titleLabel];
        //设置image上的image sourcelabel
        [_imageView addSubview:self.sourceLabel];
        //设置imageview上的BlurView
        [_imageView addSubview:self.blurView];
        //设置不被遮蔽
        [_imageView bringSubviewToFront:self.titleLabel];
        [_imageView bringSubviewToFront:self.sourceLabel];

    }
    return _imageView;
}
-(ParallaxHeaderView *)webHeaderView
{
    if (!_webHeaderView) {
        _webHeaderView = [ParallaxHeaderView parallaxWebHeaderViewWithSubView:self.imageView forSize:CGSizeMake(kWindowW, kWindowW/320*198)];
        _webHeaderView.delegate = self;
    }
    return _webHeaderView;
}
-(UIView *)statusBarBackground
{
    if (!_statusBarBackground) {
        _statusBarBackground = [UIView new];
        [self.view addSubview:_statusBarBackground];
        [_statusBarBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(-20);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(20);
        }];
    }
    return _statusBarBackground;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.stausBarFlag = NO;
    _orginalHeight = 0;
    self.arrowState = NO;
    self.view.clipsToBounds = YES;
    self.dragging = NO;
    self.triggered = NO;
    self.hasImage = NO;
    //避免webScrollView的ContentView过长 挡住底层View
    self.view.clipsToBounds = YES;
    if (self.hasImage == NO) {
        self.statusBarBackground.backgroundColor = [UIColor whiteColor];
    }
  
    
    
    [Factory addBackItemToVC:self];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.storyVM getDataFromNetCompleteHandle:^(NSError *error) {
            [self.view addSubview:self.webView];
            [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.mas_equalTo(0);
                make.left.right.bottom.mas_equalTo(0);
                make.top.mas_equalTo(self.statusBarBackground.mas_bottomMargin);
            }];
        }];
    });

    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    [self.webView loadWebView];
}
//加载普通header
- (void)loadNormalHeader
{
    [self.webView.scrollView addSubview:self.refreshImageView];
    UILabel *refreshLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, -45, kWindowW, 45)];
    refreshLabel.text = @"载入上一篇";
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    refreshLabel.textColor = kRGBColor(215, 215, 215);
    refreshLabel.font = [UIFont systemFontOfSize:14];
    [self.webView.scrollView addSubview:refreshLabel];

    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)bottomView
{
    UIView *bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
}
#pragma mark - scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat incrementY = scrollView.contentOffset.y;
    if (incrementY < 0) {
        //
        self.titleLabel.frame = CGRectMake(15, _orginalHeight - 80-incrementY, kWindowW - 30, 60);
        self.sourceLabel.frame = CGRectMake(15, _orginalHeight - 20 -incrementY, kWindowW - 30, 15);
        //不断添加删除blurView以保证frame正确
        self.blurView.frame = CGRectMake(0, -85 -incrementY, kWindowW, _orginalHeight +85);
        [self.blurView.layer.sublayers[0] removeFromSuperlayer];
        [self.blurView insertTwiceTransparentGradient];
        //如果下拉超过65pixels则改变图片方向
        if (incrementY <= -65) {
            //如果此时是第一次检测到松手则加载上一篇
#warning 此处代码
            self.arrowState = YES;
            if ((!self.dragging && !self.triggered)) {
                [self loadNewArticle:YES];
                self.triggered = YES;
                return;
            }
        }else{
            self.arrowState = NO;
        }
   
        //使titleLabel不被遮挡
        //设置不被遮蔽
        [_imageView bringSubviewToFront:self.titleLabel];
        [_imageView bringSubviewToFront:self.sourceLabel];

        
    }
    //监听contentOffsetY以改变StatusBarUI
    if (incrementY >kWindowW/320*198) {
        if (self.stausBarFlag) {
            self.stausBarFlag =false;
        }
        self.statusBarBackground.backgroundColor = [UIColor whiteColor];
    }else{
//        if (!self.stausBarFlag) {
//            self.stausBarFlag = YES;
//            return;
//        }
        self.statusBarBackground.backgroundColor = [UIColor clearColor];
    }
    [self.webHeaderView layoutWebHeaderViewForScrollViewOffset:scrollView.contentOffset];
}
//记录下啦状态
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.dragging = NO;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.dragging = YES;
}
//设置滑动极限
-(void)lockDirection
{
    [self.webView.scrollView setContentOffset:CGPointMake(0, -85)];

}
//依据statusBarFlag返回StatusBar颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.stausBarFlag) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}
//加载新文章
- (void)loadNewArticle:(BOOL)previous
{
    //生成动画开始位置
    CGAffineTransform offScreenUp = CGAffineTransformMakeTranslation(0,-kWindowH);
    CGAffineTransform offScreenDown = CGAffineTransformMakeTranslation(0, kWindowH);
    //生成新View并传入新数据
    StoryViewController *toVC = [[StoryViewController alloc]initWithStoryId:@"7463842"];
    UIView *toView = toVC.view;
    toView.frame = self.view.frame;
    //将新View放置到屏幕之外并添加到ScrollView上
    //生成原View截图并添加到主View上
    UIView *fromView = [self.view snapshotViewAfterScreenUpdates:YES];
    [self.view addSubview:fromView];
    //将toView放置到屏幕之外并添加到主View上
    toView.transform = offScreenUp;
    [self.view addSubview:toView];
    [self addChildViewController:toVC];
    //动画开始
    [UIView animateWithDuration:0.2 animations:^{
       //fromView下滑出屏幕，新View滑入屏幕
        fromView.transform = offScreenDown;
        toView.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        NSLog(@"动画执行完成");
        //动画完成后清理底层webView、statusBarBackground，以及滑出屏幕的fromView，这里也有问题，多次加载新文章会每次留一层UIView 待解决
        [self.webView removeFromSuperview];
        [self.statusBarBackground removeFromSuperview];
        [fromView removeFromSuperview];
        
    }];
    
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self showProgress]; //旋转提示
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hideProgress];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self hideProgress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
