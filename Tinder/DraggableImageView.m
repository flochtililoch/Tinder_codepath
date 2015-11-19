//
//  DraggableImageView.m
//  Tinder
//
//  Created by Matias Arenas Sepulveda on 11/19/15.
//  Copyright © 2015 flochtililoch. All rights reserved.
//

#import "DraggableImageView.h"

@interface DraggableImageView()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, assign) CGPoint imageOriginalCenter;
@property (nonatomic, assign) CGPoint imageOriginalAngle;

@end

@implementation DraggableImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSubview];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubview];
    }
    return self;
}

- (void) initSubview {
    UINib *nib = [UINib nibWithNibName:@"DraggableImageView" bundle:nil];
    [nib instantiateWithOwner:self options:nil];
    self.contentView.frame = [self bounds];
    [self addSubview:self.contentView];
}

- (void)setProfileImageView:(UIImageView *)profileImageView {
    _profileImageView = profileImageView;
}

- (IBAction)onImagePan:(UIPanGestureRecognizer *)sender {
    UIView *imageView = (UIView *)sender.view;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        CGPoint faceCenter = imageView.center;
        imageView.center = CGPointMake(faceCenter.x, faceCenter.y + self.contentView.frame.origin.y);
        
        self.imageOriginalCenter = imageView.center;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [sender translationInView:self.contentView];
        
        CGFloat width = self.profileImageView.frame.size.width / 2;
        
        CGFloat angle = translation.x / width * 45;
        imageView.center = CGPointMake(self.imageOriginalCenter.x + translation.x, self.imageOriginalCenter.y);
        
        imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angle * M_PI / 180.0);
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint translation = [sender translationInView:self.contentView];
        if (translation.x > 80) {
            
        } else {
            imageView.center = self.imageOriginalCenter;
            imageView.transform = CGAffineTransformIdentity;
        }
    }

}


@end
