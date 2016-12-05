//
//  ViewController.m
//  Dropit
//
//  Created by Mincho Dzhagalov on 4/13/16.
//  Copyright © 2016 Mincho Dzhagalov. All rights reserved.
//

#import "DropitViewController.h"
#import "DropitBehavior.h"

@interface DropitViewController () <UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) DropitBehavior *dropitBehavior;

@end

@implementation DropitViewController

static const CGSize DROP_SIZE = { 40, 40 };

- (DropitBehavior *)dropitBehavior {
    if (!_dropitBehavior) {
        _dropitBehavior = [[DropitBehavior alloc] init];
        [self.animator addBehavior:_dropitBehavior];
    }
    
    return _dropitBehavior;
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
        _animator.delegate = self;
    }
    
    return _animator;
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    [self removeCompletedRows];
}

- (BOOL)removeCompletedRows {
    NSMutableArray *dropsToRemove = [[NSMutableArray alloc] init];
    
    for (CGFloat y = self.gameView.bounds.size.height - DROP_SIZE.height / 2; y > 0; y -= DROP_SIZE.height) {
        BOOL rowIsComplete = YES;
        
        NSMutableArray *dropsFound = [[NSMutableArray alloc] init];
        for (CGFloat x = DROP_SIZE.width / 2; x <= self.gameView.bounds.size.width - DROP_SIZE.width / 2; x += DROP_SIZE.width) {
            UIView *hitView = [self.gameView hitTest:CGPointMake(x, y) withEvent:nil];
            
            if ([hitView superview] == self.gameView) {
                [dropsFound addObject:hitView];
            } else {
                rowIsComplete = NO;
                break;
            }
        }
        
        if (![dropsFound count]) {
            break;
        }
        if (rowIsComplete) {
            [dropsToRemove addObjectsFromArray:dropsFound];
        }
    }
    
    if ([dropsToRemove count]) {
        for (UIView *drop in dropsToRemove) {
            [self.dropitBehavior removeItem:drop];
        }
    }
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         for (UIView *drop in dropsToRemove) {
                             int x = arc4random() % (int)(self.gameView.bounds.size.width * 5) - (self.gameView.bounds.size.width * 2);
                             int y = self.gameView.bounds.size.height;
                             drop.center = CGPointMake(x, -y);
                         }
                     }
                     completion:^(BOOL finished){
                         [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                     }];
    
    return NO;
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [self drop];
}

- (void)drop {
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = arc4random() % (int)self.gameView.frame.size.width / DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;
    
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    
    [self.gameView addSubview:dropView];
    
    [self.dropitBehavior addItem:dropView];
}

- (UIColor *)randomColor
{
    switch (arc4random() % 5) {
        case 0:
            return [UIColor orangeColor];
        case 1:
            return  [UIColor yellowColor];
        case 2:
            return [UIColor redColor];
        case 3:
            return [UIColor blueColor];
        case 4:
            return [UIColor greenColor];
        default:
            return [UIColor blackColor];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
