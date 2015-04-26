
//
//  customCell.m
//  xmlParsing
//
//  Created by Griffin on 26/04/15.
//  Copyright (c) 2015 Griffin. All rights reserved.
//

#import "customCell.h"

@implementation customCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    self.contentView.frame = self.bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView updateConstraintsIfNeeded];
    [self.contentView layoutIfNeeded];
    
    self.titleLbl.preferredMaxLayoutWidth = CGRectGetWidth(self.titleLbl.frame);
}

@end
