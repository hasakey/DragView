//
//  ViewController.m
//  DragView
//
//  Created by 同筑科技 on 2017/4/13.
//  Copyright © 2017年 同筑科技. All rights reserved.
//

//功能按钮定义
#define FunctionButtonWidth 200 * [[UIScreen mainScreen] bounds].size.width/750.0f
#define FunctionButtonHeight 70 * [[UIScreen mainScreen] bounds].size.width/750.0f
#define FunctionButtonStartPointX 30 * [[UIScreen mainScreen] bounds].size.width/750.0f
#define FunctionButtonStartPointY 60
#define FunctionButtonDistanceX 45 * [[UIScreen mainScreen] bounds].size.width/750.0f
#define FunctionButtonDistanceY 50 * [[UIScreen mainScreen] bounds].size.width/750.0f
#define NumberOfRow 3

#import "ViewController.h"
#import "DragAndDropView.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titleArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    NSMutableArray *viewaArray = [NSMutableArray array];
    for (int i = 0; i<titleArray.count; i++) {
        DragAndDropView *dragAndDropView = [[DragAndDropView alloc] initWithFrame:CGRectMake(FunctionButtonStartPointX + (FunctionButtonWidth + FunctionButtonDistanceX) * (i%NumberOfRow), FunctionButtonStartPointY + (FunctionButtonHeight + FunctionButtonDistanceY) * (i/NumberOfRow), FunctionButtonWidth, FunctionButtonHeight)];
        [dragAndDropView setLabelTitle:titleArray[i]];
        [viewaArray addObject:dragAndDropView];
        dragAndDropView.oldFunctionViewArr = viewaArray;
        [self.view addSubview:dragAndDropView];
    }
}





@end
