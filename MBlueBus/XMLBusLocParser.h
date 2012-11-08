//
//  XMLBusLocParser.h
//  MBlueBus
//
//  Created by Watermelon on 11/6/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusLocationCoordinateInfo.h"

@interface XMLBusLocParser : NSObject <NSXMLParserDelegate>{
    BusLocationCoordinateInfo * currentBusLocInfo;
    NSMutableString * currentElementValue;
    
    NSMutableArray * busLocs;
}

@property (nonatomic, strong) NSMutableArray * busLocs;

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
