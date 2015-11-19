//
//  CardsViewController.m
//  Tinder
//
//  Created by Florent Bonomo on 11/19/15.
//  Copyright © 2015 flochtililoch. All rights reserved.
//

#import "CardsViewController.h"

@interface CardsViewController ()

@property (nonatomic, assign) CGPoint imageOriginalCenter;

@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onImagePan:(UIPanGestureRecognizer *)sender {
    
    UIImageView *imageView = (UIImageView *)sender.view;

    if (sender.state == UIGestureRecognizerStateBegan) {

        CGPoint faceCenter = imageView.center;
        imageView.center = CGPointMake(faceCenter.x, faceCenter.y + self.view.frame.origin.y);
        
        self.imageOriginalCenter = imageView.center;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [sender translationInView:self.view];
        
        imageView.center = CGPointMake(self.imageOriginalCenter.x + translation.x,
                                       self.imageOriginalCenter.y);
    }
}
@end
