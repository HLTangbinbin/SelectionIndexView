//
//  SectionIndexViewItem.h
//  TBBSelectionIndexViewDemo
//
//  Created by tbb_mbp13 on 2019/9/16.
//  Copyright © 2019 tbb_mbp13. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SectionIndexViewItem : UIView
@property (nonatomic, assign) BOOL isSeleted;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, copy)  NSString *title;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) CGFloat selectedMargin;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *selectedView;
- (void)select;
- (void)deselect;
@end

NS_ASSUME_NONNULL_END
