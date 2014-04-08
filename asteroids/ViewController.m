//
//  ViewController.m
//  asteroids
//
//  Created by andy on 07.04.14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import "ViewController.h"
#import "EAGLView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [(EAGLView *)self.view startAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
