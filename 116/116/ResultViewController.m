//
//  ResultViewController.m
//  116
//
//  Created by baidu on 14/12/23.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import "ResultViewController.h"
#import "DataCenter116.h"
#import <CoreText/CoreText.h>
#import "ResultView.h"
#import "RenderScene.h"
@interface ResultViewController ()
@property (weak, nonatomic) IBOutlet UIButton *tryAgainButton;
@property (weak, nonatomic) IBOutlet UITextView  *ResultLabel;
@property (strong, nonatomic) EAGLContext * context;
@property (strong, nonatomic) RenderScene* renderScene;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tryAgainButton removeFromSuperview];
    [_ResultLabel removeFromSuperview];
    // Do any additional setup after loading the view.
    Project116 * curproj = [[DataCenter116 GetInstance]GetCurrentProject];
    int itemcount = curproj.items.count;
    int value = arc4random() % itemcount;
    _ResultLabel.text = [[DataCenter116 GetInstance]GetItemNameAt:value atProject:curproj];
    _ResultLabel.textColor = [UIColor blackColor];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    //    self.preferredFramesPerSecond = 60;
    
    //avoid UIKit freeze
    //http://stackoverflow.com/questions/10080932/glkviewcontrollerdelegate-getting-blocked
    view.enableSetNeedsDisplay = NO;
    
    //view.contentScaleFactor = [UIScreen mainScreen].scale;
    self.preferredFramesPerSecond = 0;
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    displayLink.frameInterval = 5;


    _renderScene = [[RenderScene alloc]initWithContext:self.context];
}

- (void)render:(CADisplayLink*)displayLink {
    //NSLog(@"render");
    GLKView* view = (GLKView*)self.view;
    //avoid UIKit freeze
    [self update];
    //NSLog(@"render1");
    [view display];
    
}

- (void)update
{
    [_renderScene render];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
