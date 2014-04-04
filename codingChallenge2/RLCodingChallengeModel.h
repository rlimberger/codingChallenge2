//
//  RLCodingChallengeModel.h
//  codingChallenge2
//
//  Created by rl on 4/3/14.
//  Copyright (c) 2014 Rene Limberger. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
 `RLCodingChallengeModel` Is the model object that implements the computation
 and formatting of the coding challenge.
 */
@interface RLCodingChallengeModel : NSObject

/**
 Initializes the model with the data.
 
 @param
 inputData An `<NSArray>` of single precission floats encapsulated as `<NSNumber>`.
 */
- (id)initWithData:(NSArray*)inputData;

/**
 Computes the result of this coding challenge (a matrix).
 
 @param
 c The dimension of the matrix.
 
 @param
 The number of values to include in the computation.
 */
- (NSString*)computeMatrixWithOfSize:(NSInteger)c withIterations:(NSInteger)N;

@end
