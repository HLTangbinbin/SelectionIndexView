//
//  SectionIndexView.m
//  TBBSelectionIndexViewDemo
//
//  Created by tbb_mbp13 on 2019/9/16.
//  Copyright © 2019 tbb_mbp13. All rights reserved.
//

#import "SectionIndexView.h"
#import "SectionIndexViewItem.h"


@interface SectionIndexView()
@property (nonatomic, strong) NSMutableArray<SectionIndexViewItem *> *items;
@property (nonatomic, strong) SectionIndexViewItem *touchItem;
@end

@implementation SectionIndexView

-(NSMutableArray<SectionIndexViewItem *> *)items {
    if (_items == nil) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}
-(SectionIndexViewItem *)currentItem {
    return _currentItem;
}
-(void)setDataSource:(id<SectionIndexViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self creatViews];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)creatViews {
    if (self.delegate && [self.dataSource respondsToSelector:@selector(numberOfItemViews:)]) {
        NSInteger num = [self.dataSource numberOfItemViews:self];
        CGFloat height = self.bounds.size.height/(CGFloat)num;
        for (int i=0; i<num; i++) {
            SectionIndexViewItem *itemView = [self.dataSource sectionIndexView:self itemSection:i];
            [self.items addObject:itemView];
            itemView.frame = CGRectMake(0, height*i, self.bounds.size.width, height);
            [self addSubview:itemView];
        }
    }
}

- (void)reloadData {
    for (SectionIndexViewItem *itemView in self.items) {
        [itemView removeFromSuperview];
    }
    [self.items removeAllObjects];
    [self creatViews];
}

- (SectionIndexViewItem *)itemAtSection:(NSInteger)section {
    if (section >= self.items.count) {
        return nil;
    }
    return self.items[section];
}

-(void)selectItemAtSection:(NSInteger)section {
    if (section >= self.items.count || section < 0) {
        return;
    }
    [self deSelectItem];
    self.currentItem = self.items[section];
    [self.items[section] select];
}

-(void)deSelectItem {
    [self.currentItem deselect];
    
}

-(NSInteger)getSectionByTouches:(NSSet<UITouch *> *)touches {
    UITouch *touch = [touches anyObject];
    if (touch) {
        CGPoint point = [touch locationInView:self];
        for (int i=0; i<self.items.count; i++) {
            SectionIndexViewItem *item = self.items[i];
            if (CGRectContainsPoint(item.frame, point)) {
                return i;
            }
        }
    }
    return self.items.count-1;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self];
        for (int i=0; i<self.items.count; i++) {
            SectionIndexViewItem *item = self.items[i];
            if (self.touchItem != item && point.y <= (item.frame.origin.y+item.frame.size.height) && point.y >= item.frame.origin.y) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(sectionIndexView:toucheMovedAtSection:)]) {
                    [self.delegate sectionIndexView:self toucheMovedAtSection:i];
                }else {
                    [self selectItemAtSection:i];
                }
                self.touchItem = item;
                return;
            }
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSInteger section = [self getSectionByTouches:touches];
    if (section) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sectionIndexView:didSelectRowAtSection:)]) {
            [self.delegate sectionIndexView:self didSelectRowAtSection:section];
        }else {
            [self selectItemAtSection:section];
        }
        return;
    }
    for (int i=0; i<self.items.count; i++) {
        if (self.items[i] == self.currentItem) {
            [self.delegate sectionIndexView:self didSelectRowAtSection:section];
        }
    }
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSInteger section = [self getSectionByTouches:touches];
    if (section) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sectionIndexView:toucheCancelledAtSection:)]) {
            
        }else {
            
        }
    }
}
@end
