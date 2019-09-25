#include "josidebar.h"
#include "ui_josidebar.h"

JoSideBar::JoSideBar(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::JoSideBar)
{
    ui->setupUi(this);
}

JoSideBar::~JoSideBar()
{
    delete ui;
}

void JoSideBar::setOnline( bool online )
{
    QString stylesheet = "QLabel{ background-color : %1; }";
    if( online ) {
        stylesheet.arg( "green" );
    }
    else {
        stylesheet.arg( "red" );
    }

    ui->onlineIndicator->setStyleSheet( stylesheet );
}

void JoSideBar::on_getDayily_clicked() {
    emit emitDaily();
}
