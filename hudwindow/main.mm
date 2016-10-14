#import <AppKit/AppKit.h>
#include <QtGui>
#include <qtcontent.h>

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);

    // Create and configure native window
    NSRect frame = NSMakeRect(40, 40, 320, 200);
    NSWindow *window =
        [[NSPanel alloc] initWithContentRect:frame
                                   styleMask:NSTitledWindowMask | NSClosableWindowMask |
                                             NSMiniaturizableWindowMask | NSResizableWindowMask |
                                             NSHUDWindowMask | NSUtilityWindowMask
                                     backing:NSBackingStoreBuffered
                                       defer:NO];
    window.title = @"NSHUDWindowMask";
    window.movableByWindowBackground = NO;

    // Create and configure Qt content window
    RasterWindow *rasterWindow = new RasterWindow();
    rasterWindow->setDrawAlpha(85); // Make HUD content transparent

    // Make the native window contain Qt content
    window.contentView = rasterWindow->toNSView();

    // Show native window
    [window makeKeyAndOrderFront:nil];
    [window makeFirstResponder:window.contentView];
    
    return app.exec();
}

