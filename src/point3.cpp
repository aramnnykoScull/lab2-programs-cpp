#include "point_all.h"

int main() {
    int speed, time;

    cout << "Для подсчета пройденного расстояния введите скорость (в км/час) и время (в часах): " << endl;
    
    if (!read_int("Введите скорость (только число): ", &speed) ||
        !read_int("Введите время (только число): ", &time)) {
        return 1;
    }
    
    cout << "Пройденное расстояние: " << speed * time << " км" << endl;

    return 0;
}