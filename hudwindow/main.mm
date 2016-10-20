#import <AppKit/AppKit.h>
#include <QtGui>
#include <qtcontent.h>

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);

    // Create and configure the native window
    NSRect frame = NSMakeRect(40, 40, 320, 200);
    NSWindow *window =
        [[NSPanel alloc] initWithContentRect:frame
                                   styleMask:NSTitledWindowMask | NSClosableWindowMask |
                                             NSMiniaturizableWindowMask | NSResizableWindowMask |
                                             NSHUDWindowMask | NSUtilityWindowMask
                                     backing:NSBackingStoreBuffered
                                       defer:NO];
    window.title = @"HUD Window";

    // Set Qt content for the native window
    QWindow *checkeredWindow = new HUDCheckeredWindow();
    window.contentView = checkeredWindow->toNSView();

    // Show the native window
    [window makeKeyAndOrderFront:nil];
    
    // Run application; clean up on exit
    int ret = app.exec();
    [window release];
    return ret;
}

