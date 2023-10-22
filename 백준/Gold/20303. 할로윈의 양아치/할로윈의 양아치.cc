#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int find(vector<pair<int, int>>& uf, int n) {
    if (uf[n].first < 0) {
        return n;
    }
    uf[n].first = find(uf, uf[n].first);
    return uf[n].first;
}

void merge(vector<pair<int, int>>& uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        uf[rootX].first += uf[rootY].first;
        uf[rootY].first = rootX;
        uf[rootX].second += uf[rootY].second;
    }
}

int main() {
    int N, M, K;
    cin >> N >> M >> K;

    vector<int> candy(N);
    vector<pair<int, int>> uf(N, {-1, 1});
    for (int i = 0; i < N; ++i) {
        cin >> candy[i];
        uf[i].first = candy[i] * -1;
    }
    
    for (int i = 0; i < M; ++i) {
        int a, b;
        cin >> a >> b;
        --a;
        --b;
        merge(uf, a, b);
    }
    
    vector<int> nap(K + 1, 0);
    for (auto& p : uf) {
        if (p.first < 0) {
            int price = p.first * -1;
            for (int j = K-1; j >= 1; j--) {
                if (j >= p.second) {
                    nap[j] = max(nap[j], nap[j - p.second] + price);
                }
            }
        }
    }

    cout << nap[K-1] << endl;

    return 0;
}
