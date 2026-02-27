#include "point_all.h"

int main() {
    int side_a, side_b, side_h;

    cout << "Для подсчета объема прямоугольного параллелепипеда введите три стороны: " << endl;
    
    if (!read_int("Введите сторону a (длина): ", &side_a) ||
        !read_int("Введите сторону b (ширина): ", &side_b) ||
        !read_int("Введите сторону h (высота): ", &side_h)) {
        return 1;
    }
    
    cout << "Объем прямоугольного параллелепипеда: " << side_a * side_b * side_h << endl;

    return 0;
}