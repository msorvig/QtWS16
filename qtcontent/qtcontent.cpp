/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the test suite of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "qtcontent.h"

RasterWindow::RasterWindow()
:m_enableDrag(true)
,m_drawAlpha(255)
,m_pressed(false)
,m_color(0, 102, 153, m_drawAlpha)
{

}

void RasterWindow::setDragEnabled(bool enable)
{
    m_enableDrag = enable;
}

void RasterWindow::setOpaqueFormat(bool enable)
{
    // Opaque windows do not have an alpha channel and are guaranteed
    // to fill their entire content area. This guarantee is propagated
    // to Cocoa via the NSView opaque property.
    QSurfaceFormat format;
    format.setAlphaBufferSize(enable ? 0 : 8);
    setFormat(format);
}

void RasterWindow::setDrawAlpha(int alpha)
{
    m_drawAlpha = alpha;
}

void RasterWindow::setColor(QColor color)
{
    m_color = color;
    m_color.setAlpha(m_drawAlpha); // surprise! override aplha (sorry)
}

void RasterWindow::paintEvent(QPaintEvent * event)
{
    QRect r = event->rect();

    QPainter p(this);

    QColor fillColor = m_color;
    QColor fillColor2 = fillColor.darker();

    int tileSize = 40;
    for (int i = -tileSize * 2; i < r.width() + tileSize * 2; i += tileSize) {
        for (int j = -tileSize * 2; j < r.height() + tileSize * 2; j += tileSize) {
            QRect rect(i + (m_offset.x() % tileSize * 2), j + (m_offset.y() % tileSize * 2), tileSize, tileSize);
            int colorIndex = abs((i/tileSize - j/tileSize) % 2);
            p.fillRect(rect, colorIndex == 0 ? fillColor : fillColor2);
        }
    }

    QRect g = geometry();
    QString text;
    text += QString("Geometry: %1 %2 %3 %4\n").arg(g.x()).arg(g.y()).arg(g.width()).arg(g.height());

    QPen pen;
    pen.setColor(QColor(255, 255, 255, 200));
    p.setPen(pen);
    p.drawText(QRectF(0, 0, width(), height()), Qt::AlignCenter, text);
}
void RasterWindow::mouseMoveEvent(QMouseEvent * ev)
{
    if (!m_enableDrag)
        return;

    if (m_pressed)
        m_offset += ev->localPos().toPoint() - m_lastPos;
    m_lastPos = ev->localPos().toPoint();
    update();
}

void RasterWindow::mousePressEvent(QMouseEvent *)
{
    m_pressed = true;
}

void RasterWindow::mouseReleaseEvent(QMouseEvent *)
{
    m_pressed = false;
}
