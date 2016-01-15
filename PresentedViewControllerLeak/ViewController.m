//
//  ViewController.m
//  PresentedViewControllerLeak
//
//  Created by andy on 16/06/2015.
//  Copyright (c) 2015 Bitwink. All rights reserved.
//

#import "ViewController.h"

@implementation ViewControllerA

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"<%@ %p> %@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd));
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)dealloc
{
    NSLog(@"<%@ %p> %@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 120, 44)];
    [button setTitle:@"Present B" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(presentB) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)presentB
{
    UIViewController *b = [[ViewControllerB alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:b animated:YES completion:^{}];
}

@end


@implementation ViewControllerB

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"<%@ %p> %@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd));
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)dealloc
{
    NSLog(@"<%@ %p> %@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 300, 44)];
    [button setTitle:@"Set Root to C (or press home button)" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setRootToC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)setRootToC
{
    UIViewController *c = [[ViewControllerC alloc] initWithNibName:nil bundle:nil];
    [self.view.window setRootViewController:c];

    NSLog(@"A and B instances have now leaked!");
}

@end


@implementation ViewControllerC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"<%@ %p> %@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd));
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)dealloc
{
    NSLog(@"<%@ %p> %@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

@end
