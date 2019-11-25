//
//  ViewController.m
//  TBBSelectionIndexViewDemo
//
//  Created by tbb_mbp13 on 2019/9/16.
//  Copyright © 2019 tbb_mbp13. All rights reserved.
//

#import "ViewController.h"
#import "SectionIndexView.h"
#import "SectionIndexViewItem.h"

static NSString *const reuseIdentifier = @"reuseIdentifier";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,SectionIndexViewDelegate,SectionIndexViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SectionIndexView *indexView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *indexArr;
@property (nonatomic, assign) BOOL disableScrollSelect;
@end

@implementation ViewController
-(NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.disableScrollSelect = NO;
    NSArray *data = @[@"test",@"tbb",@"hahaha"];
    self.dataArray = [[NSMutableArray alloc] initWithArray:data];
    NSArray *indexArr = @[@"#",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",
                          @"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",
                          @"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    self.indexArr = [[NSMutableArray alloc] initWithArray:indexArr];
    CGFloat y = self.view.bounds.size.height == 812 ? 88 : 64;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height-y) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.indexView = [[SectionIndexView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30, 200, 30, [UIScreen mainScreen].bounds.size.height-400)];
    self.indexView.delegate = self;
    self.indexView.dataSource = self;
    [self.view addSubview:self.indexView];
    NSInteger section = [self.tableView indexPathsForVisibleRows].firstObject.section;
    [self.indexView selectItemAtSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.indexArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 40, 35)];
    titleLabel.text = self.indexArr[section];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor orangeColor];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:titleLabel];
    return bgView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.disableScrollSelect == YES) {
        return;
    }
    NSInteger section = [self.tableView indexPathsForVisibleRows].firstObject.section;
    if (self.indexView.currentItem != [self.indexView itemAtSection:section]) {
        [self.indexView selectItemAtSection:section];
    }
}

#pragma mark SectionIndexViewDelegate
- (NSInteger)numberOfItemViews:(SectionIndexView *)sectionIndexView {
    return self.indexArr.count;
}

-(SectionIndexViewItem *)sectionIndexView:(SectionIndexView *)sectionIndexView itemSection:(NSInteger)section {
    SectionIndexViewItem *item = [[SectionIndexViewItem alloc] init];
    item.title = self.indexArr[section];
    return item;
}

- (void)sectionIndexView:(SectionIndexView *)sectionIndexView toucheMovedAtSection:(NSInteger)section {
    [sectionIndexView selectItemAtSection:section];
    self.disableScrollSelect = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    self.disableScrollSelect = NO;
}

-(void)sectionIndexView:(SectionIndexView *)sectionIndexView didSelectRowAtSection:(NSInteger)section {
    [sectionIndexView selectItemAtSection:section];
    self.disableScrollSelect = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    self.disableScrollSelect = NO;
}

@end
