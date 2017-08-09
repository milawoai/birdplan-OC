//
//  BDPQRCodeScannerViewController.m
//  birdplanOC
//
//  Created by ygj on 2017/7/16.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPQRCodeScannerViewController.h"
#import "BDPAlertUtils.h"
#import <AVFoundation/AVFoundation.h>

#define defaultScanViewSize 300.f
#define defaultScanViewMarginTop 183.f

@interface BDPQRCodeScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate>
// 会话
@property (nonatomic, strong) AVCaptureSession *session;
// 输入设备
@property (nonatomic, strong) AVCaptureDeviceInput *input;
// 输出设备
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
// 设备
@property (strong,nonatomic)AVCaptureDevice * device;
// 预览图层
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * previewLayer;

@property (assign,nonatomic)CGFloat scanViewSize;
@property (assign,nonatomic)CGFloat scanViewMarginTop;
@property (assign,nonatomic)CGFloat scanViewBottomHeight;

@end

@implementation BDPQRCodeScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startAVCapture];
    [self setUI];
    // 初始化AVCaptue
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setUI {
    [self setNav];
    [self createSubView];
}

- (void)setNav {
    self.title = @"二维码扫描";
}

- (void)createSubView {
    if (self.scanViewSize <= 0 || self.scanViewSize > SCREEN_WIDTH) {
        self.scanViewSize = defaultScanViewSize;
    }
    if (self.scanViewMarginTop <= 0 || self.scanViewMarginTop > SCREEN_HEIGHT_NO_NAV - self.scanViewSize - self.scanViewBottomHeight) {
        self.scanViewMarginTop = defaultScanViewMarginTop;
    }

    [self createFillView:self.scanViewSize marginTop:self.scanViewMarginTop bottomHeight:self.scanViewBottomHeight];
    [self createScanContainerView:self.scanViewSize marginTop:self.scanViewMarginTop bottomHeight:self.scanViewBottomHeight];
}
- (void)createFillView:(CGFloat)blockSize marginTop:(CGFloat)marginTop bottomHeight:(CGFloat)bottomHeight {
    UIView *topFillView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - blockSize) / 2, 0, blockSize, marginTop)];
    UIView *bottomFillView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - blockSize) / 2, blockSize + marginTop, blockSize, SCREEN_HEIGHT_NO_NAV - blockSize - marginTop - bottomHeight)];
    UIView *leftFillView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - blockSize) / 2, SCREEN_HEIGHT_NO_NAV - bottomHeight)];
    UIView *rightFillView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH + blockSize) / 2, 0, (SCREEN_WIDTH - blockSize) / 2, SCREEN_HEIGHT_NO_NAV - bottomHeight)];
    [self loadFillView:topFillView];
    [self loadFillView:bottomFillView];
    [self loadFillView:leftFillView];
    [self loadFillView:rightFillView];
}

- (void)createScanContainerView:(CGFloat)blockSize marginTop:(CGFloat)marginTop bottomHeight:(CGFloat)bottomHeight{
    UIView * scanView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - blockSize) / 2, marginTop, blockSize, blockSize)];
    [scanView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scanView];
}

- (void)loadFillView:(UIView *)fillView {
    if (!fillView) {
        return;
    }
    [fillView setBackgroundColor:[UIColor UIColorFromHex:0x000000 alpha: 0.3]];
    [self.view addSubview:fillView];
}

- (void)startAVCapture {
    
    // 1.判断是否能够将输入添加到会话中
    if (![self.session canAddInput:self.input]) {
        return;
    }
    
    // 2.判断是否能够将输出添加到会话中
    if (![self.session canAddOutput:self.output]) {
        return;
    }
    
    // 3.将输入和输出都添加到会话中
    [self.session addInput:self.input];
    [self.session addOutput:self.output];
    
    // 4.设置输出能够解析的数据类型
    // 注意: 设置能够解析的数据类型, 一定要在输出对象添加到会员之后设置, 否则会报错
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 条码类型 AVMetadataObjectTypeQRCode
    if ([self checkCameraRight]) {
        self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes;
    }
    // 5.添加预览图层
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    [self setScanArea];
   
    // 6.告诉session开始扫描
    [self.session startRunning];
}

- (void)setScanArea {
     // 设置扫描区域，http://blog.csdn.net/lc_obj/article/details/41549469
    if (self.scanViewSize <= 0 || self.scanViewSize > SCREEN_WIDTH) {
        self.scanViewSize = defaultScanViewSize;
    }
    if (self.scanViewMarginTop <= 0 || self.scanViewMarginTop > SCREEN_HEIGHT_NO_NAV - self.scanViewSize - self.scanViewBottomHeight) {
        self.scanViewMarginTop = defaultScanViewMarginTop;
    }
   
    [self.output setRectOfInterest:CGRectMake((self.scanViewMarginTop)/SCREEN_HEIGHT,((SCREEN_WIDTH-self.scanViewSize)/2)/SCREEN_WIDTH,self.scanViewSize/SCREEN_HEIGHT,self.scanViewSize/SCREEN_WIDTH)];
}

#pragma mark - 懒加载
// 会话
- (AVCaptureSession *)session
{
    if (_session == nil) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}

// 拿到设备
- (AVCaptureDevice *)device {
    if (_device == nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

// 拿到输入设备
- (AVCaptureDeviceInput *)input {
    if (_input == nil) {
        _input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    }
    return _input;
}

// 拿到输出对象
- (AVCaptureMetadataOutput *)output {
    if (_output == nil) {
        _output = [[AVCaptureMetadataOutput alloc] init];
    }
    return _output;
}

// 创建预览图层
- (AVCaptureVideoPreviewLayer *)previewLayer {
    if (_previewLayer == nil) {
        _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        _previewLayer.videoGravity =AVLayerVideoGravityResizeAspectFill;
        _previewLayer.frame = [UIScreen mainScreen].bounds;
    }
    return _previewLayer;
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        if (metadataObject) {
            stringValue = metadataObject.stringValue;
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"二维码地址" message:stringValue delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
}

-(BOOL) checkCameraRight {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        [BDPAlertUtils presentAlertWithMessage:@"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“XXXX”打开相机访问权限" ctrl:self];
    
        return NO;
        
    } else {
        return YES;
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

@end
