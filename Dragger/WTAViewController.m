//
//  WTAViewController.m
//  Dragger
//
//  Created by Matt Yohe on 4/1/13.
//  Copyright (c) 2013 Matt Yohe. All rights reserved.
//

#import "WTAViewController.h"
#import "WTADragger.h"


@interface WTAViewController ()

@end

@implementation WTAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    WTADragger *drag = [[WTADragger alloc] initWithFrame:CGRectMake(30, 300, 250, 100)];
    [drag addTarget:self action:@selector(topControl:) forControlEvents:UIControlEventValueChanged];
    [[self view] addSubview:drag];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)topControl:(id)sender {
    
    NSLog(@"%@",sender);
    
}

@end
