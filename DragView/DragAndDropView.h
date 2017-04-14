//
//  DragAndDropView.h
//  DragView
//
//  Created by 同筑科技 on 2017/4/13.
//  Copyright © 2017年 同筑科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragAndDropView : UIView
@property(nonatomic,strong)NSMutableArray *oldFunctionViewArr;
-(void)setLabelTitle:(NSString *)title;
@end
