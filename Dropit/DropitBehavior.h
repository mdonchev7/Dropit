//
//  DropitBehavior.h
//  Dropit
//
//  Created by Mincho Dzhagalov on 4/13/16.
//  Copyright © 2016 Mincho Dzhagalov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior

- (void)addItem:(id <UIDynamicItem>)item;
- (void)removeItem:(id <UIDynamicItem>)item;

@end
