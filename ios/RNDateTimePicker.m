/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNDateTimePicker.h"

#import <React/RCTUtils.h>
#import <React/UIView+React.h>

@interface RNDateTimePicker ()

@property (nonatomic, copy) RCTBubblingEventBlock onChange;
@property (nonatomic, assign) NSInteger reactMinuteInterval;

@end

@implementation RNDateTimePicker

- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
    [self addTarget:self action:@selector(didChange)
               forControlEvents:UIControlEventValueChanged];
    _reactMinuteInterval = 1;
  }
  return self;
}

CT_NOT_IMPLEMENTED(- (instancetype)initWithCoder:(NSCoder *)aDecoder)

- (void)willMoveToSuperview:(UIView *)newSuperview
{
  [super willMoveToSuperview:newSuperview];
  if ([self datePickerMode] == UIDatePickerModeCountDownTimer) {
    [self resetDate];
  }
}

- (void)didChange
{
  if (_onChange) {
    _onChange(@{ @"timestamp": @(self.date.timeIntervalSince1970 * 1000.0) });
  }

  if ([self datePickerMode] == UIDatePickerModeCountDownTimer) {
    [self resetDate];
  }
}

- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode
@@ -58,4 +70,11 @@ - (void)setDate:(NSDate *)date {
    }
}

- (void)resetDate
{
  NSDate *dateCopy = [[NSDate alloc] initWithTimeInterval:0 sinceDate:self.date];
  [self setDate:[NSDate dateWithTimeIntervalSince1970:0]];
  [self setDate:dateCopy animated:YES];
}

@end
