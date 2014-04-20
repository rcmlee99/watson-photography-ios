//
//  WatsonPhotographyTests.m
//  WatsonPhotographyTests
//
//  Created by Carlos Andreu on 4/19/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WPUtils.h"

@interface WatsonPhotographyTests : XCTestCase

@end

@implementation WatsonPhotographyTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBase64AuthGeneration
{
    NSString* header = [WPUtils getBase64AuthHeaderWithUsername:@"carlos" andPassword:@"123"];
    
    XCTAssertEqualObjects(header, @"Basic Y2FybG9zOjEyMw==", @"base64 header comparison");
}

- (void)testRandomNumberGenerator
{
    int MAX = 3;
    int MIN = 0;
    
    int rand1 = [WPUtils randomNumberWithMax:MAX andMin:MIN];
    
    XCTAssertTrue(rand1 >= MIN && rand1 <= MAX, @"check random number in range");
}

@end
