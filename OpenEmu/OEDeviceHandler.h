/*
 Copyright (c) 2009, OpenEmu Team


 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
     * Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
     * Neither the name of the OpenEmu Team nor the
       names of its contributors may be used to endorse or promote products
       derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY OpenEmu Team ''AS IS'' AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL OpenEmu Team BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Cocoa/Cocoa.h>

#import <IOKit/hid/IOHIDLib.h>
#import <IOKit/hid/IOHIDUsageTables.h>
#import <ForceFeedback/ForceFeedback.h>

@class OEHIDEvent;

#define kOEHIDElementIsTriggerKey "OEHIDElementIsTrigger"

@class IOBluetoothDevice;
@interface OEDeviceHandler : NSObject <NSCopying>

// Returns aString if aString is a parsable identifier or a known identifier, returns nil otherwise.
+ (NSString *)standardDeviceIdentifierForDeviceIdentifier:(NSString *)aString;

@property(readonly) NSUInteger deviceNumber;

@property(readonly) NSString *deviceIdentifier;

@property(readonly) NSString *serialNumber;
@property(readonly) NSString *manufacturer;
@property(readonly) NSString *product;
@property(readonly) NSNumber *vendorID;
@property(readonly) NSNumber *productID;
@property(readonly) NSNumber *locationID;

- (BOOL)connect;
- (void)disconnect;

+ (instancetype)deviceHandlerWithIOHIDDevice:(IOHIDDeviceRef)aDevice;
+ (instancetype)deviceHandlerWithIOBluetoothDevice:(IOBluetoothDevice *)aDevice;

- (BOOL)isKeyboardDevice;

@end
