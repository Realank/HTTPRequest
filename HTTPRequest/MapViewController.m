//
//  MapViewController.m
//  HTTPRequest
//
//  Created by Realank on 16/1/6.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <MapKit/MapKit.h>
#import <MBProgressHUD.h>
#define HUD_SHOW [MBProgressHUD showHUDAddedTo:self.view animated:YES];
#define HUD_HIDE [MBProgressHUD hideHUDForView:self.view animated:YES];

@interface MapViewController ()<MAMapViewDelegate,AMapSearchDelegate>{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
}

@property (nonatomic, assign)double latitude;
@property (nonatomic, assign)double longitude;

@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *locationDetail;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //配置用户Key
    [AMapServices sharedServices].apiKey = @"c835f3138e5e7839041aaf7109b5655d";
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
//    _mapView.allowsBackgroundLocationUpdates = YES;
    [self.view addSubview:_mapView];
    
    
    //配置用户Key
    [AMapServices sharedServices].apiKey = @"c835f3138e5e7839041aaf7109b5655d";
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(31.251314, 121.445463);
//    pointAnnotation.title = @"方恒国际";
//    pointAnnotation.subtitle = @"阜通东大街6号";
    
    [_mapView addAnnotation:pointAnnotation];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView* annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
//        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
//        MAPointAnnotation *pointAnnotation = [[_mapView annotations] firstObject];
//        pointAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        self.latitude = userLocation.coordinate.latitude;
        self.longitude = userLocation.coordinate.longitude;
    }
}

- (void)searchLatitude:(CGFloat)latitude longitude:(CGFloat)longitude{
    //构造AMapReGeocodeSearchRequest对象
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:latitude longitude:longitude];
    regeo.radius = 1000;
    regeo.requireExtension = YES;
    
    //发起逆地理编码
    [_search AMapReGoecodeSearch: regeo];
}

//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    HUD_HIDE;
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode];
        NSLog(@"ReGeo: %@", result);
        AMapReGeocode *regeocode = response.regeocode;
        if (regeocode.formattedAddress.length > 0) {
            self.locationDetail = [regeocode.formattedAddress copy];
        }
        if (regeocode.pois.count > 0) {
            self.location = ((AMapPOI*)regeocode.pois[0]).name;
        }
        
        if (self.completeDelegate) {
            MAPointAnnotation *pointAnnotation = [self findPoint];
            NSString* latitude = [NSString stringWithFormat:@"%lf",pointAnnotation.coordinate.latitude];
            NSString* longitude = [NSString stringWithFormat:@"%lf",pointAnnotation.coordinate.longitude];
            [self.completeDelegate mapSearchCompleteWithLatitude:latitude longitude:longitude location:self.location andLocationDetail:self.locationDetail];
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (MAPointAnnotation*)findPoint{
    MAPointAnnotation *pointAnnotation = nil;
    NSArray* pointArr = [_mapView annotations];
    for (id point in pointArr) {
        if ([point isKindOfClass:[MAPointAnnotation class]]) {
            pointAnnotation = point;
            break;
        }
    }
    if (!pointAnnotation) {
        pointAnnotation = [[_mapView annotations] firstObject];
    }
    return pointAnnotation;
}

- (IBAction)locate:(id)sender {
    
    MAPointAnnotation *pointAnnotation = [self findPoint];
    NSLog(@"pin latitude : %f,longitude: %f",pointAnnotation.coordinate.latitude, pointAnnotation.coordinate.longitude);
    [pointAnnotation setCoordinate:CLLocationCoordinate2DMake(self.latitude, self.longitude)];
}
- (IBAction)submit:(id)sender {
    HUD_SHOW;
    MAPointAnnotation *pointAnnotation = [self findPoint];
    [self searchLatitude:pointAnnotation.coordinate.latitude longitude:pointAnnotation.coordinate.longitude];
}
@end
