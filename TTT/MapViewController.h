//
//  MapViewController.h
//  TTT
//
//  Created by Ibokan on 14-4-23.
//  Copyright (c) 2014年 孟延军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView * mapV;
    CLLocationManager * man;
}
@property(strong,nonatomic)NSArray * darr;

@property(assign,nonatomic)CLLocationCoordinate2D coor;

@end
