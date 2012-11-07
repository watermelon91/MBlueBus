//
//  XMLParser.h
//  MBlueBus
//
//  Created by Watermelon on 10/18/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StopInfo.h"
#import "RouteInfo.h"

@interface XMLParser : NSObject <NSXMLParserDelegate>{
    @private
    RouteInfo * route;
    NSMutableString * currentElementValue;
    bool routeInProcess;

    @public
    NSMutableArray * routes;
    NSInteger routeCount;
}

@property (nonatomic) bool routeInProcess;
@property (nonatomic, strong) RouteInfo * route;
@property (nonatomic, strong) NSMutableArray * routes;
@property (nonatomic) NSInteger routeCount;

- (id)init;

- (void)parser:(NSXMLParser *)parser
        didStartElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI
        qualifiedName:(NSString *)qName
        attributes:(NSDictionary *)attributeDict;

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

- (void)parser:(NSXMLParser *)parser
        didEndElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI
        qualifiedName:(NSString *)qName;
@end
