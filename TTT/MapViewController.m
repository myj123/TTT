//
//  MapViewController.m
//  TTT
//
//  Created by Ibokan on 14-4-23.
//  Copyright (c) 2014年 孟延军. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if ([CLLocationManager locationServicesEnabled]) {
        man = [[CLLocationManager alloc] init];
        man.distanceFilter = 1000;
        man.desiredAccuracy =kCLLocationAccuracyBest;
        man.delegate = self;
        [man startUpdatingLocation];
    }
    else{
        UIAlertView * alet = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设备不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alet show];
    }
    self.navigationItem.title = [self.darr objectAtIndex:0];
    CGRect rect = [[UIScreen mainScreen]bounds];
    mapV = [[MKMapView alloc]initWithFrame:CGRectMake(0, rect.origin.y, rect.size.width, rect.size.height)];
    [self.view addSubview:mapV];
    mapV.mapType = MKMapTypeStandard;
    mapV.showsUserLocation  = YES;
    float latitude = [[self.darr objectAtIndex:1]floatValue];
    float longitude = [[self.darr objectAtIndex:2]floatValue];
    self.coor = CLLocationCoordinate2DMake(latitude, longitude);
//    [mapV setRegion:MKCoordinateRegionMakeWithDistance(self.coor, 200000, 200000) animated:YES];
    mapV.region = MKCoordinateRegionMake(self.coor, MKCoordinateSpanMake(1.0, 1.0));
    MKPointAnnotation * annotation = [[MKPointAnnotation alloc] init];
    [mapV addAnnotation:annotation];
    [mapV selectAnnotation:annotation animated:YES];
    annotation.coordinate = self.coor;
    mapV.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    static NSString * identifier = @"map";
    __autoreleasing MKPinAnnotationView * view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    view.annotation = annotation;
    view.animatesDrop = YES;
    view.pinColor = MKPinAnnotationColorPurple;
    view.canShowCallout = YES;
    return view;
}

- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations{
    for (CLLocation * loc in locations) {
        MKPointAnnotation * annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = loc.coordinate;
        [mapV addAnnotation:annotation];
    }
    CLLocation * loc = [locations lastObject];
    mapV.region = MKCoordinateRegionMake(loc.coordinate, MKCoordinateSpanMake(0.03, 0.03));
    [manager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}

@end
