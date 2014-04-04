//
//  RLCodingChallengeModel.m
//  codingChallenge2
//
//  Created by rl on 4/3/14.
//  Copyright (c) 2014 Rene Limberger. All rights reserved.
//

#import "RLCodingChallengeModel.h"

@interface RLCodingChallengeModel ()
{
    NSArray* data;
}

@end

@implementation RLCodingChallengeModel

#pragma mark - public interface

- (id)initWithData:(NSArray*)inputData
{
    if((self = [super init])) {
        data = inputData;
    }
    return self;
}

- (NSString*)computeMatrixWithOfSize:(NSInteger)c withIterations:(NSInteger)N
{
    NSString* result = nil;
    
    // take start time before computation starts
    NSDate* start = [NSDate date];
    
    // compute the matrix
    NSArray* matrix = [self compute:c withIterations:N];
    
    // take time delta to understand how long it took to compute this matrix
    NSTimeInterval computeTime = [[NSDate date] timeIntervalSinceDate:start];
    
    // if we got a valid matrix back, format the output
    if(matrix) {
        result = @"";
        
        for(NSArray* row in matrix) {
            result = [result stringByAppendingString:@"\t|"];
            
            for(NSNumber* col in row) {
                result = [result stringByAppendingFormat:@"%.6f", col.floatValue];
                
                if(col != row.lastObject)
                    result = [result stringByAppendingString:@" "];
            }
            
            result = [result stringByAppendingString:@"|\n"];
        }
        
        result = [result stringByAppendingFormat:@"\nCompute time: %.2fms\n", computeTime*1000.0f];
    }
    
    // return the formatted matrix as string
    return result;
}

#pragma mark - internal implementation

- (NSMutableArray*)matrixWithDimension:(NSInteger)matrixSize
{
    // init rows
    NSMutableArray* II = [NSMutableArray arrayWithCapacity:matrixSize];
    
    // init each row
    for(NSInteger row = 0; row < matrixSize; row++)
        [II addObject:[NSMutableArray arrayWithCapacity:matrixSize]];
    
    return II;
}

- (NSArray*)compute:(NSInteger)c withIterations:(NSInteger)N
{
    // check input
    if(!data || N > data.count)
        return nil;
    
    // init an emty matrix with the required dimensions
    NSInteger matrixSize = c+1;
    NSMutableArray* II = [self matrixWithDimension:matrixSize];
    
    // algorithm implimentation
    //
    // iterate over rows
    for(NSInteger k = 0; k <= c; k++) {
        NSMutableArray* row = II[k];
        
        // iterate over elements in row
        for(NSInteger j = 0; j <= c; j++) {
            float x = 0;
            
            for(NSInteger i = c; i < N; i++) {
                NSInteger ikIndex = i-k;
                NSInteger ijIndex = i-j;
                
                // double check that the access index is in bounds
                if(ikIndex >= data.count || ijIndex >= data.count)
                    return nil;
                
                NSNumber* ik = data[ikIndex];
                NSNumber* ij = data[ijIndex];
                
                x += ik.floatValue * ij.floatValue;
            }
            
            [row addObject:@(x)];
        }
    }
    
    return II;
}

@end
