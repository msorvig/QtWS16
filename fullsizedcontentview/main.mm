#import <AppKit/AppKit.h>
#include <QtGui>
#include <qtcontent.h>

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);

    // Create and configure native window
    NSRect frame = NSMakeRect(40, 40, 320, 200);
    NSWindow *window =
        [[NSWindow alloc] initWithContentRect:frame
                                    styleMask:NSTitledWindowMask | NSClosableWindowMask |
                                              NSMiniaturizableWindowMask | NSResizableWindowMask |
                                              NSFullSizeContentViewWindowMask
                                      backing:NSBackingStoreBuffered
                                        defer:NO];

    window.title = @"NSFullSizeContentViewWindowMask";
    window.titlebarAppearsTransparent = YES;
    window.movableByWindowBackground = YES;

    // Create and configure Qt content window
    RasterWindow *rasterWindow = new RasterWindow();
    rasterWindow->setDragEnabled(false);  // "drag" feature in sample RasterWindow conflicts
                                          // with movableByWindowBackground.

    // Make the native window contain Qt content
    window.contentView = rasterWindow->toNSView();

    // Show native window
    [window makeKeyAndOrderFront:nil];
    [window makeFirstResponder:window.contentView];

    return app.exec();
}
