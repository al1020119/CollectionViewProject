//
//  MBCPlayViewCtr.m
//  iCocosCollection
//
//  Created by iCocos on 16/8/4.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//

#import "MBCPlayViewCtr.h"
#import <AVFoundation/AVFoundation.h>
#import "MBCPlayView.h"
//横竖屏
#import "MBCTransverseNav.h"
#import "MBCVertivalNav.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MBCPlayViewCtr ()<MBCTansveNavDelegate,MBCVertivalNavDelegate>
{
    //直播需要传的uid
    NSString *_uid;
    //旋转动画
    CATransform3D myTransform;
    //横屏
    MBCTransverseNav *_transverseNav;
    //竖屏
    MBCVertivalNav *_verticalNav;
    
}
@property (nonatomic,strong)AVPlayer *player;
//播放器
@property (nonatomic,strong)MBCPlayView *playerView;
// playerItem是管理资源的对象
@property (nonatomic,strong)AVPlayerItem *playerItem;
@end

@implementation MBCPlayViewCtr

-(instancetype)initWithVideoId:(NSString *)uid
{
    self= [super init];
    if (!self)  return nil;
    
    _uid = uid;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    //创建播放器
    [self createBasicConfig];
    //竖屏
    [self createVerticalNav];
    //横屏
    [self createTransverseNaV];

    //播放视频
    [self playVideo];
}


#pragma mark -横屏nav
-(void)createTransverseNaV
{
    //初始化横屏
    _transverseNav = [[MBCTransverseNav alloc]initWithFrame:CGRectMake(0, 0, ScreenHeight, ScreenWidth)];
    //设置代理
    _transverseNav.delegate = self;
    [self.view addSubview:_transverseNav];
    //旋转的角度
    CATransform3D transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1.0);
    _transverseNav.layer.transform = transform;
    _transverseNav.center = self.view.center;
    
    _transverseNav.hidden = YES;
}

#pragma mark -GGTransverseNaVDelegate
-(void)TransverseNavWillDidOnclick:(NSInteger)tag
{
    if (tag==201) { //退出全屏
        _playerView.frame = CGRectMake(0, 20, ScreenWidth*9/16, ScreenWidth);
        _transverseNav.hidden = YES;
        
        [UIView animateWithDuration:0.3 animations:^{
            _playerView.layer.transform = myTransform;
            _verticalNav.alpha= 0;
            _playerView.center = CGPointMake(ScreenWidth/2, 20+ScreenWidth*9/32);
        } completion:^(BOOL finished) {
            _playerView.center = self.view.center;
            _verticalNav.alpha = 1;
            _verticalNav.hidden = NO;
            _playerView.center = CGPointMake(ScreenWidth/2, 20+ScreenWidth*9/32);
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
        }];
    }
}

#pragma mark -竖屏nav
-(void)createVerticalNav
{
    _verticalNav = [[MBCVertivalNav alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenWidth*9/16)];
    _verticalNav.delegate = self;
    [self.view addSubview:_verticalNav];
    
}

#pragma mark -GGVerticalNavDelegate
-(void)didWillVerticalNavOnclick:(NSInteger)tag
{
    if (tag==101) {//返回
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.navigationController.navigationBarHidden = NO;
    }else if (tag==102)//进入全屏
    {
        [[UIApplication sharedApplication]setStatusBarHidden:YES];
        //让宽度变成屏幕的高度 高度变成屏幕的宽度
        _playerView.frame = CGRectMake(0, 0, ScreenHeight, ScreenWidth);
        _verticalNav.hidden = YES;
        
        [UIView animateWithDuration:0.3 animations:^{
            CATransform3D transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1.0);
            _playerView.layer.transform = transform;
            _playerView.center = self.view.center;
            _transverseNav.alpha = 0;
        } completion:^(BOOL finished) {
            _playerView.center = self.view.center;
            _transverseNav.alpha = 1;
            _transverseNav.hidden = NO;
        }];
    }
}
#pragma mark -添加播放器
-(void)createBasicConfig
{
    //初始化控制器
    _playerView = [[MBCPlayView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenWidth*9/16)];
    //给旋转动画赋值
    myTransform = _playerView.layer.transform;
    
    [self.view addSubview:_playerView];
}

#pragma mark -调入播放网址
-(void)playVideo
{
    //根据不同的vid播放不同的视频
    NSMutableString *filePath = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"http://hls.quanmin.tv/live/%@/playlist.m3u8",_uid]];
   
    //中文编码
    NSString *str =[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //URL地址
    NSURL *videoUrl = [NSURL URLWithString:str];
    
    self.playerItem  =[AVPlayerItem playerItemWithURL:videoUrl];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.player = _player;
    [self.playerView.player play];
    
}

-(void)dealloc
{
    NSLog(@"释放");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
@end
