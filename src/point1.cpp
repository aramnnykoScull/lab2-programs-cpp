#include "point_all.h"

int main() {
    int side;

    if (!read_int("Введите сторону квадрата: ", &side)) {
        return 1;
    }

    cout << "Площадь квадрата: " << side * side << endl;

    return 0;
}