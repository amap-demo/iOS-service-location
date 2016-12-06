//
//  BackgroundLocationViewController.m
//  AMapLocationKit
//
//  Created by liubo on 8/4/16.
//  Copyright © 2016 AutoNavi. All rights reserved.
//

#import "BackgroundLocationViewController.h"

@interface BackgroundLocationViewController ()<AMapLocationManagerDelegate>

@property (nonatomic, strong) UISegmentedControl *showSegment;

@property (nonatomic, assign) NSInteger locateCount;
@property (nonatomic, strong) UILabel *locationgInfoLabel;

@end

@implementation BackgroundLocationViewController

#pragma mark - Action Handle

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //开启带逆地理连续定位
    [self.locationManager setLocatingWithReGeocode:YES];
}

- (void)showsSegmentAction:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 1)
    {
        //停止定位
        [self.locationManager stopUpdatingLocation];
        
        self.locateCount = 0;
    }
    else
    {
        //开始进行连续定位
        [self.locationManager startUpdatingLocation];
    }
}

- (void)updateLabelTextWithLocation:(CLLocation *)location regeocode:(AMapLocationReGeocode *)regeocode
{
    NSMutableString *infoString = [NSMutableString stringWithFormat:@"连续定位完成:%d\n\n回调时间:%@\n经 度:%f\n纬 度:%f\n精 度:%f米\n海 拔:%f米\n速 度:%f\n角 度:%f\n", (int)self.locateCount, location.timestamp, location.coordinate.longitude, location.coordinate.latitude, location.horizontalAccuracy, location.altitude, location.speed, location.course];
    
    if (regeocode)
    {
        NSString *regeoString = [NSString stringWithFormat:@"国 家:%@\n省:%@\n市:%@\n城市编码:%@\n区:%@\n区域编码:%@\n地 址:%@\n兴趣点:%@\n", regeocode.country, regeocode.province, regeocode.city, regeocode.citycode, regeocode.district, regeocode.adcode, regeocode.formattedAddress, regeocode.POIName];
        [infoString appendString:regeoString];
    }
    
    [self.locationgInfoLabel setText:infoString];
}

#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    self.locateCount += 1;
    
    [self updateLabelTextWithLocation:location regeocode:reGeocode];
}

#pragma mark - Initialization

- (void)initToolBar
{
    UIBarButtonItem *flexble = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                             target:nil
                                                                             action:nil];
    
    self.showSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"开始后台定位", @"停止后台定位", nil]];
    [self.showSegment addTarget:self action:@selector(showsSegmentAction:) forControlEvents:UIControlEventValueChanged];
    self.showSegment.selectedSegmentIndex = 0;
    UIBarButtonItem *showItem = [[UIBarButtonItem alloc] initWithCustomView:self.showSegment];
    
    self.toolbarItems = [NSArray arrayWithObjects:flexble, showItem, flexble, nil];
}

- (void)configSubview
{
    self.locationgInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, CGRectGetWidth(self.view.bounds)-80, CGRectGetHeight(self.view.bounds)-150)];
    [self.locationgInfoLabel setBackgroundColor:[UIColor clearColor]];
    [self.locationgInfoLabel setTextColor:[UIColor blackColor]];
    [self.locationgInfoLabel setFont:[UIFont systemFontOfSize:14]];
    [self.locationgInfoLabel setAdjustsFontSizeToFitWidth:YES];
    [self.locationgInfoLabel setTextAlignment:NSTextAlignmentLeft];
    [self.locationgInfoLabel setNumberOfLines:0];
    
    [self.view addSubview:self.locationgInfoLabel];
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"后台定位";
    
    self.locateCount = 0;
    
    [self initToolBar];
    
    [self configSubview];
    
    [self configLocationManager];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.toolbar.translucent       = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.toolbarHidden             = NO;
    self.navigationController.toolbar.translucent       = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.locationManager startUpdatingLocation];
}

@end
