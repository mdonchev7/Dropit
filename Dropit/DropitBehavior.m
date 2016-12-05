//
//  DropitBehavior.m
//  Dropit
//
//  Created by Mincho Dzhagalov on 4/13/16.
//  Copyright © 2016 Mincho Dzhagalov. All rights reserved.
//

#import "DropitBehavior.h"

@interface DropitBehavior()

@property (nonatomic) UIGravityBehavior *gravityBehavior;
@property (nonatomic) UICollisionBehavior *collisionBehavior;
@property (nonatomic) UIDynamicItemBehavior *itemBehavior;

@end

@implementation DropitBehavior

- (instancetype)init {
    self = [super init];
    
    [self addChildBehavior:self.gravityBehavior];
    [self addChildBehavior:self.collisionBehavior];
    [self addChildBehavior:self.itemBehavior];
    
    return self;
}

- (UIGravityBehavior *)gravityBehavior {
    if (!_gravityBehavior) {
        _gravityBehavior = [[UIGravityBehavior alloc] init];
    }
    
    return _gravityBehavior;
}

- (UICollisionBehavior *)collisionBehavior {
    if (!_collisionBehavior) {
        _collisionBehavior = [[UICollisionBehavior alloc] init];
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    }
    
    return _collisionBehavior;
}

- (UIDynamicItemBehavior *)itemBehavior {
    if (!_itemBehavior) {
        _itemBehavior = [[UIDynamicItemBehavior alloc] init];
        _itemBehavior.allowsRotation = NO;
    }
    
    return _itemBehavior;
}

- (void)addItem:(id <UIDynamicItem>)item {
    [self.collisionBehavior addItem:item];
    [self.gravityBehavior addItem:item];
    [self.itemBehavior addItem:item];
}

- (void)removeItem:(id <UIDynamicItem>)item {
    [self.collisionBehavior removeItem:item];
    [self.gravityBehavior removeItem:item];
    [self.itemBehavior removeItem:item];
}

@end
