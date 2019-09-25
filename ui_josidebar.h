/********************************************************************************
** Form generated from reading UI file 'josidebar.ui'
**
** Created by: Qt User Interface Compiler version 4.8.7
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_JOSIDEBAR_H
#define UI_JOSIDEBAR_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QGridLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QPushButton>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_JoSideBar
{
public:
    QGridLayout *gridLayout;
    QGridLayout *mainLayout;
    QPushButton *dailyBtn;
    QPushButton *pushButton;
    QPushButton *weekBtn;
    QLabel *onlineIndicator;
    QPushButton *monthBtn;
    QPushButton *yearBtn;

    void setupUi(QWidget *JoSideBar)
    {
        if (JoSideBar->objectName().isEmpty())
            JoSideBar->setObjectName(QString::fromUtf8("JoSideBar"));
        JoSideBar->setEnabled(true);
        JoSideBar->resize(50, 482);
        JoSideBar->setMinimumSize(QSize(50, 0));
        JoSideBar->setMaximumSize(QSize(50, 16777215));
        JoSideBar->setSizeIncrement(QSize(50, 0));
        JoSideBar->setBaseSize(QSize(50, 0));
        gridLayout = new QGridLayout(JoSideBar);
        gridLayout->setSpacing(0);
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        gridLayout->setContentsMargins(0, 0, 0, 0);
        mainLayout = new QGridLayout();
        mainLayout->setObjectName(QString::fromUtf8("mainLayout"));
        mainLayout->setContentsMargins(5, 5, 5, 5);
        dailyBtn = new QPushButton(JoSideBar);
        dailyBtn->setObjectName(QString::fromUtf8("dailyBtn"));
        QSizePolicy sizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(dailyBtn->sizePolicy().hasHeightForWidth());
        dailyBtn->setSizePolicy(sizePolicy);
        dailyBtn->setMinimumSize(QSize(40, 40));
        dailyBtn->setMaximumSize(QSize(40, 40));

        mainLayout->addWidget(dailyBtn, 0, 0, 1, 1);

        pushButton = new QPushButton(JoSideBar);
        pushButton->setObjectName(QString::fromUtf8("pushButton"));
        QSizePolicy sizePolicy1(QSizePolicy::Fixed, QSizePolicy::Fixed);
        sizePolicy1.setHorizontalStretch(40);
        sizePolicy1.setVerticalStretch(40);
        sizePolicy1.setHeightForWidth(pushButton->sizePolicy().hasHeightForWidth());
        pushButton->setSizePolicy(sizePolicy1);
        pushButton->setMinimumSize(QSize(40, 40));
        pushButton->setMaximumSize(QSize(40, 40));

        mainLayout->addWidget(pushButton, 4, 0, 1, 1);

        weekBtn = new QPushButton(JoSideBar);
        weekBtn->setObjectName(QString::fromUtf8("weekBtn"));
        sizePolicy.setHeightForWidth(weekBtn->sizePolicy().hasHeightForWidth());
        weekBtn->setSizePolicy(sizePolicy);
        weekBtn->setMinimumSize(QSize(40, 40));
        weekBtn->setMaximumSize(QSize(40, 40));

        mainLayout->addWidget(weekBtn, 1, 0, 1, 1);

        onlineIndicator = new QLabel(JoSideBar);
        onlineIndicator->setObjectName(QString::fromUtf8("onlineIndicator"));
        onlineIndicator->setEnabled(true);
        QSizePolicy sizePolicy2(QSizePolicy::Fixed, QSizePolicy::Expanding);
        sizePolicy2.setHorizontalStretch(0);
        sizePolicy2.setVerticalStretch(0);
        sizePolicy2.setHeightForWidth(onlineIndicator->sizePolicy().hasHeightForWidth());
        onlineIndicator->setSizePolicy(sizePolicy2);
        onlineIndicator->setMinimumSize(QSize(40, 0));
        onlineIndicator->setMaximumSize(QSize(40, 16777215));
        onlineIndicator->setAutoFillBackground(false);
        onlineIndicator->setStyleSheet(QString::fromUtf8("QLabel{ background-color : green; }"));
        onlineIndicator->setFrameShape(QFrame::Box);
        onlineIndicator->setFrameShadow(QFrame::Plain);
        onlineIndicator->setMargin(1);

        mainLayout->addWidget(onlineIndicator, 5, 0, 1, 1);

        monthBtn = new QPushButton(JoSideBar);
        monthBtn->setObjectName(QString::fromUtf8("monthBtn"));
        sizePolicy.setHeightForWidth(monthBtn->sizePolicy().hasHeightForWidth());
        monthBtn->setSizePolicy(sizePolicy);
        monthBtn->setMinimumSize(QSize(40, 40));
        monthBtn->setMaximumSize(QSize(40, 40));

        mainLayout->addWidget(monthBtn, 2, 0, 1, 1);

        yearBtn = new QPushButton(JoSideBar);
        yearBtn->setObjectName(QString::fromUtf8("yearBtn"));
        sizePolicy.setHeightForWidth(yearBtn->sizePolicy().hasHeightForWidth());
        yearBtn->setSizePolicy(sizePolicy);
        yearBtn->setMinimumSize(QSize(40, 40));
        yearBtn->setMaximumSize(QSize(40, 40));

        mainLayout->addWidget(yearBtn, 3, 0, 1, 1);


        gridLayout->addLayout(mainLayout, 0, 0, 1, 1);


        retranslateUi(JoSideBar);

        QMetaObject::connectSlotsByName(JoSideBar);
    } // setupUi

    void retranslateUi(QWidget *JoSideBar)
    {
        JoSideBar->setWindowTitle(QApplication::translate("JoSideBar", "Form", 0, QApplication::UnicodeUTF8));
        dailyBtn->setText(QApplication::translate("JoSideBar", "24h", 0, QApplication::UnicodeUTF8));
        pushButton->setText(QApplication::translate("JoSideBar", "P", 0, QApplication::UnicodeUTF8));
        weekBtn->setText(QApplication::translate("JoSideBar", "7d", 0, QApplication::UnicodeUTF8));
        onlineIndicator->setText(QString());
        monthBtn->setText(QApplication::translate("JoSideBar", "1M", 0, QApplication::UnicodeUTF8));
        yearBtn->setText(QApplication::translate("JoSideBar", "1Y", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class JoSideBar: public Ui_JoSideBar {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_JOSIDEBAR_H
