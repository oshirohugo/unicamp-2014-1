//O algoritmo eh composto por um mergeSort de complexidade Teta(nlogn) seguido da
//parte que encontra o valor de h, que por percorrer o vetor apenas umas vez eh
// Teta(n), assim o mergeSort domina e o algoritmo eh Teta(nlogn)
#include <iostream>
#include <vector>

using namespace std;

int calc(vector<int> citations);
void mergeSort(vector<int> &array, int start, int end);
void merge(vector<int> &array, int start, int mid, int end);
void printVector(vector<int> &array);

int main()
{
    int size;

    cin >> size;
    vector<int> citations(size);

    for (int i = 0; i < size; i++)
        cin >> citations[i];

//    printVector(citations);
    mergeSort(citations, 0, citations.size()-1);
//    printVector(citations);


    cout << calc(citations) << endl;
    return 0;
}

int calc(vector<int> citations) {
    int index = 0;
    int number;
    int remain;
    int size = citations.size();
    int h;

    while(index < size) {
        number = citations[index];
        remain = size - index;
        if (number <= remain)
            h = number;
        index++;
    }

    return h;

}

void merge(vector<int> &array, int start, int mid, int end) {
    int i = start;
    int j = mid + 1;
    int k = start;
    vector<int> b(array.size());

    while (i <= mid && j <= end) {
        if (array[i] <= array[j])
            b[k++] = array[i++];
        else
            b[k++] = array[j++];
    }

    while(i <= mid)
        b[k++] = array[i++];

    while(j <= end)
        b[k++] = array[j++];

    for (k = start; k <= end; k++)
        array[k] = b[k];
}

void mergeSort(vector<int> &array, int start, int end) {
    if (start < end) {
        int mid = (end - start) / 2 + start;
        mergeSort(array, start, mid);
        mergeSort(array, mid + 1, end);
        merge(array, start, mid, end);
    }
}

void printVector(vector<int> &array) {
    for (unsigned int i = 0; i < array.size(); i++)
        cout << array[i] << " ";
    cout << "\n";
}


