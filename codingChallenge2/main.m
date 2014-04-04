//
//  main.m
//  codingChallenge2
//
//  Created by rl on 4/3/14.
//  Copyright (c) 2014 Rene Limberger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLCodingChallengeModel.h"

void usage()
{
    // print expected input argument pattern
    printf("usage: compute c N filename\n");
    printf("example: compute 4 300 ./test.prn\n");
}

int main(int argc, const char* argv[])
{
    @autoreleasepool {
        
        if(argc != 4) {
            usage();
            return -1;
        }
        
        // get args
        NSInteger c = atoi(argv[1]);
        NSInteger N = atoi(argv[2]);
        NSString* filename = [NSString stringWithFormat:@"%s", argv[3]];
        
        // parse file and build array
        NSString* fileContent = [NSString stringWithContentsOfFile:filename encoding:NSASCIIStringEncoding error:nil];
        NSArray* lines = [fileContent componentsSeparatedByString:@"\n"];
        NSMutableArray* floats = [NSMutableArray arrayWithCapacity:lines.count];
        for(NSString* line in lines)
            [floats addObject:@(line.floatValue)];
        
        // check data
        if(!floats || !floats.count) {
            printf("\nUnable to read data from file %s\n\n", filename.UTF8String);
            return -1;
        }
        
        // check inputs
        if(N < 1) {
            printf("\nN must be greater than 0. Given N=%ld\n\n", (long)N);
            return -1;
        }
        
        if(c < 1) {
            printf("\nC must be greater than 0. Given C=%ld\n\n", (long)c);
            return -1;
        }
        
        if(N > floats.count) {
            printf("\nN cannot be larger than the number of floats in input file. Given N=%ld and file has %lu floats.\n\n", (long)N, (unsigned long)floats.count);
            return -1;
        }
        
        // instanciate compute model
        RLCodingChallengeModel* model = [[RLCodingChallengeModel alloc] initWithData:floats];
        
        // print
        if(!model) {
            printf("\nUnable to interpret data from file %s\n\n", filename.UTF8String);
            return -1;
        }
        
        // compute
        NSString* result = [model computeMatrixWithOfSize:c withIterations:N];
        
        if(!result || !result.length) {
            printf("\nUnable to compute matrix.\n\n");
            return -1;
        }
        
        // sucessfully computed matrix, print to stdout
        printf("\nInput parameters: c=%ld N=%ld file=%s\n", (long)c, (long)N, filename.UTF8String);
        printf("Output:\n\n");
        printf("%s\n", result.UTF8String);
    }
    
    return 0;
}

