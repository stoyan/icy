//
//  CellData.m
//

#import "CellData.h"

@implementation CellData

@synthesize text, description, image;

+(CellData *) initWithText:(NSString *)text {
    CellData *cell = [[self alloc] init];
    cell.text = text;
    return cell;
}

+(CellData *) initWithText:(NSString *)text description:(NSString *)description {
    CellData *cell = [[self alloc] init];
    cell.text = text;
    cell.description = description;
    return cell;
}

+(CellData *) initWithImage:(UIImage *)image {
    CellData *cell = [[self alloc] init];
    cell.image = image;
    return cell;
}

@end
