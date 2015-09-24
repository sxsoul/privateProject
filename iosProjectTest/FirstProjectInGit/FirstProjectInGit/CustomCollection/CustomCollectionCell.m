//
//  CustomCollectionCell.m
//  FirstProjectInGit
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CustomCollectionCell.h"

@interface CustomCollectionCell ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation CustomCollectionCell
-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:_titleLabel];
    }
    return self;
}

-(void) setData:(NSDictionary *)data {
    CGRect frame = self.frame;
    [self.imgView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self.titleLabel setFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
    [self.imgView setImage:[UIImage imageNamed:data[@"image"]]];
    [self.titleLabel setText:data[@"name"]];
}

@end
