//
//  BackgroundLocationUITests.m
//  BackgroundLocationUITests
//
//  Created by hanxiaoming on 16/12/12.
//  Copyright © 2016年 AutoNavi. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BackgroundLocationUITests : XCTestCase

@end

@implementation BackgroundLocationUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCUIElementQuery *toolbarsQuery = [[XCUIApplication alloc] init].toolbars;
    XCUIElement *button = toolbarsQuery.buttons[@"\u505c\u6b62\u540e\u53f0\u5b9a\u4f4d"];
    [button tap];
    
    XCUIElement *button2 = toolbarsQuery.buttons[@"\u5f00\u59cb\u540e\u53f0\u5b9a\u4f4d"];
    [button2 tap];
    [button tap];
    [button2 tap];
    
}

@end
