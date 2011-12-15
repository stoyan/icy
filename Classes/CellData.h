//
//  CellData.h
//

#import <Foundation/Foundation.h>

@interface CellData : NSObject{}

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) UIImage *image;

+(CellData *) initWithText:(NSString *)text;
+(CellData *) initWithText:(NSString *)text description:(NSString *)description;
+(CellData *) initWithImage:(UIImage *)image;

@end
