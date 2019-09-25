#ifndef JOSIDEBAR_H
#define JOSIDEBAR_H

#include <QWidget>

namespace Ui {
class JoSideBar;
}

class JoSideBar : public QWidget
{
    Q_OBJECT

public:
    explicit JoSideBar(QWidget *parent = nullptr);
    ~JoSideBar();

    void setOnline( bool online = true );

signals:
    void emitDayily();
    void emitWeekly();
    void emitMonthly();
    void emitYearly();
    void emitInterval();

private:
    Ui::JoSideBar *ui;

private slots:
    void on_getDayily_clicked();
    void on_getWeekly_clicked();
    void on_getMonthly_clicked();
    void on_getYearly_clicked();
    void on_getInterval_clicked();
};

#endif // JOSIDEBAR_H
