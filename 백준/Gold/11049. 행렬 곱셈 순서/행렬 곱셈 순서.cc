#include <iostream>
#include <vector>
#include <climits>

using namespace std;

vector<pair<int, int>> li;
vector<vector<int>> dp;

int myFunc(int x, int y) {
    if (dp[x][y] != INT_MAX) {
        return dp[x][y];
    }

    if (x == y) {
        dp[x][y] = 0;
        return 0;
    }

    for (int i = x; i < y; ++i) {
        int xi = myFunc(x, i);
        int iy = myFunc(i + 1, y);
        dp[x][y] = min(dp[x][y], xi + iy + li[x].first * li[i].second * li[y].second);
    }

    return dp[x][y];
}

int main() {
    int K;
    cin >> K;
    li.resize(K);
    dp.resize(K, vector<int>(K, INT_MAX));

    for (int i = 0; i < K; ++i) {
        cin >> li[i].first >> li[i].second;
    }

    cout << myFunc(0, K - 1) << endl;

    return 0;
}
