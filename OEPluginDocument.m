/*
 Copyright (c) 2009, OpenEmu Team
 All rights reserved.
 
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

#import "OEPluginDocument.h"
#import "OEPlugin.h"

@implementation OEPluginDocument

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    return nil;
}

- (BOOL)readFromURL:(NSURL *)absoluteURL ofType:(NSString *)typeName error:(NSError **)outError
{
    BOOL worked = YES;
    NSString *path = [absoluteURL path];
    Class type = [OEPlugin typeForExtension:[path pathExtension]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSAllDomainsMask, YES);
    if([paths count] > 0)
    {
        NSString *newPath = [[[[paths objectAtIndex:0] stringByAppendingPathComponent:@"OpenEmu"] stringByAppendingPathComponent:[type pluginFolder]] stringByAppendingPathComponent:[path lastPathComponent]];
        NSFileManager *manager = [NSFileManager defaultManager];
        BOOL dir = NO;
        if([manager fileExistsAtPath:newPath isDirectory:&dir])
            worked = [manager removeItemAtPath:newPath error:outError];
        if(worked) worked = [manager moveItemAtPath:path toPath:newPath error:outError];
        
        if(worked)
        {
            worked = [OEPlugin pluginWithBundleAtPath:newPath type:type forceReload:YES] != nil;
            
            if(!worked)
                *outError = [NSError errorWithDomain:NSCocoaErrorDomain code:NSExecutableLoadError
                                            userInfo:
                             [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"Couldn't load %@ plugin", path], NSLocalizedDescriptionKey,
                              @"A version of this plugin is already loaded", NSLocalizedFailureReasonErrorKey,
                              @"You need to restart the application to commit the change", NSLocalizedRecoverySuggestionErrorKey,
                              nil]];
        }
    }
    return worked;
}

@end