//
//  DragAndDropView.m
//  DragView
//
//  Created by well on 2017/4/13.
//  Copyright © 2017年 well. All rights reserved.
//

#define FunctionButtonWidth 200 * [[UIScreen mainScreen] bounds].size.width/750.0f
#define FunctionButtonHeight 70 * [[UIScreen mainScreen] bounds].size.width/750.0f
#define FunctionButtonStartPointX 30 * [[UIScreen mainScreen] bounds].size.width/750.0f
#define FunctionButtonStartPointY 60
#define FunctionButtonDistanceX 45 * [[UIScreen mainScreen] bounds].size.width/750.0f
#define FunctionButtonDistanceY 50 * [[UIScreen mainScreen] bounds].size.width/750.0f
#define NumberOfRow 3

#import "DragAndDropView.h"

@interface DragAndDropView()
@property(nonatomic,strong)UILabel *functionLabel;
@property(nonatomic,assign)CGPoint selfPoint;
@property(nonatomic,assign)CGPoint superPoint;

@end

@implementation DragAndDropView

-(UILabel *)functionLabel
{
    if (!_functionLabel) {
        _functionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _functionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _functionLabel;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.functionLabel];
        
    }
    return self;
}
-(void)setLabelTitle:(NSString *)title
{
    self.functionLabel.text = title;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Began");
    UITouch *touch = [touches anyObject];
    self.selfPoint = [touch locationInView:self];
    self.superPoint = [touch locationInView:self.superview];
//    NSLog(@"%@,%@",NSStringFromCGPoint(self.selfPoint),NSStringFromCGPoint(self.superPoint));
    [self.superview exchangeSubviewAtIndex:[self.superview.subviews indexOfObject:self] withSubviewAtIndex:[[self.superview subviews] count] - 1];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"Moved");
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    [self setFrame:CGRectMake(point.x - self.selfPoint.x, point.y - self.selfPoint.y, self.frame.size.width, self.frame.size.height)];
    CGFloat newX = point.x - self.selfPoint.x + FunctionButtonWidth * 0.5;
    CGFloat newY = point.y - self.selfPoint.y + FunctionButtonHeight * 0.5;
    if ([self pointIn:point]) {
        int index = ((int)newX - (int)(FunctionButtonStartPointX))/((int)(FunctionButtonWidth) + (int)(FunctionButtonDistanceX)) + ((int)(NumberOfRow) * (((int)newY - (int)(FunctionButtonStartPointY))/((int)(FunctionButtonHeight) + (int)(FunctionButtonDistanceY))));
        [self.oldFunctionViewArr removeObject:self];
        if (index > self.oldFunctionViewArr.count) {
            [self.oldFunctionViewArr addObject:self];
        }else
        {
            [self.oldFunctionViewArr insertObject:self atIndex:index];
        }
        [self showAnimation];
        
    }
    
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self showAnimation];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self animationShow];
}

/**
 判断这个label是不是在视图内

 @param point 需要传入label点的point
 @return yes表示在，no表示不在
 */
-(BOOL)pointIn:(CGPoint)point
{
    CGFloat newX = point.x - self.selfPoint.x + FunctionButtonWidth * 0.5;
    CGFloat newY = point.y - self.selfPoint.y + FunctionButtonHeight * 0.5;
    if (
        newX > FunctionButtonStartPointX &&
        newX < FunctionButtonStartPointX + NumberOfRow * FunctionButtonWidth + (NumberOfRow - 1) * FunctionButtonDistanceX &&
        newY > FunctionButtonStartPointY
        ) {
            return YES;
    }
    return NO;
}

/**
 重置画面
 */
-(void)showAnimation
{
    for (int i = 0; i<self.oldFunctionViewArr.count; i++) {
        if ([self.oldFunctionViewArr objectAtIndex:i] != self) {
            [UIView setAnimationsEnabled:true];
            [UIView animateWithDuration:0.3 animations:^{
                [[self.oldFunctionViewArr objectAtIndex:i] setFrame:CGRectMake(FunctionButtonStartPointX + (i%NumberOfRow) * (FunctionButtonWidth + FunctionButtonDistanceX), FunctionButtonStartPointY + (i/NumberOfRow) * (FunctionButtonHeight + FunctionButtonDistanceY), FunctionButtonWidth, FunctionButtonHeight)];
            }];
        }
    }
}
/**
 重置画面
 */
-(void)animationShow
{
    for (int i = 0; i<self.oldFunctionViewArr.count; i++) {
        [UIView setAnimationsEnabled:true];
        [UIView animateWithDuration:0.3 animations:^{
            [[self.oldFunctionViewArr objectAtIndex:i] setFrame:CGRectMake(FunctionButtonStartPointX + (i%NumberOfRow) * (FunctionButtonWidth + FunctionButtonDistanceX), FunctionButtonStartPointY + (i/NumberOfRow) * (FunctionButtonHeight + FunctionButtonDistanceY), FunctionButtonWidth, FunctionButtonHeight)];
        }];
    }
    
}

@end
