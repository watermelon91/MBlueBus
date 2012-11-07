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
#import "ArrivalInfo.h"

@interface XMLRouteParser : NSObject <NSXMLParserDelegate>{
    @private
    ArrivalInfo * currentArrivalBusInfo;
    StopInfo * currentStop;
    RouteInfo * route;
    NSMutableString * currentElementValue;
    bool routeInProcess;
    bool stopInProcess; /* routeInProcess : stopInProcess
                         * YES/NO -- RouteInfo
                         * NO/YES -- StopInfo
                         * NO/NO  -- ArrivalBusInfo
                         */
    bool arriveInfoParseInProcess;

    @public
    NSMutableArray * routes;
    NSInteger routeCount;
}

@property (nonatomic, strong) ArrivalInfo * currentArrivalBusInfo;
@property (nonatomic, strong) StopInfo * currentStop;
@property (nonatomic, strong) RouteInfo * route;
@property (nonatomic, strong) NSMutableString * currentElementValue;
@property (nonatomic) bool routeInProcess;
@property (nonatomic) bool stopInProcess;
@property (nonatomic) bool arriveInfoParseInProcess;
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
