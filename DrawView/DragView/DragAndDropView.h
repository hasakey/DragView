//
//  DragAndDropView.h
//  DragView
//
//  Created by well on 2017/4/13.
//  Copyright © 2017年 well. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragAndDropView : UIView
@property(nonatomic,strong)NSMutableArray *oldFunctionViewArr;
-(void)setLabelTitle:(NSString *)title;
@end
