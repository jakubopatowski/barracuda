#include <QApplication>
#include <iostream>
#include "mainwindow.h"

int main(int argc, char* argv[]) {
    std::cout << "jajo" << std::endl;
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    return a.exec();
}
