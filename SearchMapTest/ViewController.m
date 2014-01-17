//
//  ViewController.m
//  SearchMapTest
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import "TMapView.h"
#define APP_KEY @"APP_KEY"
#define TOOLBAR_HEIGHT 70

@interface ViewController ()<UISearchBarDelegate, TMapViewDelegate>

@property (strong, nonatomic) TMapView *mapView;

@end

@implementation ViewController

// 검색 버튼 클릭시
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    // 새로 작성하기 전에 마커 지우기
    [self.mapView clearCustomObjects];
    
    NSString *keyWord = searchBar.text;
    TMapPathData *path = [[TMapPathData alloc] init];
    NSArray *result = [path requestFindTitlePOI:keyWord];
    NSLog(@"Number of POI : %d", (int)result.count);
    
    int i = 0;
    for (TMapPOIItem *item in result) {
        NSLog(@"Name : %@ - Point : %@", [item getPOIName], [item getPOIPoint]);
        
        NSString *markerID = [NSString stringWithFormat:@"marker_%d", i++];
        TMapMarkerItem *marker = [[TMapMarkerItem alloc] init];
        [marker setTMapPoint:[item getPOIPoint]];
        [marker setIcon:[UIImage imageNamed:@"icon_clustering.png"]];
        
        [marker setCanShowCallout:YES];
        [marker setCalloutTitle:[item getPOIName]];
        [marker setCalloutSubtitle:[item getPOIAddress]];
        
        [self.mapView addCustomObject:marker ID:markerID];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 툴바의 크기를 고려한 mapView
    CGRect rect = CGRectMake(0, TOOLBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - TOOLBAR_HEIGHT);
    self.mapView = [[TMapView alloc] initWithFrame:rect];
    [self.mapView setSKPMapApiKey:@"7b7b1456-6496-3c3e-ae92-3cf87fd15065"];
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
