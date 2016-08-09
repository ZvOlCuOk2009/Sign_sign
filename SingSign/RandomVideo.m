//
//  RandomVideo.m
//  RamsahApp
//
//  Created by Mac on 03.08.16.
//  Copyright © 2016 AcerBest. All rights reserved.
//

#import "RandomVideo.h"

@implementation RandomVideo

+ (NSString *)selectionOfRandomVideos
{
    NSArray *videos = @[@"TEST_VIDEO_1", @"TEST_VIDEO_2", @"TEST_VIDEO_3", @"TEST_VIDEO_4", @"TEST_VIDEO_5", @"TEST_VIDEO_6", @"TEST_VIDEO_7", @"TEST_VIDEO_8", @"TEST_VIDEO_9", @"TEST_VIDEO_10", @"TEST_VIDEO_11", @"TEST_VIDEO_12", @"TEST_VIDEO_13", @"TEST_VIDEO_14", @"TEST_VIDEO_15", @"TEST_VIDEO_16", @"TEST_VIDEO_17", @"TEST_VIDEO_18", @"TEST_VIDEO_19", @"TEST_VIDEO_20", ];
    NSString *video = [videos objectAtIndex:arc4random_uniform(20)];
    return video;
}
@end
