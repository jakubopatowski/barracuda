#include <iostream>
#include <QApplication>
#include "mainwindow.h"

usin

int main(int argc, char* argv[]) {
    std::cout << "jajo" << std::endl;
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    return a.exec();
}
