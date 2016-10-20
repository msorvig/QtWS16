#import <AppKit/AppKit.h>
#include <QtGui>
#include <qtcontent.h>

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);

    // Create and configure the native window
    NSRect frame = NSMakeRect(200, 200, 320, 200);
    NSWindow *window =
        [[NSWindow alloc] initWithContentRect:frame
                                    styleMask:NSTitledWindowMask | NSClosableWindowMask |
                                              NSMiniaturizableWindowMask | NSResizableWindowMask |
                                              NSFullSizeContentViewWindowMask
                                      backing:NSBackingStoreBuffered
                                        defer:NO];

    // Hide the title bar
    window.titlebarAppearsTransparent = YES;
    window.movableByWindowBackground = YES;

    // Set Qt content for the native window
    QWindow *checkeredWindow = new CheckeredWindow();
    window.contentView = checkeredWindow->toNSView();

    // Show the native window
    [window makeKeyAndOrderFront:nil];

    // Run application; clean up on exit
    int ret = app.exec();
    [window release];
    return ret;
}
