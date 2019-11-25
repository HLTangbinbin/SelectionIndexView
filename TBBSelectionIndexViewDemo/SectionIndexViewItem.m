//
//  SectionIndexViewItem.m
//  TBBSelectionIndexViewDemo
//
//  Created by tbb_mbp13 on 2019/9/16.
//  Copyright © 2019 tbb_mbp13. All rights reserved.
//

#import "SectionIndexViewItem.h"

@implementation SectionIndexViewItem
-(void)setImage:(UIImage *)image {
    _imageView.image = image;
}

-(void)setSelectedImage:(UIImage *)selectedImage {
    _imageView.highlightedImage = selectedImage;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

-(void)setTitleFont:(UIFont *)titleFont {
    _titleLabel.font = titleFont;
}

-(void)setTitleColor:(UIColor *)titleColor {
    _titleLabel.textColor = titleColor;
}

-(void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    _titleLabel.highlightedTextColor = titleSelectedColor;
}

-(void)setSelectedColor:(UIColor *)selectedColor {
    _selectedView.backgroundColor = selectedColor;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews {
    self.selectedView = [[UIView alloc] init];
    self.isSeleted = NO;
    self.selectedView.backgroundColor = self.selectedColor;
    self.selectedView.alpha = 0;
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self insertSubview:self.selectedView atIndex:0];
}

- (void)creatView {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.highlightedTextColor = [UIColor orangeColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.titleLabel];
    [self addSubview:self.imageView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
    self.imageView.frame = self.bounds;
}
- (void)select {
    self.isSeleted = YES;
    self.titleLabel.highlighted = YES;
    self.imageView.highlighted = YES;
    self.selectedView.alpha = 1;
}

- (void)deselect {
    self.isSeleted = NO;
    self.titleLabel.highlighted = NO;
    self.imageView.highlighted = NO;
    self.selectedView.alpha = 0;
}
@end
