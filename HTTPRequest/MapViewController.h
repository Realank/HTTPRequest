//
//  MapViewController.h
//  HTTPRequest
//
//  Created by Realank on 16/1/6.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapSearchCompleteDelegate <NSObject>

- (void)mapSearchCompleteWithLatitude:(NSString*)latitude longitude:(NSString*)longitude location:(NSString*)location andLocationDetail:(NSString*)locationDetail;

@end

@interface MapViewController : UIViewController

@property (nonatomic, weak) id<MapSearchCompleteDelegate> completeDelegate;

@end
