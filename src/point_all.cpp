#include "point_all.h"

bool read_int(const string& prompt, int* value) {
    string input;
    cout << prompt;
    
    if (!getline(cin, input) || input.empty()) {
        cout << "Вы не ввели число" << endl;
        return false;
    }
    
    try {
        *value = stoi(input);
        if (*value <= 0) {
            cout << "Вы ввели некорректное число" << endl;
            return false;
        }
        return true;
    } catch (...) {
        cout << "Вы ввели не число" << endl;
        return false;
    }
}
