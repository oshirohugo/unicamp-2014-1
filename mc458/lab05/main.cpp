#include <iostream>
#include <vector>
#include <stdio.h>
using namespace std;


int select(vector<int> &v, int ini, int fim, int i);

int partition(vector<int> &v, int ini, int fim);

int main()
{

    ///reads size
    int size;
    cin >> size;
    vector<int> numbers(size);

    ///reads numbers
    int x, y;
    for (size_t i = 0; i < numbers.size(); i++) {
        scanf("%d %d", &x, &y);
        numbers[i] = y;

    }

    ///selects de median number
    int c = select(numbers, 0, numbers.size()-1, (numbers.size() / 2) + 1);
    ///prints value
    cout << c << "\n";

    return 0;
}

int select(vector<int> &v, int ini, int fim, int i) {
    if (ini == fim)
        return v[ini];
    int p = partition(v, ini, fim);
    int m = p - ini + 1;
    if (i == m)
        return v[p];
    if (i < m)
        return select(v, ini, p-1, i);
    if (i > m)
        return select(v, p+1, fim, i-m);
    return -1; ///just to compile without warning
}

int partition(vector<int> &v, int ini, int fim){
    int i = ini - 1;
    double pivo = v[fim];

    for (int j = ini; j <= fim; j++) {
        if(v[j] <= pivo) {
            swap(v[j], v[i + 1]);
            i++;
        }
    }
    return i;
}
