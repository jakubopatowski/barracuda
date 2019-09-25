#include <QApplication>
#include <iostream>
#include "mainwindow.h"
#include "sorting.hpp"

int main(int argc, char* argv[]) {
    std::cout << "jajo" << std::endl;
    Sorting sort;
    sort.print();
    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    
    return a.exec();
}
