//
//  SectionIndexView.h
//  TBBSelectionIndexViewDemo
//
//  Created by tbb_mbp13 on 2019/9/16.
//  Copyright © 2019 tbb_mbp13. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    left,
    right,
} SectionIndexViewItemPreviewDirection;
NS_ASSUME_NONNULL_BEGIN
@class SectionIndexView;
@class SectionIndexViewItem;

@protocol SectionIndexViewDataSource <NSObject>
- (NSInteger)numberOfItemViews:(SectionIndexView *)sectionIndexView;
- (SectionIndexViewItem *)sectionIndexView:(SectionIndexView *)sectionIndexView itemSection:(NSInteger)section;
@end

@protocol SectionIndexViewDelegate <NSObject>
@optional
- (void)sectionIndexView:(SectionIndexView *)sectionIndexView didSelectRowAtSection:( NSInteger)section;
- (void)sectionIndexView:(SectionIndexView *)sectionIndexView toucheMovedAtSection:( NSInteger)section;
- (void)sectionIndexView:(SectionIndexView *)sectionIndexView toucheCancelledAtSection:( NSInteger)section;
@end

@interface SectionIndexView : UIView
@property (nonatomic, weak) id<SectionIndexViewDelegate> delegate;
@property (nonatomic, weak) id<SectionIndexViewDataSource> dataSource;
@property (nonatomic, assign) BOOL isShowItemPreview;
@property (nonatomic, assign) BOOL isItemPreviewAlwaysInCenter;
@property (nonatomic, assign) SectionIndexViewItemPreviewDirection itemPreviewDirection;
@property (nonatomic, assign) CGFloat itemPreviewMargin;
@property (nonatomic, strong) SectionIndexViewItem *currentItem;
- (SectionIndexViewItem *)itemAtSection:(NSInteger)section;
-(void)selectItemAtSection:(NSInteger)section;
@end

NS_ASSUME_NONNULL_END
